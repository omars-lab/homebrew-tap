# Documentation: 
# - https://docs.brew.sh/Formula-Cookbook
#   - We can do cron in a formula!
# - https://rubydoc.brew.sh/Formula
# - https://github.com/Homebrew/homebrew-core/blob/master/Formula/jrnl.rb
# - https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md#messaging
# - https://stackoverflow.com/questions/41029842/easy-way-to-have-homebrew-list-all-package-dependencies
# - https://stackoverflow.com/questions/50608871/how-do-i-write-test-for-homebrew-formula

class Scripts < Formula
  
  desc "Organizing my scripts."
  homepage "https://github.com/omars-lab/workspace"
  # url "https://github.com/omars-lab/workspace/archive/refs/tags/v0.0.tar.gz"
  url "https://github.com/omars-lab/workspace.git", revision: "51f07365fccc20a51d3c155d1f16ac6f38fd0777"
  license "GPL-3.0-only"
  version "0.11"
  
  depends_on "python-yq"
  depends_on "maven"
  depends_on "jq"
  depends_on "autojump"
  depends_on "asdf"
  depends_on "watch"
  depends_on "plantuml"
  depends_on "the_silver_searcher"
  depends_on "nvm"
  depends_on "tree"
  
  # https://github.com/ytdl-org/youtube-dl/
  depends_on "youtube-dl"
  # https://github.com/rodionovd/homebrew-taps
  depends_on "rodionovd/taps/shortcuts"
  if ! File.directory?("/Applications/OpenSCAD.app")
    depends_on "openscad"  
  end

  def install
    bin.install Dir["scripts/*"]
    prefix.install Dir["functions"]
    prefix.install Dir["functions-completion"]
    system "make", "brew-install"
    ohai "Don't forget to recursively source files in #{prefix}/functions"
    ohai "Don't forget to recursively source files in #{prefix}/functions-completion"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test scripts`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "make", "brew-test"
  end
end
