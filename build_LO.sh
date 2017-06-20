#!/bin/bash

BRANCH=libreoffice-5-3
BUILD_HOST="greenbox-5 vagrant"
BUILD_ID="hernad $BUILD_HOST"
LO_TAR_GZ=LO_ubuntu_12.04_i386.tar.gz

sudo apt-get update -y
udo apt-get install -y software-properties-common python-software-properties

sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update -y
sudo apt-get install -y gcc-4.9 g++-4.9
sudo update-alternatives --remove-all gcc 
sudo update-alternatives --remove-all g++
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 20
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 20
sudo update-alternatives --config gcc
sudo update-alternatives --config g++
gcc --version


cd /data/LO/core
git checkout -f $BRANCH
git pull


git checkout -f

#perl  -i.original -pe 's/find_msms$/echo no_find_sms/sg'  configure.ac

./autogen.sh --without-doxygen --disable-gtk3 --disable-gstreamer-1-0

# tests off
#perl   -i.original -pe 'BEGIN{undef $/;} s/^\$\(call gb.*Cppunit \$\*\)\)\)\)$/\t\@echo notestnotest/smg'  solenv/gbuild/CppunitTest.mk

#pocetak:
#$(call gb_CppunitTest_get_target,%) :| $(gb_CppunitTest_RUNTIMEDEPS)
#
#kraj:
#..... Cppunit $*)))
# libreoffice-5-3 CppUnit $*)))) # 4x right bracket

perl  -i.original -pe 'BEGIN{undef $/;} s/^\$\(call gb_CppunitTest_get_target.*Cppunit \$\*\){3,5}$/\t\@echo notestnotest/smg'  solenv/gbuild/CppunitTest.mk

make

mv instdir LO
tar -cvzf $LO_TAR_GZ LO
cp $LO_TAR_GZ //vboxsrv/vagrant/
rm $LO_TAR_GZ

