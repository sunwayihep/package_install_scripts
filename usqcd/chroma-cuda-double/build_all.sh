#!/bin/bash
set -e

./build_llvm.sh
./build_qmp.sh
#./build_libxml2.sh
./build_qdpjit-double.sh
./build_quda_qdpjit_double-cmake.sh
./build_chroma-double.sh
