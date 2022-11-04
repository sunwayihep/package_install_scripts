### useful package build scripts

#### Get source code
- run `src/get_source.sh` script to download all the packages.

#### Install CUDA-aware MPI
- set up environment in `openmpi/env.sh` and run `openmpi/build_all.sh` to install the OpenMPI with CUDA support.

#### Install USQCD packages
- set up environment in `chroma-gpu-double/env.sh`

- build the *double* version of chroma, quda, qdp-jit with `chroma-gpu-double/build_all.sh`

*Note*: if the module system is not available, set up the `PATH`, `LD_LIBRARY_PATH`, `C_INCLUDE_PATH`, `CPLUS_INCLUDE_PATH`
for every dependencies packages

#### Issues
---
- "libquda.so: undefined reference to `QDP::QDP_get_global_cache()`" when compile `QUDA`, try to modify the `lib/CMakeLists.txt`
file of `QUDA` from lines of 
```
# target_link_libraries(quda PRIVATE QDPXX::qdp)
```
into
```
target_link_libraries(quda PRIVATE QDPXX::qdp QDPXX::jit)
```
