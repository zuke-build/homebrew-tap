class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.3.0/zuke-2.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "742adc9cd5e0d3d3c21f0a1b1c94433eb98ed5261ddd8b12f88cfab5cca663b4"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.3.0/zuke-2.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "d08439ec5ac25062367bd1fa44a709d4befe92443de009a6c21cacbf7a2ec823"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.3.0/zuke-2.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e689e601b02c9bdead579428dd98e6a52207b1072fd4865cdcadf5a8dbabca48"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.3.0/zuke-2.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d751c29ed7a5002f23213422ef76ee3f980e3d2e288e9dd59615bbdc04bd95e9"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
