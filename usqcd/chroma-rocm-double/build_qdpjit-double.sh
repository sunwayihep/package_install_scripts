#!/bin/bash
#################
# BUILD QDP-JIT
#################
source ./env.sh

pushd ${BUILDDIR}

if [ -d ./build_qdpjit-double ];
then
rm -rf ./build_qdpjit-double
fi

mkdir -p ./build_qdpjit-double
cd ./build_qdpjit-double

cmake -DCMAKE_INSTALL_PREFIX="${INSTALLDIR}/qdpjit-double-llvm" \
			      -DCMAKE_CXX_COMPILER="${PK_CXX}" \
			      -DCMAKE_CXX_FLAGS="${PK_CXXFLAGS} -fPIC" \
			      -DCMAKE_C_COMPILER="${PK_CC}" \
			      -DCMAKE_C_FLAGS="${PK_CFLAGS} -fPIC" \
			      -DQDP_ENABLE_BACKEND=ROCM \
			      -DLLVM_DIR="/public/software/compiler/dtk-23.04/llvm/lib/cmake/llvm/" \
			      -DLLD_DIR="/public/software/compiler/dtk-23.04/llvm/lib/cmake/lld/" \
			      -DQDP_PRECISION=double \
			      -DQDP_ENABLE_LLVM14=ON \
			      -DQDP_PROP_OPT=ON \
			      -DQDP_ENABLE_CUSTOM_KERNELS=OFF \
			      -DQDP_PARALLEL_ARCH=parscalar \
			      -DQMP_DIR="${INSTALLDIR}/qmp-2.5.4-openmpi/lib/cmake/QMP" \
			      ${SRCDIR}/qdp-jit

${MAKE}
${MAKE} install

popd
