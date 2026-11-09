class ClaudeCacheNudge < Formula
  desc "Mac reminder before a Claude Code session's prompt cache runs out"
  homepage "https://bytesofpurpose.com/craft/generative-ai/claude-code-techniques/a-reminder-before-the-cache-runs-out"
  # The public gist holds both files; the url pins one revision of it.
  url "https://gist.githubusercontent.com/omars-lab/e837c737bf28718412422783f1f30812/raw/433218694873c8e2d581c351a72a2caffa39b2a8/cache-nudge.mjs"
  version "0.1.1"
  sha256 "5b306a3a8fa319b130ad646a5bb1a7d39e778fe9b08b5da10f11916dd73d511a"

  depends_on :macos
  depends_on "node"

  resource "applescript" do
    url "https://gist.githubusercontent.com/omars-lab/e837c737bf28718412422783f1f30812/raw/433218694873c8e2d581c351a72a2caffa39b2a8/cache-nudge.applescript"
    sha256 "d33bd04228037c9a4712e7e72f0a7eca8f5d4cd5cd43c81c8666e4496968219f"
  end

  def install
    libexec.install "cache-nudge.mjs"
    resource("applescript").stage { libexec.install "cache-nudge.applescript" }
    # CACHE_NUDGE_COMMAND tells the script's install to run in place: no copy into ~/.claude/hooks/,
    # no launch agent of its own, and a hook that calls this stable command, so brew upgrade reaches it.
    (bin/"claude-cache-nudge").write <<~SH
      #!/bin/bash
      export CACHE_NUDGE_COMMAND="#{opt_bin}/claude-cache-nudge"
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/cache-nudge.mjs" "$@"
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
    settings = JSON.parse((testpath/".claude/settings.json").read)
    assert_equal "\"#{opt_bin}/claude-cache-nudge\" hook", settings.dig("hooks", "Stop", 0, "hooks", 0, "command")
    refute_path_exists testpath/".claude/hooks/claude-cache-nudge.mjs"
    system bin/"claude-cache-nudge", "uninstall", "--home", testpath, "--no-launchctl"
  end
end
