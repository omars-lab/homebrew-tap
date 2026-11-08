class Lz4jsoncat < Formula
  desc "Tool for decompressing mozilla browser state files"
  homepage "https://github.com/andikleen/lz4json"
  url "https://github.com/andikleen/lz4json.git", branch: "master"
  version "0.1"
  license "GPL-3.0-only"

  depends_on "lz4"

  def install
    system "make"
    bin.install "lz4jsoncat"
  end

  test do
    system "true"
  end
end
