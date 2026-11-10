class Personalspace < Formula
  include Language::Python::Virtualenv

  desc "Organizing my personal workspace"
  homepage "https://github.com/omars-lab/workspace"
  url "https://github.com/omars-lab/workspace.git", revision: "4fc188486bd7dff30e0b44294e6e983755333351"
  version "0.1"
  license "GPL-3.0-only"

  depends_on "omars-lab/tap/scripts"
  depends_on "python@3.10"

  # https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb
  resource "hats" do
    url "git@github.com:omars-lab/hats.git", using: :git, revision: "8faf1d632daac3e82b732a525cccb4c8d63dbe8c"
  end

  def install
    resource("hats").stage { prefix.install "." }

    prefix.install "requirements.txt"
    virtualenv_create(libexec, "python3")
    pip3 = "#{libexec}/bin/pip3"
    requirements = "#{prefix}/requirements.txt"
    system pip3, "install", "setuptools", "-U"
    system pip3, "install", "-v", "-r", requirements
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
