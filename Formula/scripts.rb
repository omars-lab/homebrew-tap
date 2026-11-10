class Scripts < Formula
  include Language::Python::Shebang

  desc "Organizing my shell and Python helpers"
  homepage "https://github.com/omars-lab/workspace"
  # https://docs.brew.sh/Formula-Cookbook#unstable-versions-head
  url "https://github.com/omars-lab/workspace.git", revision: "c6625fc2b192c317ed5e31be81a9be35b6e507df"
  version "0.11"
  license "GPL-3.0-only"

  depends_on "asdf"
  depends_on "autojump"
  depends_on "chrome-cli"
  depends_on "jq"
  depends_on "maven"
  depends_on "nvm"
  depends_on "omars-lab/tap/cron-every-1d"
  depends_on "omars-lab/tap/cron-every-1h"
  depends_on "omars-lab/tap/cron-every-1m"
  depends_on "omars-lab/tap/cron-every-5m"
  depends_on "omars-lab/tap/lz4jsoncat"
  depends_on "plantuml"
  depends_on "python-yq"
  depends_on "python@3.10"
  depends_on "rodionovd/taps/shortcuts"
  depends_on "the_silver_searcher"
  depends_on "tree"
  depends_on "watch"
  depends_on "yt-dlp"

  def install
    # Initiallizing Shebang Rewriter ...
    new_shebang = libexec.to_s
    # Map the scripts formula version to the workspace version that holds the virtualenv
    new_shebang["/scripts/0.11"] = "/workspace/0.1"
    # https://github.com/Homebrew/brew/blob/9c03493774500cf16ced8938e1eb4eeae8216b20/Library/Homebrew/language/python.rb#L96-L103
    shebang_rewriter = Utils::Shebang::RewriteInfo.new(
      %r{^#! ?/usr/bin/(?:env )?python(?:[23](?:\.\d{1,2})?)?( |$)},
      28, # the length of "#! /usr/bin/env pythonx.yyy "
      "#{new_shebang}/bin/python3.10",
    )
    # https://www.thoughtco.com/using-glob-with-directories-2907832
    Dir.glob("scripts/*.py").each do |py_file|
      # rewrite_shebang detected_python_shebang, py_file
      rewrite_shebang shebang_rewriter, py_file
    end

    bin.install Dir["scripts/*"]
    prefix.install "functions"
    prefix.install "functions-completion"

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
