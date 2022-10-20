##### 
# SET UP ENVIRONMENT
module load use.own
module load lqcd/gpu/gcc/7.3.1
module load lqcd/gpu/cmake/3.20.0
module load lqcd/gpu/cuda/11.0
module load lqcd/gpu/mpi/openmpi/4.1.0-ucx-cuda11.0-gcc7
module list 

export PK_CUDA_HOME=/usr/local/cuda-11.0
export PK_MPI_HOME=${MPI_ROOT}
export GCC_HOME=/opt/rh/devtoolset-7/root/usr/

SM=sm_70     # NVIDIA V100
OMP="yes"


# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install
#INSTALLDIR=/cvmfs/software.csns.ihep.ac.cn/softwares/LQCD

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build


#if [ "x${OMP}x" == "xyesx" ];
#then
# INSTALLDIR=${INSTALLDIR}_omp
#fi

# LLVM Install Directory
LLVM_INSTALL_DIR=${INSTALLDIR}/llvm-6.0.0
export PATH=${LLVM_INSTALL_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=${LLVM_INSTALL_DIR}/lib:${LD_LIBRARY_PATH}



### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
export LD_LIBRARY_PATH=${PK_CUDA_HOME}/nvvm/lib64:${LD_LIBRARY_PATH}

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
PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++14 "

PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=gnu99"

PK_LDFLAGS="${OMPFLAGS} -L${LLVM_INSTALL_DIR}/lib -L${PK_CUDA_HOME}/lib64 -L${PK_CUDA_HOME}/nvvm/lib64  -Wl,-rpath=${LLVM_INSTALL_DIR}/lib -Wl,-rpath=${PK_CUDA_HOME}/lib64 -Wl,-rpath=${PK_CUDA_HOME}/nvvm/lib64 -Wl,-rpath=${MPI_HOME}/lib -Wl,-rpath=${GCC_HOME}/lib64 -Wl,-rpath=${GCC_HOME}/lib/gcc/x86_64-redhat-linux/7"
PK_LIBS="-ldl -pthread"

### Make
MAKE="make -j 32"

### MPI
PK_CC=mpicc
PK_CXX=mpicxx
QDPJIT_HOST_ARCH="X86;NVPTX"
PK_LLVM_CXX=g++
PK_LLVM_CC=gcc
PK_LLVM_CFLAGS="-O3 -std=c99"
PK_LLVM_CXXFLAGS="-O3 -std=c++11"
