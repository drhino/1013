#!/bin/bash

DESTINATION="/Applications"
SUCATALOG="index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog.gz"

mkdir "${DESTINATION}/HighSierraDownload"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/${SUCATALOG}" --output "${DESTINATION}/HighSierraDownload/${SUCATALOG}"
curl -L "https://cloudflare-ipfs.com/ipfs/QmYTUKf6b3dg2gRwMAi6DpUDFBEGUQfgBkyuyD2AFY9Trh/macOS%20High%20Sierra%20Patcher.dmg" --output "${DESTINATION}/macOS-High-Sierra-Patcher.dmg"

echo ""

if [[ "c07629275caa38b18b701338ebd27ad6c7f91146" != $(shasum "${DESTINATION}/HighSierraDownload/${SUCATALOG}" | awk '{print $1}') ]]
then
	echo "ERROR: Wrong shasum: '${DESTINATION}/HighSierraDownload/${SUCATALOG}'" 1>&2
	HASERROR=true
fi

if [[ "73f180d30200ef5f6d900440fe57b9c7d22bd6bf" != $(shasum "${DESTINATION}/macOS-High-Sierra-Patcher.dmg" | awk '{print $1}') ]]
then
	echo "ERROR: Wrong shasum: '${DESTINATION}/macOS-High-Sierra-Patcher.dmg'" 1>&2
	HASERROR=true
fi

if [[ -z ${HASERROR} ]]
then
	echo "-OK-"

	open "${DESTINATION}/macOS-High-Sierra-Patcher.dmg"
fi

echo ""
