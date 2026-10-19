class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.17.0/zuke-1.17.0-aarch64-apple-darwin.tar.gz"
      sha256 "c736e3c1d617c11825a0c27819c608fdbb4d8dd7f83cd868497cb13f3334f6c1"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.17.0/zuke-1.17.0-x86_64-apple-darwin.tar.gz"
      sha256 "15f0dd5a3dfda2fb51efcfd1b7e6b65da76673636502a8f2c37b3e2d6f0f43a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.17.0/zuke-1.17.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f038de41861eeb5dff2826362a59dcf6bc601933740d59409782fbbe33d57b36"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.17.0/zuke-1.17.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "14c13cc2f6e26d5348a0889d02544ddf7ae9c96b13898508e0534d513a9af2bb"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
