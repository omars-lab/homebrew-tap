class CronEvery1m < Formula

  desc "Organizing my cron jobs."
  homepage "https://github.com/omars-lab/workspace"
  url "https://github.com/omars-lab/workspace.git", revision: "c6625fc2b192c317ed5e31be81a9be35b6e507df"
  license "GPL-3.0-only"
  version "0.11"
  
  service do
    run bin/"cron-every-1m"
    run_type :cron
    cron "* * * * *"
  end 
  
  def install
    bin.install "scripts/cron-1m-ly.sh" => "cron-every-1m"
    system "make", "brew-install"
    ohai "Service Installed"
  end

  test do
    system "make", "brew-test"
    ohai "Service Tested"
  end
end
