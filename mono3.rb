# http://www.mono-project.com/Compiling_Mono_on_OSX

require 'formula'

class Mono3 < Formula
    VER='3.2.5'
    homepage 'http://www.mono-project.com/'
    url "http://download.mono-project.com/sources/mono/mono-#{VER}.tar.bz2"
    sha1 '1cd0bc34835f6e2fa48e03178324ee92a9ca91cb'

    resource 'xsp' do
        url "http://download.mono-project.com/sources/xsp/xsp-2.10.2.tar.bz2"
        sha1 'cab9218c56bb9f6e1a8e8e56c3b97ac2eac27bec'
    end

    def install
        man.mkpath
        system "./configure",
                    "--prefix=#{prefix}",
                    "--mandir=#{man}",
                    "--with-glib=embedded",
                    "--with-tls=pthread",
                    "--enable-nls=no"
        system "make"
        system "make install"

        resource('xsp').stage do
            system "./configure",
                        "--prefix=#{prefix}"
            system "make"
            system "make install"
        end
    end

    test do
        system "#{bin}/mono --version"
    end

end
