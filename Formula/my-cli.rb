# https://github.com/Homebrew/homebrew-core/issues/8501

class MyCli < Formula
  include Language::Python::Virtualenv

  desc "My CLI."
  homepage "https://github.com/omars-lab/my-cli"
  url "git@github.com:omars-lab/my-cli.git", :using => :git, revision: "6da564034ddf808418649fb66d0c77a16f2b2fe2" # branch: "master" 
  license "GPL-3.0-only"
  version "0.11"
  
  depends_on "python@3.10"
  
  def install
    prefix.install "README.md"
    prefix.install Dir["library"]
    venv = virtualenv_create(libexec, python="python3")
    ohai "Installed virtual env"
    pip3 = "#{libexec}/bin/pip3"
    requirements = "#{prefix}/library/requirements.txt"
    system pip3, "install", "setuptools", "-U"
    system pip3, "install", "-v", "-r", requirements
    system pip3, "install", "-v", "--ignore-installed", "--no-deps", prefix/"library"
    bin.install Dir["#{libexec}/bin/*-my"]
  end

  test do
    ohai "My CLI Tested"
  end
end

# venv.pip_install_and_link prefix/"library"


# investigating why i cant find creatives ...
# turns out ...specifying --target is more than just script dir...

# /usr/local/Cellar/my-cli/0.11/libexec/bin/python3.10 -m site --user-site
# /Users/omareid/Library/Python/3.10/lib/python/site-packages

# ➜  ~ /usr/local/Cellar/my-cli/0.11/libexec/bin/python3.10 -c 'import sys; print(sys.path)'
# ['', '/usr/local/Cellar/python@3.10/3.10.2/Frameworks/Python.framework/Versions/3.10/lib/python310.zip', '/usr/local/Cellar/python@3.10/3.10.2/Frameworks/Python.framework/Versions/3.10/lib/python3.10', '/usr/local/Cellar/python@3.10/3.10.2/Frameworks/Python.framework/Versions/3.10/lib/python3.10/lib-dynload', '/usr/local/Cellar/my-cli/0.11/libexec/lib/python3.10/site-packages', '/usr/local/lib/python3.10/site-packages']

# ➜  ~ ls /usr/local/Cellar/python@3.10/3.10.2/Frameworks/Python.framework/Versions/3.10/lib/python3.10 /usr/local/Cellar/my-cli/0.11/libexec/bin/python3.10 -c 'import sys; print(sys.path)'
# system "echo", 
#         "#{libexec}/lib/python3.10/site-packages/", 
#         ">", 
#         "#{Dir.home}/Library/Python/3.10/lib/python/site-packages/#{self.name}.pth"

# Install all of the resources declared on the formula into the virtualenv.
# venv.pip_install resources
# system pip3, "install", "-r", requirements

# Thought there was an Issue with symlinks .. but there wasnt ...
# workspace_path = File.readlink(workspace_path)

# This may work, but I got to to work otherwise ..
# https://docs.brew.sh/Python-for-Formula-Authors#installing-bindings
# Get into workspace site packages
  # system (Formula["omars-lab/tap/workspace"].libexec.to_s + "/bin/pip3"), "install", "#{prefix}/library"

  # system ("#{workspace_path}/bin/python3"), 
#            "#{prefix}/library/setup.py",
#            "--no-user-cfg", 
#            "install",
#            "--prefix=#{workspace_path}",
#            "--install-scripts=#{workspace_path}/bin",
#            "--single-version-externally-managed",
#            "--record=installed.txt"

# Gave me issues ...
# system "mkdir", "-p", "#{prefix}/console-bin"
    # system pip3, "install", "--upgrade", "--target=#{workspace_target}", prefix/"library"
    # "--install-option", "--install-scripts=#{prefix}/bin", 
    

# lots of issue when trying to install in a virtual env for another formula ..


# # Install scripts properly ... and get into workspace site packages ...
# workspace_path = libexec.to_s  # Formula["omars-lab/tap/workspace"].libexec
# # Following needs to map scripts formula version to the workspace version that has the virtual env with proper deps ...
# workspace_path["/my-cli/0.11"] = "/workspace/0.1"

# workspace_target = "#{workspace_path}/lib/python3.10/site-packages"
# ENV.prepend_create_path "PYTHONPATH", workspace_target

# pip3 = "#{workspace_path}/bin/pip3"

# self.resource("pydriller").stage { system pip3, "install", "-v", "--no-binary", ":all:", "--ignore-installed", "-r", "." }
# system pip3, "install", "-v", "--no-binary", ":all:", "--ignore-installed", "--target=#{workspace_target}", "-r", prefix/"library/requirements.txt"
# system pip3, "install", "-v", "--no-binary", ":all:", "--ignore-installed", "--target=#{workspace_target}", "--no-deps", prefix/"library"

# system "git", "clone", "git@github.com:ishepard/pydriller.git", libexec/"pydriller"
# system pip3, "install", "-v", "--no-binary", ":all:", "--ignore-installed", "--target=#{workspace_target}", "-r", libexec/"pydriller/requirements.txt"
# system pip3, "install", "-v", "--no-binary", ":all:", "--ignore-installed", "--target=#{workspace_target}", "--no-deps", libexec/"pydriller"

# venv = Virtualenv.new(self, workspace_path, "python")
# venv.pip_install resources
# venv.pip_install_and_link prefix/"library"

# ohai "Installed my-cli into workspace virtual env with #{pip3}"

# new_shebang = libexec.to_s
# ## Following needs to map scripts formula version to the workspace version that has the virtual env with proper deps ...
# new_shebang["/my-cli/0.11"] = "/workspace/0.1"
# # https://github.com/Homebrew/brew/blob/9c03493774500cf16ced8938e1eb4eeae8216b20/Library/Homebrew/language/python.rb#L96-L103

# shebang_rewriter = Utils::Shebang::RewriteInfo.new(
#   %r{^#! ?/usr/bin/(?:env )?python(?:[23](?:\.\d{1,2})?)?( |$)},
#   28, # the length of "#! /usr/bin/env pythonx.yyy "
#   "#{new_shebang}/bin/python3.10",
# )

# rewrite_shebang shebang_rewriter, prefix/"library/creatives/clis/analyzing_me.py"
# rewrite_shebang shebang_rewriter, prefix/"library/creatives/clis/listing_me.py"

# bin.install prefix/"library/creatives/clis/analyzing_me.py" => "analyzing-my"
# bin.install prefix/"library/creatives/clis/listing_me.py" => "listing-my"

# ohai "Installed my-cli into virtual env"
# ohai "My CLI Installed"
# unintall should uninstall from workspace ...

# - [ ] Cant use these ... if requirements has a git url - this uses setup.py and setup.py fails ...
# venv.pip_install_and_link prefix/"library"


# depends_on "omars-lab/tap/workspace"
  
  # resource "fastapi" do
  #   url "https://files.pythonhosted.org/packages/0e/3e/39540da9d0442089c9723c4629657a1d4b17b7fcf260023e3e24c563ce83/fastapi-0.75.1.tar.gz"
  #   sha256 "8b62bde916d657803fb60fffe88e2b2c9fb854583784607e4347681cae20ad01"
  # end
  # resource "selenium" do
  #   url "https://files.pythonhosted.org/packages/ed/9c/9030520bf6ff0b4c98988448a93c04fcbd5b13cd9520074d8ed53569ccfe/selenium-3.141.0.tar.gz"
  #   sha256 "deaf32b60ad91a4611b98d8002757f29e6f2c2d5fcaf202e1c9ad06d6772300d"
  # end
  # resource "uvicorn" do
  #   url "https://files.pythonhosted.org/packages/6d/7d/b97c120cad5fd1f66462afb0d5ddd043078f2380b89fccd8a97ef5c95b5c/uvicorn-0.17.6.tar.gz"
  #   sha256 "5180f9d059611747d841a4a4c4ab675edf54c8489e97f96d0583ee90ac3bfc23"
  # end
  # resource "typer" do
  #   url "https://files.pythonhosted.org/packages/84/f2/71a04c8aa8718570d6f7570f6871fd358c29c715035f63630dadbd460da8/typer-0.4.1.tar.gz"
  #   sha256 "5646aef0d936b2c761a10393f0384ee6b5c7fe0bb3e5cd710b17134ca1d99cff"
  # end
  # resource "tabulate" do
  #   url "https://files.pythonhosted.org/packages/ae/3d/9d7576d94007eaf3bb685acbaaec66ff4cdeb0b18f1bf1f17edbeebffb0a/tabulate-0.8.9.tar.gz"
  #   sha256 "eb1d13f25760052e8931f2ef80aaf6045a6cceb47514db8beab24cded16f13a7"
  # end
  # resource "pydash" do
  #   url "https://files.pythonhosted.org/packages/39/b2/d636df19002ad266b4ba8be93275d0405654fa52134fdd93cfa1b34d6f15/pydash-5.1.0.tar.gz"
  #   sha256 "1b2b050ac1bae049cd07f5920b14fabbe52638f485d9ada1eb115a9eebff6835"
  # end
  # resource "numpy" do
  #   url "https://files.pythonhosted.org/packages/64/4a/b008d1f8a7b9f5206ecf70a53f84e654707e7616a771d84c05151a4713e9/numpy-1.22.3.zip"
  #   sha256 "dbc7601a3b7472d559dc7b933b18b4b66f9aa7452c120e87dfb33d02008c8a18"
  # end
  # resource "pandas" do
  #   url "https://files.pythonhosted.org/packages/5a/ac/b3b9aa2318de52e40c26ae7b9ce6d4e9d1bcdaf5da0899a691642117cf60/pandas-1.4.2.tar.gz"
  #   sha256 "92bc1fc585f1463ca827b45535957815b7deb218c549b7c18402c322c7549a12"
  # end
  # resource "click" do
  #   url "https://files.pythonhosted.org/packages/42/e1/4cb2d3a2416bcd871ac93f12b5616f7755a6800bccae05e5a99d3673eb69/click-8.1.2.tar.gz"
  #   sha256 "479707fe14d9ec9a0757618b7a100a0ae4c4e236fac5b7f80ca68028141a1a72"
  # end
  # resource "pytz" do
  #   url "https://files.pythonhosted.org/packages/2f/5f/a0f653311adff905bbcaa6d3dfaf97edcf4d26138393c6ccd37a484851fb/pytz-2022.1.tar.gz"
  #   sha256 "1e760e2fe6a8163bc0b3d9a19c4f84342afa0a2affebfaa84b01b978a02ecaa7"
  # end
  # resource "python-dateutil" do
  #   url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
  #   sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  # end
  # resource "lizard" do
  #   url "https://files.pythonhosted.org/packages/45/16/dbe57aa29fa48eb76ae0b4d25a041cf6e2e2323afda72497429c31a18211/lizard-1.17.9.tar.gz"
  #   sha256 "76ee0e631d985bea1dd6521a03c6c2fa9dce5a2248b3d26c49890e9e085b7aed"
  # end
  # resource "gitpython" do
  #   url "https://files.pythonhosted.org/packages/d6/39/5b91b6c40570dc1c753359de7492404ba8fe7d71af40b618a780c7ad1fc7/GitPython-3.1.27.tar.gz"
  #   sha256 "1c885ce809e8ba2d88a29befeb385fcea06338d3640712b59ca623c220bb5704"
  # end
  # resource "types-pytz" do
  #   url "https://files.pythonhosted.org/packages/88/ea/724b87ea9ad65d1815c25935a7c49ad14393e9c21bdc0e30158cbd9bdcc2/types-pytz-2021.3.6.tar.gz"
  #   sha256 "74547fd90d8d8ab4f1eedf3a344a7d186d97486973895f81221a712e1e2cd993"
  # end
  # resource "pydriller" do
  #   url "git@github.com:ishepard/pydriller.git", :using => :git, revision: "3f9b6a55fa74710c2ee3d0118b035b81da571b58"
  # end
