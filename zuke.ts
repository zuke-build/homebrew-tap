// Copyright (c) 2026 the Zuke contributors
// SPDX-License-Identifier: MIT

/**
 * The tap's build: it checks itself, and verifies `Formula/zuke.rb` with the
 * real `brew` — and its CI workflow is generated from this file rather than
 * written by hand.
 *
 *   ./zuke ci                    # format, lint, type-check, workflow drift
 *   ./zuke verifyFormula         # audit, install and test the formula
 *   ./zuke generate-ci           # rewrite .github/workflows/tests.yml
 *   ./zuke generate-ci --check   # fail if the committed workflow drifted
 */
import {
  Build,
  cicd,
  discoverCiFiles,
  run,
  syncCiFiles,
  target,
} from "@zuke/core";
import { DenoTasks } from "@zuke/deno";
import { HomebrewTasks } from "@zuke/homebrew";
import { actionPins } from "./build/pins.ts";
import { verifyFormula } from "./build/verify_formula.ts";

/**
 * What a job that only bootstraps Deno and resolves its modules reaches: the
 * launcher's Deno download (deno.land, or GitHub's release assets) and JSR.
 */
const BOOTSTRAP_ENDPOINTS = [
  "deno.land:443",
  "dl.deno.land:443",
  "jsr.io:443",
  "github.com:443",
  "api.github.com:443",
  "codeload.github.com:443",
  "objects.githubusercontent.com:443",
  "release-assets.githubusercontent.com:443",
];

class Tap extends Build {
  format = target()
    .description("Check formatting (deno fmt --check)")
    .executes(async () => {
      await DenoTasks.fmt((s) => s.check());
    });

  lint = target()
    .description("Lint the build (deno lint)")
    .executes(async () => {
      await DenoTasks.lint();
    });

  typecheck = target()
    .description("Type-check the build (deno check)")
    .executes(async () => {
      await DenoTasks.check((s) => s.paths("zuke.ts", "build/"));
    });

  workflowsCheck = target()
    .description("Fail if a generated workflow drifted from zuke.ts")
    .executes(async () => {
      const results = await syncCiFiles(discoverCiFiles(this), {
        check: true,
      });
      const stale = results.filter((r) => r.status === "stale");
      if (stale.length > 0) {
        throw new Error(
          `out of date: ${stale.map((r) => r.path).join(", ")}. ` +
            `Run ./zuke generate-ci and commit the result.`,
        );
      }
    });

  ci = target()
    .description("The pull-request gate")
    .dependsOn(this.format, this.lint, this.typecheck, this.workflowsCheck)
    .executes(() => {});

  verifyFormula = target()
    .description("Audit, install and test Formula/zuke.rb with the real brew")
    .executes(() => verifyFormula("zuke"));

  // Every change, every push to main — the release pipeline commits the
  // formula there — and weekly, so a formula that stops installing (a moved
  // release asset, a Homebrew change) is caught without waiting for a release.
  testsWorkflow = cicd({
    pins: actionPins(),
    pipeline: {
      name: "Tests",
      triggers: {
        push: ["main"],
        pullRequest: [],
        manual: true,
        schedule: [{ cron: "17 6 * * 1" }],
      },
      concurrency: {
        group: "tests-${{ github.ref }}",
        cancelInProgress: true,
      },
    },
    invokes: [
      {
        target: this.ci,
        name: "Build & verify with Zuke",
        timeoutMinutes: 15,
        // Read-only token and no secrets; block egress anyway, since the job
        // only bootstraps Deno and resolves modules.
        harden: { egress: "block", allowedEndpoints: BOOTSTRAP_ENDPOINTS },
      },
      {
        // Both Mac CPU families, since each has its own signed binary.
        ...HomebrewTasks.verifyJob((s) =>
          s.target(this.verifyFormula)
            .runners("macos-latest", "macos-15-intel", "ubuntu-latest")
        ),
        // Audited rather than blocked: brew reaches its own API, its bottle
        // registry and the release assets, a set it decides. The job holds no
        // secrets and a read-only token.
        timeoutMinutes: 30,
      },
    ],
  });

  default = target()
    .description("Default: the pull-request gate")
    .dependsOn(this.ci)
    .executes(() => {});
}

await run(Tap);
