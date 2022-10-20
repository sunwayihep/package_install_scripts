##### 
# SET UP ENVIRONMENT
export CUDA_INSTALL_PATH=/usr/local/cuda-9.2
export MPI_HOME=/usr/local/mvapich2-2.2-gcc-6.3-cuda-9.2
export GCC_HOME=/usr
OMP="yes"
SM=sm_60     # Pascal
export PATH=${CUDA_INSTALL_PATH}/bin:${MPI_HOME}/bin:$PATH
export PATH=/usr/local/bin:$PATH

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install/${SM}
if [ "x${OMP}x" == "xyesx" ];
then
 INSTALLDIR=${INSTALLDIR}_omp
fi

LLVM_INSTALL_DIR=${INSTALLDIR}/llvm-6.0.0-nvptx



SRCDIR=${TOPDIR}/../src
BUILDDIR=${TOPDIR}/build


### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
PK_CUDA_HOME=${CUDA_INSTALL_PATH}
PK_MPI_HOME=${MPI_HOME}
PK_GPU_ARCH=${SM}

### OpenMP
# Open MP enabled
if [ "x${OMP}x" == "xyesx" ]; 
then 
 OMPFLAGS="-fopenmp -D_REENTRANT "
 OMPENABLE="--enable-openmp"
else
 OMPFLAGS=""
 OMPENABLE=""
fi

if [ ! -d ${INSTALLDIR} ];
then
  mkdir -p ${INSTALLDIR}
fi
### COMPILER FLAGS
ARCHFLAGS="-march=native"
DEBUGFLAGS="-g"

PK_CXXFLAGS=${OMPFLAGS}" "${ARCHFLAGS}" "${DEBUGFLAGS}" -O3 -std=c++11 -fexceptions -frtti"

PK_CFLAGS=${OMPFLAGS}" "${ARCHFLAGS}" "${DEBUGFLAGS}" -O3 -std=gnu99"
PK_LDFLAGS="${OMPFLAGS} -L${LLVM_INSTALL_DIR}/lib -L${PK_CUDA_HOME}/lib64 -L${PK_CUDA_HOME}/nvvm/lib64  -Wl,-rpath,${LLVM_INSTALL_DIR}/lib -Wl,-rpath,${PK_CUDA_HOME}/lib64 -Wl,-rpath,${PK_CUDA_HOME}/nvvm/lib64 -Wl,-rpath,${MPI_HOME}/lib -Wl,-rpath,${GCC_HOME}/lib64 -Wl,-rpath,${GCC_HOME}/lib"
PK_LIBS="-ldl -lpthread"


### Make
MAKE="make -j 10"

### MPI and compiler choices

PK_CC=mpicc
PK_CXX=mpicxx
PK_LLVM_CXX=g++-6
PK_LLVM_CC=gcc-6
PK_LLVM_CFLAGS=" -O3 -std=c99"
PK_LLVM_CXXFLAGS=" -O3 -std=c++11" 
QDPJIT_HOST_ARCH="X86;NVPTX"
