#!/bin/bash

# MPI related, build if necessary
# UCX
git clone --recursive git@github.com:openucx/ucx.git

# OpenMPI
wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.3.tar.bz2
tar -xvf openmpi-4.1.3.tar.bz2

# Third party library
# Eigen
wget https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.bz2
tar -xvf eigen-3.4.0.tar.bz2

# LLVM
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/llvm-13.0.0.src.tar.xz
tar -xvf llvm-13.0.0.src.tar.xz

# LQCD software
# QMP
git clone --recursive git@github.com:usqcd-software/qmp.git

# QDP++
git clone --recursive --branch devel git@github.com:usqcd-software/qdpxx.git

# QDP-JIT
git clone --recursive --branch devel git@github.com:JeffersonLab/qdp-jit.git

# QUDA
git clone --recursive git@github.com:lattice/quda.git

# Chroma
git clone --recursive --branch devel git@github.com:JeffersonLab/chroma.git

