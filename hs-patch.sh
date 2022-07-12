#!/bin/bash

# /bin/bash hs-patch.sh [ --scan ]

BIN_PATH="/usr/local/bin/drhino-1013"

# Removes the existing files.
# -> Updates to newer version.
# -> Removes corrupted files.
if [[ -d "${BIN_PATH}" ]]
then
	rm -rf "${BIN_PATH}"
fi

# Creates the directory structure.
mkdir "${BIN_PATH}"
mkdir "${BIN_PATH}/sh/"

# Defines the latest files.
downloadFiles=(
	"sh/disableService.sh.map"
	"sh/disableService.sh"
	"sh/disableServices.sh"
)

# Pulls the latest files.
for file in "${downloadFiles[@]}"
do :
	curl -sSL "https://raw.githubusercontent.com/drhino/1013/main/${file}" --output "${BIN_PATH}/${file}"
done

# Sets execution permissions for nested files.
chmod u+x "${BIN_PATH}/sh/disableService.sh"
# ...

# Disables the services if necessary.
# When a service is successfully disabled, a message is shown.
# When disabling a service failed, an error is thrown.
# When a service is already disabled, nothing is returned.
# -> Shows what has succeeded, failed, or nothing at all.
/bin/bash "${BIN_PATH}/sh/disableServices.sh" "${1}"

# ...

# Removes the working files.
rm -rf "${BIN_PATH}"
