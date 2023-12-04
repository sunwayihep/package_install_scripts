#!/bin/bash
#################
# BUILD chromaxx
#################
source env.sh

pushd ${BUILDDIR}

if [ -d ./build_chromaxx-double ];
then
rm -rf ./build_chromaxx-double
fi

mkdir  ./build_chromaxx-double
cd ./build_chromaxx-double

cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/chromaxx-double \
      -DCMAKE_CXX_COMPILER="${PK_CXX}" \
      -DCMAKE_CXX_FLAGS="${PK_CXXFLAGS} -fPIC" \
      -DCMAKE_C_COMPILER="${PK_CC}" \
      -DCMAKE_C_FLAGS="${PK_CFLAGS} -fPIC" \
      -DChroma_DIR=${INSTALLDIR}/chroma-double/lib/cmake/Chroma \
      -DQDPXX_DIR=${INSTALLDIR}/qdpjit-double-llvm/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLDIR}/qmp-2.5.4-openmpi/lib/cmake/QMP \
      ${SRCDIR}/chromaxx

make VERBOSE=1 -j 8
make -j 8 install
popd
