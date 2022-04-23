# Documentation: 
# - https://docs.brew.sh/Python-for-Formula-Authors
# - https://rubydoc.brew.sh/Language/Python/Virtualenv/Virtualenv.html
# - https://github.com/Homebrew/homebrew-core/blob/master/Formula/jrnl.rb
# - https://rubydoc.brew.sh/Language/Python/Virtualenv.html

class Sharedspace < Formula
  include Language::Python::Virtualenv
  
  desc "Organizing my shared workspace."
  homepage "https://github.com/omars-lab/workspace"
  url "https://github.com/omars-lab/workspace.git", branch: "main" #, revision: "d9634b89bdb4ede655750331d135bf5333b9b523"
  license "GPL-3.0-only"
  version "0.1"

  # # https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb
  # resource "hats" do
  #   url "git@github.com:omars-lab/hats.git", :using => :git, branch: "master"
  # end

  def install
    # resource("hats").stage { prefix.install Dir["."] }
    (prefix/"functions-completion").install Dir["functions-completion/*"]
    (prefix/"functions-extensions").install Dir["functions-extensions/*"]
    (prefix/"functions-shortcuts").install Dir["functions-shortcuts/*"]
    (prefix/"functions-tools").install Dir["functions-tools/*"]
    (prefix).install "loader-brew.sh"
    (bin).install "installers/sharedworkspace-installer.sh"
    (bin).install "installers/brew-debugger.sh"
    # https://docs.brew.sh/Formula-Cookbook#superenv-notes
    # brew may clone stuff from git without exec permissions ...
    # calling with bash ...
    system "/bin/bash", bin/"brew-debugger.sh", "#{prefix}"
    system "/bin/bash", bin/"sharedworkspace-installer.sh", "#{prefix}"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test workspace`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
