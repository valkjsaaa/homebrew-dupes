class Unzip < Formula
  desc "Extraction utility for .zip compressed archives"
  homepage "http://www.info-zip.org/pub/infozip/UnZip.html"
  url "https://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz"
  version "6.0"
  sha256 "036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37"

  bottle do
    cellar :any_skip_relocation
    sha256 "fcda165cef76bb86bc74c5435a4a46341695d49c04ff74da361c9be0d594fe9b" => :x86_64_linux
  end

  keg_only :provided_by_osx

  def install
    system "make", "-f", "unix/Makefile", "macosx"
    system "make", "prefix=#{prefix}", "MANDIR=#{man}", "install"
  end

  test do
    system "#{bin}/unzip", "--help"
  end
end
