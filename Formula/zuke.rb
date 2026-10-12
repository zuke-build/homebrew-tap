class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.14.0/zuke-1.14.0-aarch64-apple-darwin.tar.gz"
      sha256 "4535112d4dec056e22ead6c81f147a64ab85bf1cf10a83ef8df985de2d80781b"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.14.0/zuke-1.14.0-x86_64-apple-darwin.tar.gz"
      sha256 "8609b80d7af12690ab8080eec3048a4f1cb5c1c3c5c7ae22d9dbb0f79a86b62d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.14.0/zuke-1.14.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6459fb27810c0372a4a663eecaaf807f0fcc7070fd24cc475829cd6a6a73b2a8"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v1.14.0/zuke-1.14.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ea78c95b6ed7bead878431a7c485ab11d662ad2d633d3a468faa48f653ee7112"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
