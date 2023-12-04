##### 
# SET UP ENVIRONMENT

module load lqcd/cuda/11.7
module load lqcd/mpi/openmpi/4.1.3/cuda11.7-gcc11
export PK_CUDA_HOME=/usr/local/cuda-11.7
module load lqcd/cmake/3.24.2
module load lqcd/gcc/11.2.1
module list 

SM=sm_70     # NVIDIA V100
OMP="yes"

# build and install directory
mkdir -p build install

TOPDIR=`pwd`
# Install directory
INSTALLDIR=${TOPDIR}/install/${SM}

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build


### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
export LD_LIBRARY_PATH=${PK_CUDA_HOME}/nvvm/lib64:${LD_LIBRARY_PATH}
PK_GPU_ARCH=${SM}

### OpenMP
# Open MP enabled
OMPFLAGS="-fopenmp -D_REENTRANT "
OMPENABLE="--enable-openmp"

### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++11 "

PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=gnu99"

PK_LDFLAGS="${OMPFLAGS} -L${PK_CUDA_HOME}/lib64 -L${PK_CUDA_HOME}/nvvm/lib64 -Wl,-rpath=${PK_CUDA_HOME}/lib64 -Wl,-rpath=${PK_CUDA_HOME}/nvvm/lib64"
PK_LIBS="-ldl -pthread"

### Make
MAKE="make -j 10"

### MPI
PK_CC=mpicc
PK_CXX=mpicxx
QDPJIT_HOST_ARCH="X86;NVPTX"
PK_LLVM_CXX=g++
PK_LLVM_CC=gcc
PK_LLVM_CFLAGS="-O3 -std=c99"
PK_LLVM_CXXFLAGS="-O3 -std=c++11"
