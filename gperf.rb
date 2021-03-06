class Gperf < Formula
  desc "Perfect hash function generator"
  homepage "https://www.gnu.org/software/gperf"
  url "https://ftpmirror.gnu.org/gperf/gperf-3.0.4.tar.gz"
  mirror "https://ftp.gnu.org/pub/gnu/gperf/gperf-3.0.4.tar.gz"
  sha256 "767112a204407e62dbc3106647cf839ed544f3cf5d0f0523aaa2508623aad63e"

  bottle do
    cellar :any_skip_relocation
    sha256 "7a29550946fb75b6ec7796c00563038727843edf975c5a1f001e9a2334ea2741" => :el_capitan
    sha256 "b59111d8699e9e005fd8ba71f1c73082801c59618f69e3b6132ef17f4fc3d4d4" => :yosemite
    sha256 "2c96a9dac35ab5cc085d778d0e1fa4899dd0ae2de3120f243a9513761c3eda02" => :mavericks
    sha256 "e8fa479ab02b7452a63e7c7f666845e7caef48a83e38f31bc7f3938b55dafa9d" => :x86_64_linux
  end

  keg_only :provided_until_xcode43

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "TOTAL_KEYWORDS 3",
      pipe_output("#{bin}/gperf", "homebrew\nfoobar\ntest\n")
  end
end
