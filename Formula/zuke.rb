class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.5.0/zuke-2.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "7b773e45a0db38fad87ff336fb558c7fa322f943dbb769ccd6bf7d233b9bc3e2"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.5.0/zuke-2.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "f2bbe2beeaa3f87b220db9fce8dcb677a20d11b320f141174d5e7184b493e392"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.5.0/zuke-2.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2e2d022418dd129f922606f17a2f0a6aa569d826b67fb50680c61a5edeb9308f"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.5.0/zuke-2.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb6e645b41094071845db486b4a0962482a5913a0a11f0660cf8a9518847a43e"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
