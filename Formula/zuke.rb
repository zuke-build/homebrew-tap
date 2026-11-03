class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.1.0/zuke-2.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "e757641eade1029896e80a59b7edfeff3dd79a489521fa38c382b5e85883a998"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.1.0/zuke-2.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "fb7c6f15d7af34b9c162d9d8cfd427344a1823913a2de73bc52c0f2576740b57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.1.0/zuke-2.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "569dede4d8b64842af393c56bd7727b1a759195aef74eb16000d010cf98ff9da"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.1.0/zuke-2.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "82e1d4b78e47416fa5ae62d11fee2951817b059f6f422a334c494ce782643d90"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
