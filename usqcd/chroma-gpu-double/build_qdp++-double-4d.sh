#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

pushd ${SRCDIR}/qdpxx
#autoreconf -f
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++-double-4d ]; 
then 
  rm -rf ./build_qdp++-double-4d
fi

mkdir  ./build_qdp++-double-4d
cd ./build_qdp++-double-4d

#export PATH=/home/wsun/software/JlabCode/install/libxml2/bin:$PATH
#export LD_LIBRARY_PATH=${HOME}/software/JlabCode/install/libxml2/lib:$LD_LIBRARY_PATH

${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++-double-4d \
	--with-qmp=${INSTALLDIR}/qmp \
        --enable-parallel-arch=parscalar \
	--enable-db-lite \
	--enable-precision=double \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
	--disable-generics \
	--enable-sse4 \
	--with-libxml2=${INSTALLDIR}/libxml2 \
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
