class ClaudeCacheNudge < Formula
  desc "Mac reminder before a Claude Code session's prompt cache runs out"
  homepage "https://bytesofpurpose.com/craft/generative-ai/claude-code-techniques/"
  # TODO: point at the public gist's raw files once Omar makes the gist, and fill in the checksum.
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
    (bin/"claude-cache-nudge").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/cache-nudge.mjs" "$@"
    SH
  end

  # brew services runs the check every minute, so the script's own install must not load its own
  # launch agent too: run it with --no-launchctl (see caveats).
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
        claude-cache-nudge install --no-launchctl
      Then start the check that runs every minute:
        brew services start claude-cache-nudge
    EOS
  end

  test do
    system bin/"claude-cache-nudge", "status", "--home", testpath
  end
end
