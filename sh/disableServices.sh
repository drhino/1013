#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${0}")" && pwd)"

# V-214869: com.apple.tftp
# V-214824: com.apple.AppleFileServer
# V-214823: com.apple.smbd
# V-214918: com.apple.NetworkSharing
# V-237767: com.apple.screensharing
# V-214864: com.apple.uucp
# V-214825: com.apple.nfsd
# V-214826: com.apple.lockd
# V-214827: com.apple.statd.notify
# V-214899: com.apple.AEServer
# V-214903: com.apple.fingerd
# V-214883: com.apple.ftpd
# V-214882: com.apple.telnetd
# V-214810: com.apple.rshd
# V-214919: org.apache.httpd
# V-214809: com.openssh.sshd
#   Satisfies: V-233627, V-233626, V-214886, V-214887,
#              V-214888, V-233625, V-214878, V-214877 & V-214830
disableServices=(
	"com.apple.tftp"
	"com.apple.AppleFileServer"
	"com.apple.smbd"
	"com.apple.NetworkSharing"
	"com.apple.screensharing"
	"com.apple.uucp"
	"com.apple.nfsd"
	"com.apple.lockd"
	"com.apple.statd.notify"
	"com.apple.AEServer"
	"com.apple.fingerd"
	"com.apple.ftpd"
	"com.apple.telnetd"
	"com.apple.rshd"
	"org.apache.httpd"
	"com.openssh.sshd"
)

for service in "${disableServices[@]}"
do
   : 
   "${CURRENT_DIR}/disableService.sh" "${service}"
done
