import assert from "node:assert/strict";
import test from "node:test";

import {
  classifyPullRequest,
  isNoPullRequestError,
  parsePullRequest,
} from "./github-pr-status.mjs";

const base = {
  number: 123,
  url: "https://github.com/example/project/pull/123",
  title: "Show the current pull request in OpenCode",
  isDraft: false,
  state: "OPEN",
  reviewDecision: "",
  reviewRequests: [],
  statusCheckRollup: [],
};

test("parses GitHub check runs and status contexts", () => {
  const pullRequest = parsePullRequest({
    ...base,
    reviewRequests: [{ login: "reviewer" }],
    statusCheckRollup: [
      { __typename: "CheckRun", status: "COMPLETED", conclusion: "SUCCESS" },
      { __typename: "CheckRun", status: "COMPLETED", conclusion: "SKIPPED" },
      { __typename: "CheckRun", status: "COMPLETED", conclusion: "NEUTRAL" },
      { __typename: "CheckRun", status: "IN_PROGRESS", conclusion: "" },
      { __typename: "CheckRun", status: "COMPLETED", conclusion: "FAILURE" },
      { __typename: "StatusContext", state: "ERROR" },
    ],
  });

  assert.deepEqual(pullRequest.checks, { passed: 3, pending: 1, failed: 2 });
  assert.equal(pullRequest.reviewRequests, 1);
  assert.equal(pullRequest.status, "checks-failing");
});

test("applies compact status precedence", () => {
  const cases = [
    [{ ...base, state: "MERGED", isDraft: true }, "merged"],
    [{ ...base, state: "CLOSED", isDraft: true }, "closed"],
    [{ ...base, isDraft: true, statusCheckRollup: [{ conclusion: "FAILURE", status: "COMPLETED" }] }, "draft"],
    [{ ...base, statusCheckRollup: [{ conclusion: "FAILURE", status: "COMPLETED" }] }, "checks-failing"],
    [{ ...base, statusCheckRollup: [{ conclusion: "", status: "IN_PROGRESS" }] }, "checks-pending"],
    [{ ...base, reviewDecision: "CHANGES_REQUESTED" }, "changes-requested"],
    [{ ...base, reviewDecision: "APPROVED" }, "approved"],
    [{ ...base, reviewDecision: "REVIEW_REQUIRED" }, "awaiting-review"],
    [{ ...base, reviewRequests: [{ login: "reviewer" }] }, "awaiting-review"],
    [base, "ready"],
  ];

  for (const [value, expected] of cases) {
    assert.equal(classifyPullRequest(parsePullRequest(value)), expected);
  }
});

test("rejects malformed pull request responses", () => {
  assert.throws(() => parsePullRequest({ ...base, number: "123" }), /number/);
  assert.throws(() => parsePullRequest({ ...base, url: "" }), /url/);
  assert.throws(() => parsePullRequest({ ...base, statusCheckRollup: {} }), /statusCheckRollup/);
});

test("recognizes expected no-PR errors", () => {
  assert.equal(isNoPullRequestError("no pull requests found for branch main"), true);
  assert.equal(isNoPullRequestError("could not determine current branch: not on any branch"), true);
  assert.equal(isNoPullRequestError("HTTP 401: Bad credentials"), false);
});
