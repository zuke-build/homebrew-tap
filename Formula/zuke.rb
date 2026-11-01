class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.0.0/zuke-2.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "4732d7f3631cfa3f5ad9eea5395373dece96a10c1cf0b859e8098c02fc215e72"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.0.0/zuke-2.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "57f8350731ab69d3cabb469597d30d6f83d0e0d8fe92ead6cf227b2b9e3b9e35"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.0.0/zuke-2.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee1e7fa301e3d802e249235ebcbde5653bc0a19878cadf1cc6648235acf3341a"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.0.0/zuke-2.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "70802b318c8b26783ca5d9f9afde9a878df67b5a63b78602b07f0f5c1f78249d"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
