#Обновить репы в Slitaz
tazpkg recharge
#Обновить репы в Haiku
#pkgman update
#Установить HATARI в Гайке. Увы че-то не хотит компилить саму Hatari, но все остальное ставится.
#pkgman install mc gcc make cmake zlib libpng-dev linux-headers readline portaudio arandr xorg-xf86-video-intel 915resolution libsdl lunux-joystick
tazpkgget- install mc gcc make cmake zlib libpng-dev linux-headers readline portaudio arandr xorg-xf86-video-intel 915resolution libsdl lunux-joystick
wget http://zlib.net/fossils/zlib-1.2.3.3.tar.gz
wget http://github.com/libsdl-org/SDL-1.2/archive/refs/heads/main.zip 
#--no-check-certificate
wget http://download.tuxfamily.org/hatari/1.4.0/hatari-1.4.0.tar.bz2
unzip main.zip
cd SDL-1.2-main
./configure
make
make install
cd ..
tar -zxvf zlib-1.2.3.3.tar.gz
cd zlib-1-2.3.3
./configure
make
make install
tar -xvf hatari-1.4.0.tar.bz2
cd hatari-1.4.0
make clean
cmake .
make install
cd ..
#./configure --enable-sdl-video --enable-sdl-audio --disable-vosf --disable-jit-compiler --with-x --with-gtk --with-mon
#wget https://download.tuxfamily.org/hatari/1.8.0/hatari-1.8.0.tar.bz2
#tar -xvf hatari-1.8.0.tar.bz2
#cd hatari-1.8.0
#./configure
#cmake .
#
#./configure
#make install
#cd SDL-1.2-main
#make clean
#./configure & make & make install
#cd ..
#cd hatari-1.4.0
#make install
#/usr/local/bin/hatari
#mc
#sl -sd /usr/local/lib/libSDL-1.2.so.0 /usr/lib/libSDL.so.0
#tazpkg get-install fuse
#tazpkg get-install fuse-emulator
#tazpkg get-install QtWeb
#tazpkg get-install git
#git clone http://git.code.sf.net/p/unrealspeccyp/usp unrealspeccyp-usp
#cd unrealspeccyp-usp
#cd ./unrealspeccyp-usp/build/cmake
#cmake .
#tazpkg get-install curl
#tazpkg search-pkgname curl
#tazpkg get-install curl-dev
#cmake .
#make
#./configure
