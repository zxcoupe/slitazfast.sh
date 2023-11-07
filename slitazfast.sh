#Суть скрипта:
#Ставим Slitaz Linux, жмакаем скрипт и все готово. Все что нужно- установлено.
#А можно и не Slitaz - меняем установщик и то же самое.
#Script version Alpha 0.01 (20230928-1)
#Скрипт мэйд бай http://t.me/zxcoupe и http://t.me/atarist
#Создан для ванклик-инсталл эмуляторов Hatari-1.4.0 и USP. Пока старые версии. Но пока так.
#В Slitaz есть несколько пллезных хардвать команд- tazhw detect-pci и tazpkg detect-usb. Не забываем про нихю
#Не забываем про утилиту ARANDR (если в ПК есть ТВ выход, и надо лампово выводить на кинескоп то полезно)
#В дальнейшем скрипт будет разбит н анесколько частей.
#1. Установка вифи,mc при необходимости. Всякие нужные инструменты.
#2. Установка из исходников самих программ. Скрипт-название и т.п.

#Поддержке вифи донгла выдернутого из приставки Nemo TV (Ralink RT3572, PID=148B:5273).
modinfo rt2800usb
#Поддержке вифи R2H/R2HV таблэтки
wget http://people.slitaz.org/~mojo/stuff/zd1211rw-firmware-2.21.0.0-1.tazpkg
#Если есть этот файл локально то соотв. положить его.
tazpkg install zd1211rw-firmware-2.21.0.0-1.tazpkg
modprobe zd1211rw

#Обновить репы в Slitaz. Пусть будет.
tazpkg recharge

#Обновить репы в Haiku (это если скрипт переделывать под гайку)
#pkgman update (там так, вместо tazpkg соотв. менять надо)
#Установить HATARI в Гайке. Увы че-то не хотит компилить саму Hatari, но все остальное ставится.
#pkgman install mc gcc make cmake zlib libpng-dev linux-headers readline portaudio arandr xorg-xf86-video-intel 915resolution libsdl lunux-joystick

#И так, общая каша установки. Потом можно убрать ненужное:
tazpkg get-install mc gcc make cmake zlib libpng-dev linux-headers readline portaudio arandr xorg-xf86-video-intel 915resolution libsdl linux-joystick

#Попытка сборки USP из исходников (отложено)
#unreal speccu portable
#wget http://github.aiurs.co/mthuurne/unrealspeccyp/archive/refs/heads/master.zip
#unzip master.zip
#./unrealspeccyp-master/build/linux make
#tazpkg get-install make mesa-dev openal-dev wxWidgets28-dev 
#tazpkg get-install json libpng minizip tinyxml2 wxWidgets zlib

#Рабочий старый бинарник USP!
wget https://bitbucket.org/djdron/unrealspeccyp/downloads/unreal-speccy-portable_0.0.15_i386.deb
tazpkg convert unreal-speccy-portable_0.0.15_i386.deb
tazpkg install unreal-speccy-portable-0.0.15.tazpkg

#Не помню надо нет:
tazpkg get-install gtk-girepository ossp-uuid 

rm main.zip
wget http://github.com/libsdl-org/SDL-1.2/archive/refs/heads/main.zip --no-check-certificate
unzip main.zip
cd SDL-1.2-main
make clean
./configure
make
make install
cd ..

wget http://zlib.net/fossils/zlib-1.2.3.3.tar.gz
tar -xvf zlib-1.2.3.3.tar.gz
cd zlib-1-2.3.3
make clean
./configure
make
make install
cd ..

#Для экранов БЕЗ 800x480 гемора
#wget https://download.tuxfamily.org/hatari/1.9.0/hatari-1.9.0.tar.bz2 --no-check-certificate
#tar -xvf hatari-1.9.0.tar.bz2
#cd hatari-1.9.0
#./configure
#make clean
#make install
#make uninstall
#cd ..

#Для экранов 800x480 (Asus EEE701, Asus R2H/R2H и т.п.)
tazpkg get-install hatari
tazpkg remove hatari
wget https://download.tuxfamily.org/hatari/1.4.0/hatari-1.4.0.tar.bz2 --no-check-certificate
tar -xvf hatari-1.4.0.tar.bz2
cd hatari-1.4.0
make clean
cmake .
make install
cd ..


#Остальная всячина для разборки полетов.

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
