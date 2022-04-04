class CronEvery1h < Formula

  desc "Organizing my cron jobs."
  homepage "https://github.com/omars-lab/workspace"
  url "https://github.com/omars-lab/workspace.git", revision: "9f29384f2289ded00376d2c01c43b18169eb9d09"
  license "GPL-3.0-only"
  version "0.11"

  service do
    run bin/"cron-every-1h"
    run_type :cron
    cron "0 * * * *"
  end 

  def install
    bin.install "scripts/cron-1h-ly.sh" => "cron-every-1h"
    system "make", "brew-install"
    ohai "Service Installed"
  end

  test do
    system "make", "brew-test"
    ohai "Service Tested"
  end
end
