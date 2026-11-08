class CronEvery5m < Formula
  desc "Organizing my cron jobs"
  homepage "https://github.com/omars-lab/workspace"
  url "https://github.com/omars-lab/workspace.git", revision: "c6625fc2b192c317ed5e31be81a9be35b6e507df"
  version "0.11"
  license "GPL-3.0-only"

  service do
    run opt_bin/"cron-every-5m"
    run_type :interval
    interval 300
  end

  def install
    bin.install "scripts/cron-5m-ly.sh" => "cron-every-5m"
    system "make", "brew-install"
    ohai "Service Installed"
  end

  test do
    system "make", "brew-test"
    ohai "Service Tested"
  end
end
