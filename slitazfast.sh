#Суть этого отладочного скрипта:
#Тестируется он в VirtualBox, вживую и на Asus EEE701 и на R2H. Лень его разбивать под отдельное железо.
#
#Ставим Slitaz Linux, запускаем скрипт, ждем минут 10-20 и все готово. Все что нужно- установлено. И не надо пол дня мышкой кликать, вспоминать а как я ставил то, а как это.
#Вообще можно и не Slitaz - меняем установщик и то же самое.
#Script version Alpha 0.01 (20230928-2)
#
#Создан для эмуляторов Hatari-1.4.0 и USP. Пока старые версии. Но пока так. Цель- SDL 1.2 и раза в два бысрее чем SDL 2.0
#В Slitaz есть несколько полезных команд- tazhw detect-pci и tazpkg detect-usb. Не забываем про них.
#Не забываем про утилиту ARANDR (если в ПК есть ТВ выход, и надо лампово выводить на кинескоп то полезно)
#В дальнейшем скрипт будет разбит на несколько частей.
#1. Установка WiFi, mc при необходимости. Всякие нужные инструменты.
#2. Установка из исходников самих программ. Скрипт-название и т.п.

#Сначала для профилактики смотрим что используем
# Примерный вывод- Linux 222laptop 2.6.27-4-generic #1 SMP Wed Sep 24 01:30:51 UTC 2008 i686 GNU/Linux
uname -a

#Смотрим какой у нас компилятор (чтоб не было лишних вопросов)
#Примерный вывод- gcc (Ubuntu 4.3.2-1ubuntu10) 4.3.2 Copyright (C) 2008
gcc --version

#Поддержке WiFi свистка из приставки Nemo TV (ради любопытства в Slitaz завелся, в свое время читал что под Windows драйверов не существует)
#Ralink RT3572, PID=148B:5273
modinfo rt2800usb
#Поддержка WiFi в Планшете Asus R2H/R2HV 
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

#Для экранов "4:3" (800x600) лучше ~hatari-1.9.0 но у нас 800x480 и поэтому этот вариант не подходит (можно, но не комфортно)
#wget https://download.tuxfamily.org/hatari/1.9.0/hatari-1.9.0.tar.bz2 --no-check-certificate
#tar -xvf hatari-1.9.0.tar.bz2
#cd hatari-1.9.0
#./configure
#make clean
#make install
#make uninstall
#cd ..

#Для экранов "16:9" (800x480, который у Asus EEE701, Asus R2H/R2HV и т.п.) лучше ~hatari-1.4.0
tazpkg get-install hatari
tazpkg remove hatari
wget https://download.tuxfamily.org/hatari/1.4.0/hatari-1.4.0.tar.bz2 --no-check-certificate
tar -xvf hatari-1.4.0.tar.bz2
cd hatari-1.4.0
make clean
#Обратить внимание! HATARI 1.4.0 компилируется именно cmake а не make!!!
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
#
#Старое от 2008 года. Установка Android на Asus EEE701 https://groups.google.com/g/android-porting/c/ZoYr21LayTY
#Исходно https://web.archive.org/web/20120623022430/http://virtuallyshocking.com:80/2008/12/20/building-android-for-the-asus-eeepc-701/
#
#
#Авторство, вопросы и т.д. http://t.me/zxcoupe 
#Скрипт создавался для http://t.me/atarist
