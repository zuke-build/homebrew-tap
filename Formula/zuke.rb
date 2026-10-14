class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.15.1/zuke-1.15.1-aarch64-apple-darwin.tar.gz"
      sha256 "fadd11f49fd6e46dbd6662656fddd73ee503220f76061c68e155dd7202d3e5ee"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.15.1/zuke-1.15.1-x86_64-apple-darwin.tar.gz"
      sha256 "b79f3d584031ea09c9ff7c80f0381fa33f9f682e90dfeb669c7f01e133d35c09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.15.1/zuke-1.15.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c34063a4414fa7706224102cb3310b60232af13fe061546cd98db1c3e2997ee8"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.15.1/zuke-1.15.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d792fac487d5347702690671bd4a4b27b56b13e97f82e0e4974e39c704119b23"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
