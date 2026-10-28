#!/bin/sh -e

while [ ${#} -gt 0 ]
do
    case "${1}" in
        (--upstream-version)
            version="${2}"
            shift 2
        ;;
        (*)
            exit 1
        ;;
    esac
done

tar -xC .. -f ../linux-${version}.tar.xz
cp -a debian ../linux-${version}
make -C ../linux-${version} -f debian/rules debian/control
