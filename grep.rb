class Grep < Formula
  desc "GNU grep, egrep and fgrep"
  homepage "https://www.gnu.org/software/grep/"
  url "https://ftpmirror.gnu.org/grep/grep-2.26.tar.xz"
  mirror "https://ftp.gnu.org/gnu/grep/grep-2.26.tar.xz"
  sha256 "246a8fb37e82aa33d495b07c22fdab994c039ab0f818538eac81b01e78636870"

  bottle do
    cellar :any
    sha256 "ba73094a138d1c380fb1606c0bed77df0326988a08051dfc53670aa47a902f71" => :sierra
    sha256 "eaf81afbbdb4b1c940a2c43d50ef35cca893914a639eade98e1e5f276161d25c" => :el_capitan
    sha256 "53fe1e3d146af8cf277949f508ccdec11f1f4e0d9fc3b357eb5b1f370324591b" => :yosemite
    sha256 "89ddc88c16ed40023191e01adec0db87198c725d49e9167a8ae48971ce10948d" => :x86_64_linux
  end

  option "with-default-names", "Do not prepend 'g' to the binary"
  deprecated_option "default-names" => "with-default-names"

  depends_on "pkg-config" => :build
  depends_on "pcre"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-nls
      --prefix=#{prefix}
      --infodir=#{info}
      --mandir=#{man}
      --with-packager=Homebrew
    ]

    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  def caveats
    if build.without? "default-names" then <<-EOS.undent
      The command has been installed with the prefix "g".
      If you do not want the prefix, install using the "with-default-names"
      option.
      EOS
    end
  end

  test do
    text_file = testpath/"file.txt"
    text_file.write "This line should be matched"
    cmd = build.with?("default-names") ? "grep" : "ggrep"
    grepped = shell_output("#{bin}/#{cmd} match #{text_file}")
    assert_match "should be matched", grepped
  end
end
