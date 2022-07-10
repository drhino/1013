#!/bin/bash

DESTINATION="/Applications"

mkdir "${DESTINATION}/HighSierraDownload"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog.gz" --output "${DESTINATION}/HighSierraDownload/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog.gz"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/AppleDiagnostics.chunklist" --output "${DESTINATION}/HighSierraDownload/AppleDiagnostics.chunklist"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/AppleDiagnostics.dmg" --output "${DESTINATION}/HighSierraDownload/AppleDiagnostics.dmg"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/BaseSystem.chunklist" --output "${DESTINATION}/HighSierraDownload/BaseSystem.chunklist"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/InstallAssistantAuto.pkg" --output "${DESTINATION}/HighSierraDownload/InstallAssistantAuto.pkg"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/InstallESDDmg.chunklist" --output "${DESTINATION}/HighSierraDownload/InstallESDDmg.chunklist"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/InstallInfo.plist" --output "${DESTINATION}/HighSierraDownload/InstallInfo.plist"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/MajorOSInfo.pkg" --output "${DESTINATION}/HighSierraDownload/MajorOSInfo.pkg"
curl -L "https://raw.githubusercontent.com/drhino/1013/main/HighSierraDownload/OSInstall.mpkg" --output "${DESTINATION}/HighSierraDownload/OSInstall.mpkg"

curl -L "https://raw.githubusercontent.com/drhino/1013/main/shasum/HighSierraDownload" --output "${DESTINATION}/HighSierraDownload.txt"

curl -L "https://cloudflare-ipfs.com/ipfs/QmYTUKf6b3dg2gRwMAi6DpUDFBEGUQfgBkyuyD2AFY9Trh/macOS%20High%20Sierra%20Patcher.dmg" --output "${DESTINATION}/macOS-High-Sierra-Patcher.dmg"

echo ""

if [[ ! -f "${DESTINATION}/HighSierraDownload.txt" ]]
then
	echo "ERROR: Checksum file not found: ${DESTINATION}/HighSierraDownload.txt" 1>&2
	echo ""
	exit 1
fi

cd "${DESTINATION}"

CHECKSUM=$(shasum -c "${DESTINATION}/HighSierraDownload.txt")

echo "${CHECKSUM}"

echo ""

FAILED=$(echo "${CHECKSUM}" | grep ": FAILED$")
WARNING=$(echo "${CHECKSUM}" | grep ": WARNING: ")

if [[ -z ${FAILED} && -z ${WARNING} ]]
then
	echo "- CHECKSUM OK -"

	open "${DESTINATION}/macOS-High-Sierra-Patcher.dmg"
fi

echo ""
