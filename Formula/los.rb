class Los < Formula
  desc "Tiny launcher for everything you installed in the terminal"
  homepage "https://github.com/Wiredframe/los"
  url "https://github.com/Wiredframe/los/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "400d850f2fc23a8d882af89b287182dc186756af199a796a28b89d58402b2b20"
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
