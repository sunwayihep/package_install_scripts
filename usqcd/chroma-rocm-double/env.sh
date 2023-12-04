#####
# SET UP ENVIRONMENT
module purge
# use openmpi built with clang 14.0
module use ~/modulefiles
module load openmpi/dtk-23.04/4.1.4-ucx-1.15.0-rocm-clang
module load compiler/cmake/3.23.3
module list
export ROCM_PATH=/public/software/compiler/dtk-23.04
export LIBRARY_PATH=${ROCM_PATH}/hip/lib:${ROCM_PATH}/llvm/lib:${ROCM_PATH}/lib:${ROCM_PATH}/lib64

SM=gfx906     

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install
#INSTALLDIR=/cvmfs/software.csns.ihep.ac.cn/softwares/LQCD

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build

mkdir -p ${INSTALLDIR} ${BUILDDIR}

### COMPILER FLAGS
PK_CXXFLAGS=" -fopenmp -g -O3 -std=c++14 "
PK_CFLAGS=" -fopenmp -g -O3 -std=gnu99"

PK_LDFLAGS=" -fopenmp "
PK_LIBS="-ldl -pthread"

### Make
MAKE="make -j 16"

### MPI
PK_CC=mpicc
PK_CXX=mpicxx
QDPJIT_HOST_ARCH="X86;NVPTX"
