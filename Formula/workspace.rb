class Workspace < Formula
  desc "Installs the flavorfultasks VS Code extension and a script to reinstall it"
  homepage "https://github.com/omars-lab/plugins"
  url "https://github.com/omars-lab/plugins.git", revision: "63b3bfc76fc18670021b318f41d8b2b93109653a"
  version "0.1"
  license "GPL-3.0-only"

  depends_on "jq"

  def install
    (prefix/"flavorfultasks").install Dir["vscode/flavorfultasks/*"]
    system "make", "-f", "#{prefix}/flavorfultasks/Makefile", "brew-install", "BREW_PREFIX=#{prefix}"
    bin.install "#{prefix}/vscode-reinstall-plugins"
    (prefix/"releases").install Dir["#{prefix}/flavorfultasks/releases/*"]
    chown_R nil, "staff", prefix

    # Homebrew can't write to ~/.vscode, so the extension is installed by the script, after brew.
    ohai "Don't forget to run: `vscode-reinstall-plugins` to install the vscode plugins!"
  end

  test do
    assert_predicate bin/"vscode-reinstall-plugins", :executable?
  end
end
