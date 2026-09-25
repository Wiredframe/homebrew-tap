class Los < Formula
  desc "Tiny launcher for everything you installed in the terminal"
  homepage "https://github.com/Wiredframe/los"
  url "https://github.com/Wiredframe/los/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "aacd0f3317e82d6bd6439b18c6183e6df4420f3cba3647a0db02793dc8f2d385"
  license "MIT"

  depends_on "fzf"
  depends_on "jq"

  def install
    bin.install "los"
  end

  def caveats
    <<~EOS
      Add the shell integration so the picked command lands in your prompt:
        zsh:  echo 'eval "$(los --init zsh)"' >> ~/.zshrc
        bash: echo 'eval "$(los --init bash)"' >> ~/.bashrc
      For a nicer preview install a tldr client: brew install tlrc
    EOS
  end

  test do
    assert_match "los #{version}", shell_output("#{bin}/los --version")
  end
end
