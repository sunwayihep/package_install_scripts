#!/bin/bash
#################
# BUILD Chroma
#################
source env.sh

#pushd ${SRCDIR}/chroma
#autoreconf
#popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-double ];
then
rm -rf ./build_chroma-double
fi

mkdir  ./build_chroma-double
cd ./build_chroma-double

cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/chroma-double \
			      -DCMAKE_CXX_COMPILER="${PK_CXX}" \
			      -DCMAKE_CXX_FLAGS="${PK_CXXFLAGS} -fPIC" \
			      -DCMAKE_C_COMPILER="${PK_CC}" \
			      -DCMAKE_C_FLAGS="${PK_CFLAGS} -fPIC" \
			     -DQDPXX_DIR=${INSTALLDIR}/qdpjit-double-llvm/lib/cmake/QDPXX \
			     -DQMP_DIR=${INSTALLDIR}/qmp-2.5.4-openmpi/lib/cmake/QMP \
			     -DChroma_ENABLE_JIT_CLOVER=ON \
			     ${SRCDIR}/chroma

${MAKE}
${MAKE} install

popd
