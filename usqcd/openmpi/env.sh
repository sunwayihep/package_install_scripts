module load lqcd/gcc/11.2.1
module load lqcd/cuda/11.7

mkdir -p build install

TOPDIR=`pwd`
SRCDIR=${TOPDIR}/../src
BUILDDIR=${TOPDIR}/build
INSTALLDIR="${TOPDIR}/install"

PK_CXXFLAGS="-g -O3"
PK_CFLAGS="-g -O3"
PK_CXX=g++
PK_CC=gcc

