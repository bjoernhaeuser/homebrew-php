require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Php72Amqp < AbstractPhp72Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.4.tgz"
  sha256 "b66b8b8264749cb7a69ae4d09665dad1559b6c4f01430206c8e4187bcd8c782d"
  head "https://github.com/pdezwart/php-amqp.git"

  depends_on "rabbitmq-c"

  def install
    Dir.chdir "amqp-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file if build.with? "config-file"
  end
end
