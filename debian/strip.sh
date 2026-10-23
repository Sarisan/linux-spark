#!/bin/sh -e

llvm=${1}
kernelrelease=${2}

alias readelf="llvm-readelf${llvm}"
alias objcopy="llvm-objcopy${llvm}"
alias strip="llvm-strip${llvm}"

(
    find "${PWD}/debian/linux-image-${kernelrelease}/usr/lib/modules" -type f -name "*.ko"
    echo "${PWD}/debian/linux-image-${kernelrelease}-dbg/usr/lib/debug/boot/vmlinux-${kernelrelease}"
) | while read -r module
do
    echo "  STRIP   ${module}"

    build_id=$(readelf -n "${module}" | grep "Build ID" | tr -d '[:space:]' | cut -d ':' -f 2)
    id_dir=$(printf '%s' "${build_id}" | cut -c 1-2)
    id_file=$(printf '%s' "${build_id}" | cut -c 3-)

    target_dir=${PWD}/debian/linux-image-${kernelrelease}-dbg/usr/lib/debug/.build-id/${id_dir}
    target_file=${target_dir}/${id_file}.debug
    mkdir -p "${target_dir}"

    objcopy --only-keep-debug "${module}" "${target_file}"
    strip --strip-debug "${module}"
    objcopy --add-gnu-debuglink="${target_file}" "${module}"
done

find "${PWD}/debian/linux-image-${kernelrelease}/usr/lib/modules" -type f -name "*.ko" | while read -r module
do
    echo "  SIGN    ${module}"
    "${PWD}/build/scripts/sign-file" sha512 \
        "${PWD}/build/certs/signing_key.pem" \
        "${PWD}/build/certs/signing_key.x509" \
        "${module}"
done

find "${PWD}/debian/linux-image-${kernelrelease}/usr/lib/modules" -type f -name "*.ko" | while read -r module
do
    echo "  ZSTD    ${module}"
    zstd --rm -19 -q -T0 "${module}"
done
