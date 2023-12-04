#!/bin/bash
#
#################
# BUILD QDPJIT
#################
source ./env.sh

pushd ${BUILDDIR}

if [ -d ./build_qdpjit-double ]; 
then 
  rm -rf ./build_qdpjit-double
fi

mkdir  ./build_qdpjit-double
cd ./build_qdpjit-double

cmake -DCMAKE_INSTALL_PREFIX="${INSTALLDIR}/qdpjit/qdpjit-double-llvm13" \
	  -DCMAKE_CXX_COMPILER="${PK_CXX}" \
	  -DCMAKE_CXX_FLAGS="${PK_CXXFLAGS} -fPIC" \
	  -DCMAKE_C_COMPILER="${PK_CC}" \
	  -DCMAKE_C_FLAGS="${PK_CFLAGS} -fPIC" \
	  -DCUDA_TOOLKIT_ROOT_DIR="${PK_CUDA_HOME}" \
	  -DQDP_ENABLE_BACKEND=CUDA \
	  -DQDP_PRECISION=double \
	  -DQDP_ENABLE_LLVM13=ON \
      -DQDP_PROP_OPT=ON \
	  -DQDP_ENABLE_CUSTOM_KERNELS=OFF \
	  -DQDP_PARALLEL_ARCH=parscalar \
	  -DQMP_DIR="${INSTALLDIR}/qmp/qmp-2.5.4-openmpi/lib/cmake/QMP" \
	  -DLLVM_DIR="${INSTALLDIR}/llvm/13.0.0/lib/cmake/llvm" \
	  ${SRCDIR}/qdp-jit

${MAKE}
${MAKE} install

popd
