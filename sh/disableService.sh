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
# STDERR: "/System/Library/LaunchDaemons/com.apple.xxx.plist: Could not find specified service"
#
#
function disableService() {

	CURRENT_DIR="$(cd "$(dirname "${0}")" && pwd)"

	# Unloads the service immediately.
	if [[ ! -z $(launchctl list | grep "${1}$") ]]
	then
		# Finds the absolute path to the .plist.
		plist=$(cat "${CURRENT_DIR}/disableService.sh.map" | grep "${1}" | awk '{print $2}')

		if [[ ! -z "${plist}" ]]
		then
			#
			# Prints to STDERR on failure with message:
			# "/System/Library/LaunchDaemons/com.apple.xxx.plist: Could not find specified service"
			#
			# Prints nothing on success.
			#
			sudo launchctl unload -w "${plist}"
		else
			echo "DEBUG: disableService(): .plist not defined for: ${1}" 1>&2
		fi
	#elif [[ ! -z "${2}" ]]
	#then
	#	echo "disableService(): ${1}: UNLOADED: OK"
	fi

	# Disables the service after reboot.
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
