class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.6.0/zuke-2.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "572dbd7c4866520590a076965cc45fd4ae3e9ef27c143e63a0283a93d822a6e9"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.6.0/zuke-2.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "1d830d479b82e329d925f5ffc05809fea257858971538c2b5c407b0f911d8038"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.6.0/zuke-2.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c82d92efc26d221db3a997f5ebb06b939e8f818c274b60f524a9969f60090e56"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.6.0/zuke-2.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "724dfabda0205dce345c4184ed8cb5f6207e92bc8b806174ad0fc2350f49d4f5"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
