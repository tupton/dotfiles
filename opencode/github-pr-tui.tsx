/** @jsxImportSource @opentui/solid */

import { execFile } from "node:child_process";
import { createEffect, createMemo, createSignal, onCleanup } from "solid-js";
import type { TuiPlugin, TuiPluginApi, TuiPluginModule } from "@opencode-ai/plugin/tui";

import {
  isNoPullRequestError,
  parsePullRequest,
} from "./github-pr-status.mjs";

const REFRESH_INTERVAL_MS = 60_000;
const COMMAND_TIMEOUT_MS = 15_000;
const MAX_OUTPUT_BYTES = 1024 * 1024;
const GH_FIELDS = [
  "number",
  "url",
  "title",
  "isDraft",
  "state",
  "reviewDecision",
  "reviewRequests",
  "statusCheckRollup",
].join(",");

const STATUS_COLORS = {
  merged: "success",
  closed: "textMuted",
  draft: "textMuted",
  "checks-failing": "error",
  "checks-pending": "warning",
  "changes-requested": "error",
  approved: "success",
  "awaiting-review": "accent",
  ready: "primary",
} as const;

type PullRequest = ReturnType<typeof parsePullRequest>;
type PullRequestResult =
  | { kind: "loading" }
  | { kind: "none" }
  | { kind: "pull-request"; pullRequest: PullRequest }
  | { kind: "error"; message: string; pullRequest?: PullRequest };

type Listener = (result: PullRequestResult) => void;
type Channel = {
  key?: string;
  result: PullRequestResult;
  checkedAt: number;
  inFlight?: Promise<PullRequestResult>;
  queued?: Promise<PullRequestResult>;
  timer?: ReturnType<typeof setTimeout>;
  listeners: Set<Listener>;
};

type CommandResult = {
  ok: boolean;
  stdout: string;
  stderr: string;
  missing: boolean;
  timedOut: boolean;
};

function commandError(result: CommandResult, command: string) {
  if (result.timedOut) return `${command} request timed out`;
  const message = result.stderr.trim().split("\n")[0];
  return message || `${command} request failed`;
}

function pullRequestFromResult(result: PullRequestResult) {
  return result.kind === "pull-request" || result.kind === "error" ? result.pullRequest : undefined;
}

function runCommand(
  command: string,
  args: string[],
  directory: string,
  signal: AbortSignal,
): Promise<CommandResult> {
  return new Promise((resolve) => {
    try {
      execFile(
        command,
        args,
        {
          cwd: directory,
          encoding: "utf8",
          maxBuffer: MAX_OUTPUT_BYTES,
          timeout: COMMAND_TIMEOUT_MS,
          signal,
        },
        (error, stdout, stderr) => {
          resolve({
            ok: !error,
            stdout: String(stdout ?? ""),
            stderr: String(stderr ?? ""),
            missing: Boolean(error && "code" in error && error.code === "ENOENT"),
            timedOut: Boolean(error && "killed" in error && error.killed),
          });
        },
      );
    } catch (error) {
      resolve({
        ok: false,
        stdout: "",
        stderr: error instanceof Error ? error.message : String(error),
        missing: error instanceof Error && "code" in error && error.code === "ENOENT",
        timedOut: false,
      });
    }
  });
}

function sessionDirectory(api: TuiPluginApi, sessionID: string) {
  const sessionApi = api.state.session as typeof api.state.session & {
    get?: (id: string) => { directory?: string } | undefined;
  };
  return sessionApi.get?.(sessionID)?.directory || api.state.path.directory;
}

function createPullRequestStore(api: TuiPluginApi) {
  const channels = new Map<string, Channel>();
  const cache = new Map<string, PullRequestResult>();
  let ghMissing = false;

  const channelFor = (directory: string) => {
    let channel = channels.get(directory);
    if (channel) return channel;
    channel = {
      result: { kind: "loading" },
      checkedAt: 0,
      listeners: new Set(),
    };
    channels.set(directory, channel);
    return channel;
  };

  const publish = (channel: Channel, result: PullRequestResult) => {
    channel.result = result;
    for (const listener of channel.listeners) listener(result);
  };

  const failed = (channel: Channel, message: string): PullRequestResult => {
    const cached = channel.key ? cache.get(channel.key) : undefined;
    return {
      kind: "error",
      message,
      pullRequest: pullRequestFromResult(channel.result) ?? (cached && pullRequestFromResult(cached)),
    };
  };

  const load = async (directory: string, channel: Channel): Promise<PullRequestResult> => {
    const branchResult = await runCommand("git", ["branch", "--show-current"], directory, api.lifecycle.signal);
    if (api.lifecycle.signal.aborted) return channel.result;
    if (!branchResult.ok) return { kind: "error", message: commandError(branchResult, "Git") };
    const branch = branchResult.stdout.trim();
    if (!branch) {
      channel.key = undefined;
      return { kind: "none" };
    }

    const key = `${directory}\0${branch}`;
    if (channel.key !== key) {
      channel.key = key;
      publish(channel, cache.get(key) ?? { kind: "loading" });
    }

    if (ghMissing) {
      return failed(channel, "GitHub CLI is not installed");
    }

    const result = await runCommand(
      "gh",
      ["pr", "view", "--json", GH_FIELDS],
      directory,
      api.lifecycle.signal,
    );
    if (api.lifecycle.signal.aborted) return channel.result;
    if (!result.ok) {
      if (result.missing) {
        ghMissing = true;
        return failed(channel, "GitHub CLI is not installed");
      }
      if (isNoPullRequestError(result.stderr)) return { kind: "none" };
      return failed(channel, commandError(result, "GitHub CLI"));
    }

    try {
      return { kind: "pull-request", pullRequest: parsePullRequest(JSON.parse(result.stdout)) };
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      return failed(channel, message);
    }
  };

  const schedule = (directory: string, channel: Channel, delay = REFRESH_INTERVAL_MS) => {
    if (channel.timer) clearTimeout(channel.timer);
    if (channel.listeners.size === 0 || api.lifecycle.signal.aborted) {
      channel.timer = undefined;
      return;
    }
    channel.timer = setTimeout(() => {
      channel.timer = undefined;
      void refresh(directory, true);
    }, delay);
  };

  const refresh = (directory: string, force = false) => {
    const channel = channelFor(directory);
    if (channel.inFlight) {
      if (!force) return channel.inFlight;
      if (!channel.queued) {
        const inFlight = channel.inFlight;
        let queued: Promise<PullRequestResult>;
        queued = inFlight
          .finally(() => {
            if (channel.queued === queued) channel.queued = undefined;
          })
          .then(() => refresh(directory, true));
        channel.queued = queued;
      }
      return channel.queued;
    }

    const elapsed = Date.now() - channel.checkedAt;
    if (!force && elapsed < REFRESH_INTERVAL_MS) {
      schedule(directory, channel, REFRESH_INTERVAL_MS - elapsed);
      return Promise.resolve(channel.result);
    }

    if (channel.timer) {
      clearTimeout(channel.timer);
      channel.timer = undefined;
    }
    channel.checkedAt = Date.now();
    channel.inFlight = load(directory, channel)
      .then((result) => {
        if (api.lifecycle.signal.aborted) return result;
        if (channel.key) cache.set(channel.key, result);
        if (channel.queued) return result;
        publish(channel, result);
        return result;
      })
      .finally(() => {
        channel.inFlight = undefined;
        schedule(directory, channel);
      });
    return channel.inFlight;
  };

  const subscribe = (directory: string, listener: Listener) => {
    const channel = channelFor(directory);
    const activating = channel.listeners.size === 0;
    channel.listeners.add(listener);
    const unsubscribe = () => {
      channel.listeners.delete(listener);
      if (channel.listeners.size === 0 && channel.timer) {
        clearTimeout(channel.timer);
        channel.timer = undefined;
      }
    };
    if (activating) {
      publish(channel, { kind: "loading" });
      void refresh(directory, true);
      return unsubscribe;
    }
    listener(channel.result);
    void refresh(directory);
    return unsubscribe;
  };

  const get = (directory: string) => channelFor(directory).result;

  const refreshAll = () => {
    for (const [directory, channel] of channels) {
      if (channel.listeners.size === 0) continue;
      publish(channel, { kind: "loading" });
      void refresh(directory, true);
    }
  };

  const open = async (directory: string, pullRequest: PullRequest) => {
    const result = await runCommand(
      "gh",
      ["pr", "view", pullRequest.url, "--web"],
      directory,
      api.lifecycle.signal,
    );
    if (!result.ok && !api.lifecycle.signal.aborted) {
      api.ui.toast({ variant: "error", title: "GitHub PR", message: commandError(result, "GitHub CLI") });
    }
  };

  api.lifecycle.onDispose(() => {
    for (const channel of channels.values()) {
      if (channel.timer) clearTimeout(channel.timer);
    }
  });
  api.event.on("vcs.branch.updated", refreshAll);
  api.event.on("session.idle", (event) => {
    const directory = sessionDirectory(api, event.properties.sessionID);
    if (directory) void refresh(directory);
  });

  return { get, open, refresh, subscribe };
}

type PullRequestStore = ReturnType<typeof createPullRequestStore>;

function usePullRequest(api: TuiPluginApi, store: PullRequestStore, sessionID: string) {
  const [result, setResult] = createSignal<PullRequestResult>({ kind: "loading" });
  const directory = createMemo(() => sessionDirectory(api, sessionID));

  createEffect(() => {
    const current = directory();
    if (!current) {
      setResult({ kind: "none" });
      return;
    }
    const unsubscribe = store.subscribe(current, setResult);
    onCleanup(unsubscribe);
  });

  return { directory, result };
}

function statusColor(theme: TuiPluginApi["theme"]["current"], status: PullRequest["status"]) {
  return theme[STATUS_COLORS[status]];
}

function PromptIndicator(props: {
  api: TuiPluginApi;
  store: PullRequestStore;
  sessionID: string;
  theme: TuiPluginApi["theme"];
}) {
  const state = usePullRequest(props.api, props.store, props.sessionID);
  const pullRequest = createMemo(() => {
    return pullRequestFromResult(state.result());
  });

  return (
    <text
      fg={pullRequest() ? statusColor(props.theme.current, pullRequest()!.status) : props.theme.current.textMuted}
      onMouseUp={() => {
        const current = pullRequest();
        if (current) void props.store.open(state.directory(), current);
      }}
    >
      {pullRequest() ? `PR #${pullRequest()!.number}` : ""}
    </text>
  );
}

function activeDirectory(api: TuiPluginApi) {
  const route = api.route.current;
  if (route.name !== "session") return;
  return sessionDirectory(api, route.params.sessionID);
}

async function refreshActive(api: TuiPluginApi, store: PullRequestStore) {
  const directory = activeDirectory(api);
  if (!directory) {
    api.ui.toast({ variant: "warning", title: "GitHub PR", message: "Open a session before refreshing PR status" });
    return;
  }

  const result = await store.refresh(directory, true);
  if (result.kind === "pull-request") {
    api.ui.toast({ variant: "success", title: "GitHub PR", message: `Refreshed PR #${result.pullRequest.number}` });
    return;
  }
  if (result.kind === "none") {
    api.ui.toast({ variant: "info", title: "GitHub PR", message: "No pull request for the current branch" });
    return;
  }
  if (result.kind === "error") {
    api.ui.toast({ variant: "error", title: "GitHub PR", message: result.message });
  }
}

async function openActive(api: TuiPluginApi, store: PullRequestStore) {
  const directory = activeDirectory(api);
  if (!directory) {
    api.ui.toast({ variant: "warning", title: "GitHub PR", message: "Open a session before opening a PR" });
    return;
  }

  let result = store.get(directory);
  if (result.kind !== "pull-request") result = await store.refresh(directory, true);
  const pullRequest = pullRequestFromResult(result);
  if (pullRequest) {
    await store.open(directory, pullRequest);
    return;
  }
  if (result.kind === "none") {
    api.ui.toast({ variant: "info", title: "GitHub PR", message: "No pull request for the current branch" });
    return;
  }
  if (result.kind === "error") {
    api.ui.toast({ variant: "error", title: "GitHub PR", message: result.message });
  }
}

function registerCommands(api: TuiPluginApi, store: PullRequestStore) {
  api.lifecycle.onDispose(api.command.register(() => [
    {
      title: "GitHub PR: Open",
      value: "github-pr.open",
      category: "GitHub",
      onSelect: () => void openActive(api, store),
    },
    {
      title: "GitHub PR: Refresh",
      value: "github-pr.refresh",
      category: "GitHub",
      onSelect: () => void refreshActive(api, store),
    },
  ]));
}

const tui: TuiPlugin = async (api) => {
  const store = createPullRequestStore(api);
  registerCommands(api, store);
  api.slots.register({
    order: 50,
    slots: {
      session_prompt_right(ctx, props) {
        return <PromptIndicator api={api} store={store} sessionID={props.session_id} theme={ctx.theme} />;
      },
    },
  });
};

const plugin: TuiPluginModule & { id: string } = {
  id: "github-pr-status",
  tui,
};

export default plugin;
