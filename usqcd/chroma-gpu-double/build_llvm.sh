#!/bin/bash

source ./env.sh

pushd ${BUILDDIR}

if [ -d ./build_llvm-13.0.0 ]; 
then 
  rm -rf ./build_llvm-13.0.0
fi
mkdir  ./build_llvm-13.0.0
pushd ./build_llvm-13.0.0

cmake -G "Unix Makefiles" \
	-DCMAKE_CXX_FLAGS="${PK_LLVM_CXXFLAGS}" \
	-DCMAKE_CXX_COMPILER="${PK_LLVM_CXX}" \
	-DLLVM_ENABLE_TERMINFO="OFF" \
	-DCMAKE_C_COMPILER="${PK_LLVM_CC}" \
	-DCMAKE_C_FLAGS="${PK_LLVM_CFLAGS}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX="${INSTALLDIR}/llvm/13.0.0/" \
	-DLLVM_TARGETS_TO_BUILD="${QDPJIT_HOST_ARCH}" \
	-DLLVM_ENABLE_ZLIB="OFF" \
	-DBUILD_SHARED_LIBS="ON" \
	-DLLVM_ENABLE_RTTI="ON"  \
	${SRCDIR}/llvm-13.0.0.src


${MAKE}
${MAKE} install
popd
popd
