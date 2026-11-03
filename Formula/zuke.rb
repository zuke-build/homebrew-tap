class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.2.0/zuke-2.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "38bfd4f507de8c8b6193eb392563e29bd07680742bf981dd82d1e8fd04c1a8eb"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.2.0/zuke-2.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "7302e0d696d669bd1db28c6e4759f20c8e8f2da4a6967088658ec311828e2cbb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.2.0/zuke-2.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0673f04f6e85f3850a26c6d755232431eb4b69ea680d0b6c1f4098e9ccff9c56"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.2.0/zuke-2.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1557428e406bdf7d027b2a02c3f00947620f72a280829109a8653a3fae5533fe"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
