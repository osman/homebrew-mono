# http://www.mono-project.com/Compiling_Mono_on_OSX

require 'formula'

class Mono < Formula
    homepage 'http://www.mono-project.com/'
    url 'http://download.mono-project.com/sources/mono/mono-2.11.3.tar.bz2'
    sha1 'd5c56c12c8fbf8d838d11cf7cafff6e0f714164a'

    devel do
        # normal url has a bug, use a patched version
        #url 'http://download.mono-project.com/sources/mono/mono-3.2.5.tar.bz2'
        #sha1 '1cd0bc34835f6e2fa48e03178324ee92a9ca91cb'
        url 'http://download.pokorra.de/mono/tarballs/mono-3.2.5.tar.bz2'
        sha1 '8d64838e1fa6f338ee75e9c922f9c07eece5e492'
    end

    resource 'xsp' do
        url 'http://download.mono-project.com/sources/xsp/xsp-2.10.2.tar.bz2'
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
        system "make -j7"
        system "make install"

        resource('xsp').stage do
            ENV["PATH"] = "#{bin}:#{ENV['PATH']}"
            ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
            ENV["PKG_CONFIG_PATH"] = "#{lib}/pkgconfig"
            system "./configure",
                        "--prefix=#{prefix}",
                        "--mandir=#{man}"
            system "make -j7"
            system "make install"
        end
    end

    test do
        system "#{bin}/mono --version"
        system "#{bin}/xsp --version"
    end
end
