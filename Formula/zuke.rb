class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.1.1/zuke-2.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "7d99bc0ebe83e0e8e9947523928046775630431c7bc630161e6a7094493e35c4"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.1.1/zuke-2.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "a58fe08f4224876e435ef733464d214295c0c3bee52d500a71f9dab44ffc7f7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.1.1/zuke-2.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "58c18052c2f3af7a4cc00e072360c942396b2e1bae92dabb5a2b17ad4a7b2d8c"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.1.1/zuke-2.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a2a3a89948fae5eb5f294523fcd2a35b1765a639e7202561ddd098bfb5b94c6"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
