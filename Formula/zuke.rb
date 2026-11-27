class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.9.0/zuke-2.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "2fc04f6933fcd18316ccd848d040751c40198fcc28a1cf0601549f39e307af62"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.9.0/zuke-2.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "7b40b5d4c1e52a532d0784ddee73e8bd38366da664ffc3862c8607f6c5f1f681"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.9.0/zuke-2.9.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c81ad0b4632f5b46721b649ab330379c020d2bfb5e0b2e5a19b2ef47e4ffe096"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.9.0/zuke-2.9.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "021026052d6db94628a5e787cd356ce2b73b88524cf7a2b5a52ae3de801c066f"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
