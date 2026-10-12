# zuke-build/homebrew-tap

The [Homebrew](https://brew.sh) tap for **[Zuke](https://zuke.build)**, the
code-first, strongly-typed build automation system for Deno.

```sh
brew install zuke-build/tap/zuke
```

This installs the `zuke` command as a standalone, signed binary for macOS
(Apple silicon and Intel) and Linux (arm64 and x86_64). It needs **no Deno up
front**: `zuke setup` scaffolds a project right away, and the `./zuke` launcher
it writes installs a pinned, checksum-verified Deno the first time the build
runs.

```sh
zuke setup        # scaffold zuke.ts and the ./zuke launcher
./zuke            # run the build
zuke --version    # on a terminal, names the install that answered
brew upgrade zuke # update
```

Installing from JSR (`deno install -A -g -n zuke jsr:@zuke/cli`) remains the
main route and gives the same CLI; see
[installing](https://github.com/zuke-build/zuke/blob/master/docs/install.md)
for both, side by side.

## How this tap is maintained

`Formula/zuke.rb` is **generated** — do not edit it by hand. Each `@zuke/cli`
release in [zuke-build/zuke](https://github.com/zuke-build/zuke) runs a release
pipeline that:

1. compiles the binaries from the published `jsr:@zuke/cli@<version>`;
2. signs the macOS binaries with a Developer ID under the hardened runtime and
   notarizes them with Apple;
3. uploads the archives, a `SHA256SUMS` manifest and a build-provenance
   attestation to the `cli-v<version>` GitHub release;
4. renders this formula from the published checksums and installs and tests it
   with the real `brew` on macOS and Linux;
5. only then commits the formula here.

The `tests` workflow in this repository installs and tests the formula again on
every change and weekly, so a Homebrew change that breaks the install shows up
without waiting for a release.

A problem with the formula belongs in
[zuke-build/zuke's issues](https://github.com/zuke-build/zuke/issues), where
the generator lives.

## Verifying what you install

Homebrew checks every archive against the SHA-256 the formula pins. Each
archive is also attested by the release workflow, and the macOS binaries are
Developer ID signed and notarized:

```sh
gh attestation verify zuke-<version>-<target>.tar.gz \
  --repo zuke-build/zuke \
  --signer-workflow zuke-build/zuke/.github/workflows/release.yml \
  --source-ref refs/heads/master
codesign --verify --strict --verbose=2 "$(brew --prefix)/bin/zuke"
```

More, including verifying without the GitHub CLI, in
[verifying a download](https://github.com/zuke-build/zuke/blob/master/docs/install.md#verifying-a-download).

## License

MIT — see [LICENSE](LICENSE).
