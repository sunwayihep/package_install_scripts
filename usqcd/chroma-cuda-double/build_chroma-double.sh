#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${BUILDDIR}

if [ -d ./build_chroma-double ]; 
then 
  rm -rf ./build_chroma-double
fi

mkdir  ./build_chroma-double
cd ./build_chroma-double

cmake \
	-DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/chroma/chroma-double \
	-DQDPXX_DIR=${INSTALLDIR}/qdpjit/qdpjit-double-llvm13/lib/cmake/QDPXX \
	-DQMP_DIR=${INSTALLDIR}/qmp/qmp-2.5.4-openmpi/lib/cmake/QMP \
	-DChroma_ENABLE_JIT_CLOVER=ON \
	-DChroma_ENABLE_QUDA=ON \
	-DQUDA_DIR=${INSTALLDIR}/quda/quda-qdpjit/lib/cmake/QUDA \
	-DLLVM_DIR=${INSTALLDIR}/llvm/13.0.0/lib/cmake/llvm \
	${SRCDIR}/chroma

${MAKE}
${MAKE} install

popd
