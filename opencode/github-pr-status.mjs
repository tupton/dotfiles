const PASSED_CHECK_STATES = new Set(["SUCCESS", "SKIPPED", "NEUTRAL"]);
const PENDING_CHECK_STATES = new Set(["EXPECTED", "PENDING", "QUEUED", "IN_PROGRESS", "WAITING", "REQUESTED"]);

export const STATUS_PRECEDENCE = [
  ["merged", (pullRequest) => pullRequest.state === "MERGED"],
  ["closed", (pullRequest) => pullRequest.state === "CLOSED"],
  ["draft", (pullRequest) => pullRequest.isDraft],
  ["checks-failing", (pullRequest) => pullRequest.checks.failed > 0],
  ["checks-pending", (pullRequest) => pullRequest.checks.pending > 0],
  ["changes-requested", (pullRequest) => pullRequest.reviewDecision === "CHANGES_REQUESTED"],
  ["approved", (pullRequest) => pullRequest.reviewDecision === "APPROVED"],
  [
    "awaiting-review",
    (pullRequest) => pullRequest.reviewDecision === "REVIEW_REQUIRED" || pullRequest.reviewRequests > 0,
  ],
];

function requiredString(value, field) {
  if (typeof value !== "string" || !value.trim()) {
    throw new Error(`GitHub PR response has an invalid ${field}`);
  }
  return value;
}

function optionalString(value) {
  return typeof value === "string" ? value : "";
}

function checkState(check) {
  if (!check || typeof check !== "object" || Array.isArray(check)) {
    return "failed";
  }

  const conclusion = optionalString(check.conclusion).toUpperCase();
  const state = optionalString(check.state).toUpperCase();
  const status = optionalString(check.status).toUpperCase();

  if (PASSED_CHECK_STATES.has(conclusion) || PASSED_CHECK_STATES.has(state)) {
    return "passed";
  }
  if (PENDING_CHECK_STATES.has(state) || PENDING_CHECK_STATES.has(status)) {
    return "pending";
  }
  return "failed";
}

function countChecks(checks) {
  const summary = { passed: 0, pending: 0, failed: 0 };
  for (const check of checks) {
    summary[checkState(check)] += 1;
  }
  return summary;
}

export function classifyPullRequest(pullRequest) {
  for (const [status, matches] of STATUS_PRECEDENCE) {
    if (matches(pullRequest)) return status;
  }
  return "ready";
}

export function parsePullRequest(value) {
  if (!value || typeof value !== "object" || Array.isArray(value)) {
    throw new Error("GitHub PR response is not an object");
  }
  if (!Number.isInteger(value.number) || value.number <= 0) {
    throw new Error("GitHub PR response has an invalid number");
  }
  if (!Array.isArray(value.statusCheckRollup)) {
    throw new Error("GitHub PR response has an invalid statusCheckRollup");
  }
  if (value.reviewRequests !== undefined && !Array.isArray(value.reviewRequests)) {
    throw new Error("GitHub PR response has invalid reviewRequests");
  }

  const pullRequest = {
    number: value.number,
    url: requiredString(value.url, "url"),
    title: requiredString(value.title, "title"),
    isDraft: Boolean(value.isDraft),
    state: optionalString(value.state).toUpperCase(),
    reviewDecision: optionalString(value.reviewDecision).toUpperCase(),
    reviewRequests: value.reviewRequests?.length ?? 0,
    checks: countChecks(value.statusCheckRollup),
  };
  pullRequest.status = classifyPullRequest(pullRequest);
  return pullRequest;
}

export function isNoPullRequestError(stderr) {
  const message = stderr.toLowerCase();
  return (
    message.includes("no pull requests found") ||
    message.includes("could not find pull request") ||
    message.includes("no open pull requests") ||
    message.includes("could not determine current branch")
  );
}
