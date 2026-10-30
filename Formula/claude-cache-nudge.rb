class ClaudeCacheNudge < Formula
  desc "Mac reminder before a Claude Code session's prompt cache runs out"
  homepage "https://bytesofpurpose.com/craft/generative-ai/claude-code-techniques/"
  # TODO: point at the public gist's raw files once the gist exists, and fill in the checksum.
  url "https://gist.githubusercontent.com/omars-lab/GIST_ID/raw/REVISION/cache-nudge.mjs"
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"

  depends_on :macos
  depends_on "node"

  resource "applescript" do
    # TODO: the same gist's second file.
    url "https://gist.githubusercontent.com/omars-lab/GIST_ID/raw/REVISION/cache-nudge.applescript"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    libexec.install "cache-nudge.mjs"
    resource("applescript").stage { libexec.install "cache-nudge.applescript" }
    # CACHE_NUDGE_COMMAND tells the script's install to run in place: no copy into ~/.claude/hooks/,
    # no launch agent of its own, and a hook that calls this stable command, so brew upgrade reaches it.
    (bin/"claude-cache-nudge").write <<~SH
      #!/bin/bash
      export CACHE_NUDGE_COMMAND="#{opt_bin}/claude-cache-nudge"
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/cache-nudge.mjs" "$@"
    SH
  end

  service do
    run [opt_bin/"claude-cache-nudge", "check"]
    run_type :interval
    interval 60
    log_path var/"log/claude-cache-nudge.log"
    error_log_path var/"log/claude-cache-nudge.log"
  end

  def caveats
    <<~EOS
      Homebrew does not edit ~/.claude. To add the reminder's hooks to Claude Code, run:
        claude-cache-nudge install
      Then start the check that runs every minute:
        brew services start claude-cache-nudge
    EOS
  end

  test do
    system bin/"claude-cache-nudge", "install", "--home", testpath, "--no-launchctl"
    assert_match "\"#{opt_bin}/claude-cache-nudge\" hook", (testpath/".claude/settings.json").read
    refute_path_exists testpath/".claude/hooks/claude-cache-nudge.mjs"
    system bin/"claude-cache-nudge", "uninstall", "--home", testpath, "--no-launchctl"
  end
end
