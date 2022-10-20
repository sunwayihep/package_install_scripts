#!/bin/bash
source env.sh

pushd ${SRCDIR}/ucx
./autogen.sh
popd

pushd ${BUILDDIR}
if [ -d ./build_ucx ];
then
	rm -rf ./build_ucx
fi
mkdir ./build_ucx
cd ./build_ucx

${SRCDIR}/ucx/configure --prefix=${INSTALLDIR}/ucx/1.12.1-cuda11.7  \
	--with-cuda=/usr/local/cuda-11.7 \

make -j8 install
popd

