// Copyright (c) 2026 the Zuke contributors
// SPDX-License-Identifier: MIT

/**
 * Where the generated workflow's pinned action SHAs come from.
 *
 * Dependabot (`.github/dependabot.yml`) bumps the SHA-pinned actions in
 * `.github/workflows/*.yml` weekly — but those files are generated, so a bump
 * would be reverted by the next `./zuke generate-ci`, and `generate-ci --check`
 * would fail the bump's own pull request. Reading the pins back out of the
 * committed workflows closes that loop: a bot edits the YAML, the generator
 * writes the same SHA again, and the check passes.
 *
 * The seeds cover an action no committed workflow mentions yet. They go stale
 * by design; once a workflow carries the action, that file wins.
 *
 * @module
 */

import type { CiActionRef, CiPinResolver } from "@zuke/core";

/** Where the generated workflows live. */
const WORKFLOW_DIR = ".github/workflows";

/** A pinned `uses:` line: the action, its 40-hex SHA, and the version comment. */
const USES_LINE =
  /^\s*(?:-\s+)?uses:\s*([\w.-]+\/[\w.\-/]+)@([0-9a-f]{40})\s*(?:#\s*(\S+))?/;

/** The pins to start from, matching the zuke-build/zuke monorepo's. */
const SEED_PINS: Readonly<Record<string, CiActionRef>> = {
  "zuke-build/zuke": {
    ref: "zuke-build/zuke@2478fa5a69fb4f16540e54959c98cd976ec3f075",
    version: "v1.0.5",
  },
  "step-security/harden-runner": {
    ref: "step-security/harden-runner@e14015d583714f6e62063499dc959a02595150a1",
    version: "v2.21.1",
  },
  "actions/checkout": {
    ref: "actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1",
    version: "v7.0.1",
  },
};

/** Every pinned `uses:` in the committed workflows, keyed by action. */
function committedPins(dir: string): Map<string, CiActionRef> {
  const pins = new Map<string, CiActionRef>();
  let names: string[];
  try {
    names = [...Deno.readDirSync(dir)]
      .filter((entry) => entry.isFile && /\.ya?ml$/.test(entry.name))
      .map((entry) => entry.name)
      .sort();
  } catch (error) {
    if (error instanceof Deno.errors.NotFound) return pins;
    throw error;
  }
  for (const name of names) {
    const text = Deno.readTextFileSync(`${dir}/${name}`);
    for (const line of text.split("\n")) {
      const match = USES_LINE.exec(line);
      if (match === null) continue;
      const [, action, sha, version] = match;
      const seen = pins.get(action);
      const ref = `${action}@${sha}`;
      if (seen !== undefined && seen.ref !== ref) {
        throw new Error(
          `action pins disagree for ${action}: ${seen.ref} and ${ref}. ` +
            `Edit the workflows so both name the same SHA, then run ` +
            `./zuke generate-ci.`,
        );
      }
      pins.set(action, { ref, version });
    }
  }
  return pins;
}

/**
 * Resolve an action's pin: the committed workflows first, then the seeds.
 *
 * @throws {Error} for an action neither knows — add it to the seeds.
 */
export function actionPins(dir: string = WORKFLOW_DIR): CiPinResolver {
  const committed = committedPins(dir);
  return (action) => {
    const pin = committed.get(action) ?? SEED_PINS[action];
    if (pin === undefined) {
      throw new Error(`no pinned SHA for ${action}: add it to build/pins.ts.`);
    }
    return pin;
  };
}
