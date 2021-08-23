# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Workspace < Formula
  include Language::Python::Virtualenv
  
  desc "Organizing my workspace."
  homepage "https://github.com/omars-lab/workspace"
  url "https://github.com/omars-lab/workspace/archive/refs/tags/v0.0.tar.gz"
  sha256 "61253c1723a803bd7e15a3ba75d159fcd07bbc9ee8fd62c95881a343946483ac"
  license "GPL-3.0-only"

  depends_on "python@3.9"

  resource "BeautifulSoup4" do
    url "https://files.pythonhosted.org/packages/6b/c3/d31704ae558dcca862e4ee8e8388f357af6c9d9acb0cad4ba0fbbd350d9a/beautifulsoup4-4.9.3.tar.gz"
    sha256 "84729e322ad1d5b4d25f805bfa05b902dd96450f43842c4e99067d5e1369eb25"
  end
  resource "requests" do
    url "https://files.pythonhosted.org/packages/e7/01/3569e0b535fb2e4a6c384bdbed00c55b9d78b5084e0fb7f4d0bf523d7670/requests-2.26.0.tar.gz"
    sha256 "b8aa58f8cf793ffd8782d3d8cb19e66ef36f7aba4353eec859e74678b01b07a7"
  end
  resource "xerox" do
    url "https://files.pythonhosted.org/packages/a8/f2/48a3fb98b128e77e0c1e15a80c71d397c1ac1a4ed6db00e3e7307f767f93/xerox-0.4.1.tar.gz"
    sha256 "1b598ed4ba017374f02e9cef983febdd19dba79a5301856fdba985c490b14325"
  end
  resource "uncurl" do
    url "https://files.pythonhosted.org/packages/e2/90/95297af714749e5f6dedb8677bd3b6087dc3e31a212633f90c92bbda24c0/uncurl-0.0.11.tar.gz"
    sha256 "530c9bbd4d118f4cde6194165ff484cc25b0661cd256f19e9d5fcb53fc077790"
  end
  resource "markdown" do
    url "https://files.pythonhosted.org/packages/49/02/37bd82ae255bb4dfef97a4b32d95906187b7a7a74970761fca1360c4ba22/Markdown-3.3.4.tar.gz"
    sha256 "31b5b491868dcc87d6c24b7e3d19a0d730d59d3e46f4eea6430a321bed387a49"
  end
  resource "pandas" do
    url "https://files.pythonhosted.org/packages/cf/f7/6c0dd488b5f5f1c0c1a48637df45046334d0be684faaf3536429f14aa9de/pandas-1.3.2.tar.gz"
    sha256 "cbcb84d63867af3411fa063af3de64902665bb5b3d40b25b2059e40603594e87"
  end
  resource "arrow" do
    url "https://files.pythonhosted.org/packages/94/39/b5bb573821d6784640c227ccbd72fa192f7542fa0f68589fd51757046030/arrow-1.1.1.tar.gz"
    sha256 "dee7602f6c60e3ec510095b5e301441bc56288cb8f51def14dcb3079f623823a"
  end

  def install
    # https://docs.brew.sh/Formula-Cookbook
    # https://docs.brew.sh/Python-for-Formula-Authors
    virtualenv_install_with_resources
    prefix.install Dir["./*"]
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
