// Copyright (c) 2026 the Zuke contributors
// SPDX-License-Identifier: MIT

/**
 * Audit, install and test a formula of this tap with the real `brew`, and on
 * macOS check that the binary it installed is Developer ID signed.
 *
 * `HomebrewTasks.verify` installs, tests and uninstalls in one call, so the
 * installed binary is gone before its signature could be read. This runs the
 * same steps through `BrewTasks` instead, with the audit and the signature
 * check in between:
 *
 * 1. `brew tap-new --no-git zuke-verify/tap-<random>` — current Homebrew only
 *    installs formulae that live in a tap, so the formula is copied into a
 *    throwaway one rather than installed by path
 * 2. `brew audit --strict --formula <tap>/<name>`
 * 3. `brew install --formula <tap>/<name>`, then `brew test <tap>/<name>`
 * 4. on macOS: `codesign --verify --strict` and `codesign --display` on the
 *    installed binary, refusing a leaf authority that is not
 *    `Developer ID Application: …`
 * 5. `brew uninstall` (once installed) and `brew untap --force` — always,
 *    whether or not the steps before succeeded
 *
 * Homebrew installs without the quarantine flag, so running the installed
 * binary never consults Gatekeeper; the signature is checked directly instead.
 *
 * @module
 */

import { CodesignTasks } from "@zuke/apple";
import { FileTasks } from "@zuke/core";
import { type BrewSettings, BrewTasks } from "@zuke/homebrew";

/** The environment every `brew` call runs with: check this formula, nothing else. */
const BREW_ENV = {
  HOMEBREW_NO_AUTO_UPDATE: "1",
  HOMEBREW_NO_ENV_HINTS: "1",
  HOMEBREW_NO_ANALYTICS: "1",
};

/** The leaf certificate every macOS binary of the formula must be signed with. */
const DEVELOPER_ID = "Developer ID Application: ";

/** Apply the shared environment to one `brew` call. */
function brew<S extends BrewSettings>(settings: S): S {
  return settings.env(BREW_ENV);
}

/**
 * Run `steps` in order, every one even when an earlier one failed, and raise
 * what failed: the one error itself, or an `AggregateError` of several.
 */
async function runAll(steps: Array<() => Promise<unknown>>): Promise<void> {
  const errors: unknown[] = [];
  for (const step of steps) {
    try {
      await step();
    } catch (error) {
      errors.push(error);
    }
  }
  if (errors.length === 1) throw errors[0];
  if (errors.length > 1) {
    throw new AggregateError(errors, "verifying the formula failed");
  }
}

/**
 * Check the installed formula's binary is Developer ID signed.
 *
 * @throws {Error} when `codesign` rejects the signature, or its leaf
 * authority is not a Developer ID Application certificate.
 */
async function verifySignature(
  qualified: string,
  binary: string,
): Promise<void> {
  const prefix = await BrewTasks.run((s) =>
    brew(s).quiet().command("--prefix", qualified)
  );
  const path = await Deno.realPath(`${prefix.stdout.trim()}/bin/${binary}`);
  await CodesignTasks.verify((s) => s.strict().verbose(2).file(path));
  const display = await CodesignTasks.display((s) => s.verbose(4).file(path));
  const [leaf] = display.authorities;
  if (leaf === undefined || !leaf.startsWith(DEVELOPER_ID)) {
    throw new Error(
      `${path} is not signed with a Developer ID (authorities: ` +
        `${display.authorities.join(", ") || "none"}).`,
    );
  }
  console.log(`${path}: signed by ${leaf}.`);
}

/**
 * Audit, install and test `Formula/<name>.rb`, then remove it again; on
 * macOS, also check the signature of the `bin/<name>` it installed.
 */
export async function verifyFormula(name: string): Promise<void> {
  const source = await FileTasks.readText(`Formula/${name}.rb`);
  const tap = `zuke-verify/tap-${crypto.randomUUID().slice(0, 8)}`;
  const qualified = `${tap}/${name}`;

  await BrewTasks.tapNew((s) => brew(s).name(tap).noGit());
  let installed = false;
  await runAll([
    async () => {
      const directory = await BrewTasks.repository((s) => brew(s).tap(tap));
      await FileTasks.writeText(`${directory}/Formula/${name}.rb`, source);
      await BrewTasks.audit((s) =>
        brew(s).strict().formula().formulae(qualified)
      );
      await BrewTasks.install((s) => brew(s).formula().formulae(qualified));
      // Only after it succeeded: uninstalling a keg that is not there fails
      // and would bury the install's own error. A half-finished install is
      // still removed — `untap --force` uninstalls whatever the tap installed.
      installed = true;
      await BrewTasks.test((s) => brew(s).formulae(qualified));
      if (Deno.build.os === "darwin") await verifySignature(qualified, name);
    },
    async () => {
      if (installed) {
        await BrewTasks.uninstall((s) =>
          brew(s).formula().force().formulae(qualified)
        );
      }
    },
    () => BrewTasks.untap((s) => brew(s).force().taps(tap)),
  ]);
}
