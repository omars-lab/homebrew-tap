# https://github.com/Homebrew/homebrew-core/issues/8501

class MyCli < Formula
  include Language::Python::Virtualenv

  desc "Command-line helpers for my workspace"
  homepage "https://github.com/omars-lab/my-cli"
  url "git@github.com:omars-lab/my-cli.git", using: :git, revision: "6da564034ddf808418649fb66d0c77a16f2b2fe2"
  version "0.11"
  license "GPL-3.0-only"

  depends_on "python@3.10"

  def install
    prefix.install "README.md"
    prefix.install "library"
    virtualenv_create(libexec, "python3")
    ohai "Installed virtual env"
    pip3 = "#{libexec}/bin/pip3"
    requirements = prefix/"library"/"requirements.txt"
    system pip3, "install", "setuptools", "-U"
    system pip3, "install", "-v", "-r", requirements
    system pip3, "install", "-v", "--ignore-installed", "--no-deps", prefix/"library"
    bin.install Dir["#{libexec}/bin/*-my"]
  end

  test do
    ohai "My CLI Tested"
  end
end
