#!/bin/bash
#################
# BUILD QMP
#################
source env.sh
pushd ${SRCDIR}/qmp
#autoreconf -vif
popd

pushd ${BUILDDIR}

if [ -d ./build_qmp ];
then
rm -rf ./build_qmp
fi

mkdir  ./build_qmp
cd ./build_qmp

cmake -DCMAKE_INSTALL_PREFIX="${INSTALLDIR}/qmp-2.5.4-openmpi" \
			      -DCMAKE_C_COMPILER="${PK_CC}" \
			      -DCMAKE_C_FLAGS="${PK_CFLAGS} -fPIC" \
			      -DCMAKE_C_LINK_FLAGS="${PK_LDFLAGS}" \
			      -DQMP_MPI="ON" \
			      ${SRCDIR}/qmp

${MAKE}
${MAKE} install

popd
