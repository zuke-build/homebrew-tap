class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.7.0/zuke-2.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "c9c0fc2c50adab0db8fdf55dd4505acd0b35bf03b008035bc4bf0b35025ea4cd"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.7.0/zuke-2.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "195f28b7c13f1613989e1b7590a182c381748007ca2fd0800365240528a07003"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.7.0/zuke-2.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e679ea4eea3ccd5fcd43950644118034855a8edbe53d0445cd01d2c0281b3087"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.7.0/zuke-2.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "729d98af7015191c6aa2d5a2cdb25aaba38545b52675b4cd5e00f4ec7d373700"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
