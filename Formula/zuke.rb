class Zuke < Formula
  desc "Code-first, strongly-typed build automation for Deno"
  homepage "https://zuke.build"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.9.1/zuke-2.9.1-aarch64-apple-darwin.tar.gz"
      sha256 "8e35ca5e9ed6476ca6b4b80fddd09318f70173f86827406d1797e3a27350ef58"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.9.1/zuke-2.9.1-x86_64-apple-darwin.tar.gz"
      sha256 "a210bfd64bf6b48e47bdc149ac12725f4ddc1fdcd23733d71a7cd97f415009e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.9.1/zuke-2.9.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "be42ab83376184061a30b661209dac0e2f9d7b0b13f9308b2f23e908fb643e2a"
    end

    on_intel do
      url "https://github.com/zuke-build/zuke/releases/download/cli-v2.9.1/zuke-2.9.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2998e2cb271c44bd026bf44b13c47d67ac0ec2b5553377e054fa805fccf3f1a8"
    end
  end

  def install
    bin.install "zuke"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zuke --version")
  end
end
