class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.4.0/zuke-2.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "925f71aac4cfe8e7fe3e15266f32732f7fe533d240c30142e3b428116f9afe0c"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.4.0/zuke-2.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "9f8bea39f96502d3f2987685328c3650273326884c90a74cca90e5b311239dc8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.4.0/zuke-2.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b62aa9ec9065a6990693448833b169d5ae31894715b737bfdc2521c6fb13315e"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.4.0/zuke-2.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7fefb3291b1d4bb697b72b832864642f97c142d923d9dd380d73201652595f2"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
