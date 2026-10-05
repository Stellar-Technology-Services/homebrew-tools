class Vidprep < Formula
  desc "Transcribe local videos to VTT, Markdown, and HTML with closed-caption player pages"
  homepage "https://github.com/Stellar-Technology-Services/videoshareprep"
  license "MIT"

  depends_on "ffmpeg"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/Stellar-Technology-Services/videoshareprep/releases/download/v1.0.0/vidprep_1.0.0_darwin_arm64.tar.gz"
      sha256 "b2f9cd6644b1d82ae4e09ca3f6596a6285a148ca9f881fa58226155711c3082d"
    end
    on_intel do
      url "https://github.com/Stellar-Technology-Services/videoshareprep/releases/download/v1.0.0/vidprep_1.0.0_darwin_amd64.tar.gz"
      sha256 "407b51381c38e61a0377168039cb7568e4b4b772239fdbbc96d1138a925afa68"
    end
  end

  def install
    bin.install "vidprep"
  end

  test do
    assert_predicate bin/"vidprep", :executable?
  end
end
