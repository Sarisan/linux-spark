#!/bin/sh -e

name=${1}
kernelrelease=${2}

echo "Generating debian/control"
sed -e "s/@NAME@/${name}/g" \
    -e "s/@KERNELRELEASE@/${kernelrelease}/g" \
    "${PWD}/debian/control.in" > "${PWD}/debian/control"

echo "Generating debian/linux-image-${kernelrelease}.postinst"
sed -e "s/@KERNELRELEASE@/${kernelrelease}/g" \
    "${PWD}/debian/linux-image.postinst.in" > "${PWD}/debian/linux-image-${kernelrelease}.postinst"
chmod +x "${PWD}/debian/linux-image-${kernelrelease}.postinst"

echo "Generating debian/linux-image-${kernelrelease}.postrm"
sed -e "s/@KERNELRELEASE@/${kernelrelease}/g" \
    "${PWD}/debian/linux-image.postrm.in" > "${PWD}/debian/linux-image-${kernelrelease}.postrm"
chmod +x "${PWD}/debian/linux-image-${kernelrelease}.postrm"
