#!/bin/bash
source env.sh

pushd ${BUILDDIR}
if [ -d ./build_openmpi ];
then
	rm -rf ./build_openmpi
sleep 1
fi
mkdir ./build_openmpi
cd ./build_openmpi

${SRCDIR}/openmpi-4.1.3/configure --prefix="${INSTALLDIR}/openmpi/4.1.3-ucx-cuda"  \
	--with-cuda="/usr/local/cuda-11.7" \
	--with-pmi="/usr/include/slurm" \
	CFLAGS="-I /usr/include/slurm" \
	--with-pmi-libdir="/usr/lib64" \
	--with-ucx="${INSTALLDIR}/ucx/1.12.1-cuda11.7"
make -j24 install

popd

