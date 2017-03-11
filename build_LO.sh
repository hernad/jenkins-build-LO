#!/bin/bash

BRANCH=master
DATE="Mar 9 2017"

#BRANCH=libreoffice-5-3

cd /cygdrive/e/LO

export LO_HOME=/cygdrive/e/LO
export LODE_HOME=$LO_HOME/lode
export PATH=$LODE_HOME/opt/bin:$PATH

echo $PATH

INIT=0
[ "$1" == "--init" ] && INIT=1

BUILD_HOST="greenbox-5 vagrant W7-PRO" 

cd $LO_HOME/libo-core

git checkout -f $BRANCH

if [ $INIT == 1 ] ; then
   git pull
   #git pull
fi



echo "BRANCH - git rev-list -1 --before="$DATE" $BRANCH"
COMMIT=`git rev-list -1 --before="$DATE" $BRANCH`
echo === git checkout -f $COMMIT ==
git checkout -f $COMMIT

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
#    --with-product-name="LO" CXXFLAGS="/wd4702"   \
#    --with-locales="bs en" \
#    --enable-pch --disable-ccache --disable-activex --disable-atl \
#    --with-lang="bs en-US" 

./autogen.sh \
    --disable-firebird-sdbc \
    --enable-release-build \
    --disable-online-update \
    --with-build-version="Built by hernad"  --with-vendor="bring.out" \
    --with-extra-buildid="hernad $BUILD_HOST visual studio 2013-cygwin"  \
    --with-product-name="LO" \
    --with-locales="bs en" \
   --enable-pch --disable-ccache --disable-activex --disable-atl \
   --with-lang="bs en-US" 


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


mv instdir LO
tar -cvzf LO.tar.gz LO
cp LO.tar.gz //vboxsrv/vagrant/
rm LO.tar.gz

