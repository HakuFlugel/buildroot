#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

search="console=tty1 console=ttyAMA0,115200"
replace="console=tty3"
filename="${BINARIES_DIR}/rpi-firmware/cmdline.txt"

if [[ $search != "" && $replace != "" ]]; then
sed -i "s/$search/$replace/" $filename
fi


cp "${BOARD_DIR}/config_cm4io_64bit_custom.txt" "${BINARIES_DIR}/rpi-firmware/config.txt"

# Pass an empty rootpath. genimage makes a full copy of the given rootpath to
# ${GENIMAGE_TMP}/root so passing TARGET_DIR would be a waste of time and disk
# space. We don't rely on genimage to build the rootfs image, just to insert a
# pre-built one in the disk image.

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"
cp "${BOARD_DIR}/uart-ctsrts.dtbo" "${BINARIES_DIR}/rpi-firmware/overlays/"
genimage \
	--rootpath "${ROOTPATH_TMP}"   \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
