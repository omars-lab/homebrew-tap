# Documentation: 
# - https://docs.brew.sh/Python-for-Formula-Authors
# - https://rubydoc.brew.sh/Language/Python/Virtualenv/Virtualenv.html
# - https://github.com/Homebrew/homebrew-core/blob/master/Formula/jrnl.rb
# - https://rubydoc.brew.sh/Language/Python/Virtualenv.html

class Workspace < Formula
  include Language::Python::Virtualenv
  
  desc "Organizing my workspace."
  homepage "https://github.com/omars-lab/workspace"
  url "https://github.com/omars-lab/workspace.git", revision: "d9634b89bdb4ede655750331d135bf5333b9b523"
  license "GPL-3.0-only"
  version "0.1"

  depends_on "omars-lab/tap/scripts"
  depends_on "python@3.10"

  def install
    prefix.install "requirements.txt"
    venv = virtualenv_create(libexec, python="python3")
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


# resource "BeautifulSoup4" do
#   url "https://files.pythonhosted.org/packages/a1/69/daeee6d8f22c997e522cdbeb59641c4d31ab120aba0f2c799500f7456b7e/beautifulsoup4-4.10.0.tar.gz"
#   sha256 "c23ad23c521d818955a4151a67d81580319d4bf548d3d49f4223ae041ff98891"
# end
# resource "requests" do
#   url "https://files.pythonhosted.org/packages/60/f3/26ff3767f099b73e0efa138a9998da67890793bfa475d8278f84a30fec77/requests-2.27.1.tar.gz"
#   sha256 "68d7c56fd5a8999887728ef304a6d12edc7be74f1cfa47714fc8b414525c9a61"
# end
# resource "xerox" do
#   url "https://files.pythonhosted.org/packages/a8/f2/48a3fb98b128e77e0c1e15a80c71d397c1ac1a4ed6db00e3e7307f767f93/xerox-0.4.1.tar.gz"
#   sha256 "1b598ed4ba017374f02e9cef983febdd19dba79a5301856fdba985c490b14325"
# end
# resource "uncurl" do
#   url "https://files.pythonhosted.org/packages/e2/90/95297af714749e5f6dedb8677bd3b6087dc3e31a212633f90c92bbda24c0/uncurl-0.0.11.tar.gz"
#   sha256 "530c9bbd4d118f4cde6194165ff484cc25b0661cd256f19e9d5fcb53fc077790"
# end
# resource "markdown" do
#   url "https://files.pythonhosted.org/packages/15/06/d60f21eda994b044cbd496892d4d4c5c708aa597fcaded7d421513cb219b/Markdown-3.3.6.tar.gz"
#   sha256 "76df8ae32294ec39dcf89340382882dfa12975f87f45c3ed1ecdb1e8cefc7006"
# end
# resource "pandas" do
#   url "https://files.pythonhosted.org/packages/5a/ac/b3b9aa2318de52e40c26ae7b9ce6d4e9d1bcdaf5da0899a691642117cf60/pandas-1.4.2.tar.gz"
#   sha256 "92bc1fc585f1463ca827b45535957815b7deb218c549b7c18402c322c7549a12"
# end
# resource "arrow" do
#   url "https://files.pythonhosted.org/packages/48/28/30a5748af715b0ab9c2b81cf08bd9e261e47a6261e247553afb7f6421b24/arrow-1.2.2.tar.gz"
#   sha256 "05caf1fd3d9a11a1135b2b6f09887421153b94558e5ef4d090b567b47173ac2b"
# end
# resource "catt" do
#   url "https://files.pythonhosted.org/packages/18/ee/78ce66ebd89df45fc3c96fbfdf13996f60bbfd1a9929c14650fa33c6644f/catt-0.12.7.tar.gz"
#   sha256 "43d78f5912f0bae4c6fa83ca160ef19f5823e2e0159575317a059dc87dd877dd"
# end
# resource "pyyaml" do
#   url "https://files.pythonhosted.org/packages/36/2b/61d51a2c4f25ef062ae3f74576b01638bebad5e045f747ff12643df63844/PyYAML-6.0.tar.gz"
#   sha256 "68fb519c14306fec9720a2a5b45bc9f0c8d1b9c72adf45c37baedfcd949c35a2"
# end

# virtualenv_install_with_resources
# system "env" - path looks good ...
# https://rubydoc.brew.sh/Language/Python/Virtualenv.html#python_names-instance_method
# puts python_names - printing the python names in order 

# ohai "Installed virtual env"
# Install all of the resources declared on the formula into the virtualenv.
# venv.pip_install resources
# ohai "Installed resources into virtual env"

# my_cli_path = prefix.to_s
# my_cli_path["/workspace/0.1"] = "/my-cli/0.11/library"
# venv.pip_install_and_link(my_cli_path)
# ohai "Installed my-cli into virtual env"