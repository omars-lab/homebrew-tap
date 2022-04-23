# Documentation: 
# - https://docs.brew.sh/Python-for-Formula-Authors
# - https://rubydoc.brew.sh/Language/Python/Virtualenv/Virtualenv.html
# - https://github.com/Homebrew/homebrew-core/blob/master/Formula/jrnl.rb
# - https://rubydoc.brew.sh/Language/Python/Virtualenv.html

class Workspace < Formula
  include Language::Python::Virtualenv

  option "with-general", "Builds using c12e workplace scripts."
  option "with-c12e", "Builds using c12e workplace scripts."
  option "with-amazon", "Builds using Amazon workplace scripts."
  # https://www.rubyguides.com/2019/10/ruby-ternary-operator/
  # https://docs.brew.sh/Formula-Cookbook#adding-optional-steps
  
  desc "Organizing my **work**space."
  homepage "https://github.com/omars-lab/workspace-career"
  url "git@github.com:omars-lab/workspace-career.git", :using => :git, branch: (
   ( build.with? "amazon") ? "amazon" : ( (build.with? "c12e") ? "c12e" : "general")
  ) #, revision: "d9634b89bdb4ede655750331d135bf5333b9b523"
  license "GPL-3.0-only"
  version "0.1"

  depends_on "jq"

  # https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb
  resource "plugins" do
    url "git@github.com:omars-lab/plugins.git", :using => :git, branch: "master"
  end

  def install
    
    resource("plugins").stage { 
      (prefix/"flavorfultasks").install Dir["vscode/flavorfultasks/*"] 
    }
    # This is how i can add a breakpoint with --debug ...
    # system "false"
    system 'make', '-f', "#{prefix}/flavorfultasks/Makefile", 'brew-install', "BREW_PREFIX=#{prefix}"
    bin.install "#{prefix}/vscode-reinstall-plugins"
    (prefix/"releases").install Dir["#{prefix}/flavorfultasks/releases/*"]
    system "chown", "-R", ":staff", "#{prefix}"
    
    # Append a line to the .zsh profile (if it doesnt exist ... to source the brew loader ...)
    # In the brew loader if the brew loader is installed on the system (if its not ... it wount get sourced ...)
    # When not using the brew loader ... 

    # system "#{prefix}/bin/vscode-reinstall-plugins"
    # There is some permission error when doing the install in the formuala ... 
    #   Operation not permitted ... mkdir ~/.vscode/extensions/.29329293929392
    # General practice is that brew doesnt like modifiying external dirs ...

    # system "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code", "--install-extension", "#{prefix}/flavorfultasks-0.0.1.vsix"
    ohai "Don't forget to run: `vscode-reinstall-plugins` to install the vscode plugins!"
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
