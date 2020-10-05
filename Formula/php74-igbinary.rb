require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Php74Igbinary < AbstractPhp74Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://pecl.php.net/get/igbinary-3.1.5.tgz"
  sha256 "e1f7dc74233052eb64d251c00e95889110de2406cdf5e71139050194da596d92"
  head "https://github.com/igbinary/igbinary.git"

  depends_on "igbinary" => :build

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      ; Enable or disable compacting of duplicate strings
      ; The default is On.
      ;igbinary.compact_strings=On

      ; Use igbinary as session serializer
      ;session.serialize_handler=igbinary

      ; Use igbinary as APC serializer
      ;apc.serializer=igbinary
    EOS
  end
end
