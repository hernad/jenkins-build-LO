#!/bin/bash

LO_TAR_GZ=LO_Windows_5-3.tar.gz
BRANCH=libreoffice-5-3
BUILD_HOST="greenbox-5 vagrant W7-vs2013" 
BUILD_ID="hernad $BUILD_HOST"

# windows drive letter for attached disk e:\
DRIVE_LETTER=e

[ -d /cygdrive/$DRIVE_LETTER ] || DRIVE_LETTER=g

cd /cygdrive/$DRIVE_LETTER/LO
export LO_HOME=/cygdrive/$DRIVE_LETTER/LO
export LODE_HOME=$LO_HOME/lode
export PATH=$LODE_HOME/opt/bin:$PATH

echo $PATH

INIT=0
[ "$1" == "--init" ] && INIT=1


cd $LO_HOME/core

git checkout -f $BRANCH

if [ $INIT == 1 ] ; then
   git pull
   #git pull
fi



git checkout -f

perl  -i.original -pe 's/find_msms$/echo no_find_sms/sg'  configure.ac

#./autogen.sh \
#    --disable-firebird-sdbc --without-doxygen \
#    --disable-report-builder --disable-lpsolve --disable-coinmp  --disable-pdfimport  --disable-cve-tests \
#    --disable-collada \
#    --without-java --without-help --without-myspell-dicts --disable-odk \
#    --disable-scripting-beanshell --disable-scripting-javascript --disable-extension-update  --disable-scripting-javascript  \
#    --enable-release-build --enable-online-update=no \
#    --disable-report-builder --disable-odk \
#    --disable-sdremote  --disable-collada   --disable-extension-integration \
#    --without-help --without-myspell-dicts --disable-sdremote --disable-online-update --without-galleries \
#    --with-build-version="Built by hernad"  --with-vendor="bring.out" \
#    --with-extra-buildid="hernad $BUILD_HOST visual studio 2013-cygwin"  \
#    --with-product-name="LO"  \
#    --with-locales="bs en" \
#    --enable-pch --disable-ccache --disable-activex --disable-atl \
#    --with-lang="bs en-US" 

./autogen.sh \
    --disable-firebird-sdbc \
    --enable-release-build \
    --disable-online-update \
    --with-build-version="Built by hernad"  --with-vendor="bring.out" \
    --with-extra-buildid="$BUILD_ID" \
    --with-product-name="LO" CXXFLAGS="/wd4702 /wd2220 /wd4995"  \
    --with-locales="bs en" \
   --enable-pch --disable-ccache --disable-activex --disable-atl \
   --with-lang="bs en-US"  \
   --with-windows-sdk=7.1A


# CXXFLAGS="/wd4702"   \
#--with-windows-sdk=7.1A  \
#--without-system-libxml

# tests off
#perl   -i.original -pe 'BEGIN{undef $/;} s/^\$\(call gb.*Cppunit \$\*\)\)\)\)$/\t\@echo notestnotest/smg'  solenv/gbuild/CppunitTest.mk

#pocetak:
#$(call gb_CppunitTest_get_target,%) :| $(gb_CppunitTest_RUNTIMEDEPS)
#
#kraj:
#..... Cppunit $*)))
# libreoffice-5-3 CppUnit $*)))) # 4x right bracket

perl  -i.original -pe 'BEGIN{undef $/;} s/^\$\(call gb_CppunitTest_get_target.*Cppunit \$\*\){3,5}$/\t\@echo notestnotest/smg'  solenv/gbuild/CppunitTest.mk

[ $INIT == 1 ] && $LODE_HOME/opt/bin/make clean

$LODE_HOME/opt/bin/make
$LODE_HOME/opt/bin/make sw.all
$LODE_HOME/opt/bin/make sc.all

rm -rf LO
mv instdir LO
tar -cvzf $LO_TAR_GZ LO
cp $LO_TAR_GZ //vboxsrv/vagrant/
rm LO.tar.gz

