#!/bin/bash
#
#
# Disables a macOS system service (LaunchDaemon).
#
#
#  Disables the service:
#
#    $ disableService "com.apple.xxx"
#
#    -> Prints to STDOUT when the service has been disabled.
#    -> Prints to STDERR when disabling the service failed.
#    -> Prints nothing when the service was already disabled.
#
#
#  Checks whether the service has been disabled:
#
#    $ disableService "com.apple.xxx" --check
#
#    -> Prints to STDOUT when the service is disabled.
#    -> Prints to STDERR when the service is not disabled.
#
#
# STDOUT: "disableService(): com.apple.xxx: OK"
# STDERR: "disableService(): com.apple.xxx: FAILURE"
#
# STDERR: "/System/Library/LaunchDaemons/com.apple.xxx.plist: Could not find specified service"
#
#
CURRENT_DIR="$(cd "$(dirname "${0}")" && pwd)"

#
# Unloads the service immediately.
#
function unloadService() {

	if [[ ! -z $(sudo launchctl list | grep "${1}$") ]]
	then
		if [[ -z "${2}" ]]
		then
			if [[ -z "${SERVICE_MAP}" ]]
			then
				SERVICE_MAP="$(cat "${CURRENT_DIR}/disableService.sh.map")"
			fi

			# Finds the absolute path to the .plist.
			plist=$(echo "${SERVICE_MAP}" | grep "${1}" | awk '{print $2}')

			if [[ -z "${plist}" ]]
			then
				echo "DEBUG: disableService(): .plist not defined for: ${1}" 1>&2
			else
				#
				# Prints to STDERR on failure with message:
				# "/System/Library/LaunchDaemons/com.apple.xxx.plist: Could not find specified service"
				#
				# Prints nothing on success.
				#
				sudo launchctl unload -w "${plist}"

				unloadService "${1}" --check
			fi
		else
			echo "disableService(): ${1}: UNLOAD: FAILURE" 1>&2
		fi
	elif [[ ! -z "${2}" ]]
	then
		echo "disableService(): ${1}: UNLOAD: OK"
	fi
}

#
# Disables the service after a reboot.
# 
function disableService() {

	if [[ -z $(sudo launchctl print-disabled system | grep "\"${1}\" => true") ]]
	then
		if [[ -z "${2}" ]]
		then
			sudo launchctl disable "system/${1}"

			disableService "${1}" --check
		else
			echo "disableService(): ${1}: FAILURE" 1>&2
		fi
	elif [[ ! -z "${2}" ]]
	then
		echo "disableService(): ${1}: OK"
	fi
}

disableService "${1}" "${2}"

if [[ -z "${2}" ]]
then
	unloadService "${1}"
else
	if [[ -z $(sudo launchctl list | grep "${1}$") ]]
	then
		echo "disableService(): ${1}: STOPPED"
	else
		echo "disableService(): ${1}: RUNNING" 1>&2
	fi
fi
