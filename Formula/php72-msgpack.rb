require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Php72Msgpack < AbstractPhp72Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-2.0.3.tgz"
  sha256 "9dfa3c79d985334f82a88b7577f81d3ce4114211af064cffccf4d7b084a28842"
  head "https://github.com/msgpack/msgpack-php.git"
  revision 1

  def install
    Dir.chdir "msgpack-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/msgpack.so"
    write_config_file if build.with? "config-file"
  end
end
