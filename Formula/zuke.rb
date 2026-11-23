class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.8.0/zuke-2.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "abb144adec607a381ce1e7fe19847b395356aabd845c5245013f7ed74f7e5a9b"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.8.0/zuke-2.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "704fdfbff33cddbc3a58dadf16572f078b1fa13730bd5986ff4a91b20c13f678"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.8.0/zuke-2.8.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bd60844d48c15cac08254ed6fba8bb907444ebd6ab970012de112ce8ebade149"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.8.0/zuke-2.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9323ebd9a14713e53b36b5309a7988532bf0298f36deb943afec4e3682c7ecc3"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
