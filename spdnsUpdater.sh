#!/bin/bash

### Usage
#
#	Recommended usage:	./spdnsUpdater.sh <hostname> <token>
#	Alternative usage:	./spdnsUpdater.sh <hostname> <user> <passwd>
#


### Configuration

# Get current IP address from
get_ip_url="https://api.ipify.org/"
update_url="https://update.spdyn.de/nic/update"


### Update procedure
function spdnsUpdater { 
	# Send the current IP address to spdyn.de
	# and show the response
	
	params=$1
	updater=$(curl -s $update_url $params)
	updater=$(echo $updater | grep -o '^[a-z]*')
	
	case "$updater" in
		abuse) echo "[$updater] Der Host kann nicht aktualisiert werden, da er aufgrund vorheriger fehlerhafter Updateversuche gesperrt ist."
			;;
		badauth) echo "[$updater] Ein ungültiger Benutzername und / oder ein ungültiges Kennwort wurde eingegeben."
			;;
		good) echo "[$updater] Die Hostname wurde erfolgreich auf die neue IP aktualisiert."
			;;
		yours) echo "[$updater] Der angegebene Host kann nicht unter diesem Benutzer-Account verwendet werden."
			;;
		notfqdn) echo "[$updater] Der angegebene Host ist kein FQDN."
			;;
		numhost) echo "[$updater] Es wurde versucht, mehr als 20 Hosts in einer Anfrage zu aktualisieren."
			;;
		nochg) echo "[$updater] Die IP hat sich zum letzten Update nicht geändert."
			;;
		nohost) echo "[$updater] Der angegebene Host existiert nicht oder wurde gelöscht."
			;;
		fatal) echo "[$updater] Der angegebene Host wurde manuell deaktiviert."
			;;
		*) echo "[$updater]"
			;;
	esac

}


if [ $# -eq 2 ]
  	then
  		# if hostname and token
  		# Get current IP address
		currip=$(curl -s "$get_ip_url");
		host=$1
		token=$2
    	params="-d hostname=$host -d myip=$currip -d user=$host -d pass=$token"
    	spdnsUpdater "$params"
	elif [ $# -eq 3 ]
		then
			# if hostname and user and passwd
			# Get current IP address
			currip=$(curl -s "$get_ip_url");
			host=$1
			user=$2
			pass=$3
			params="-d hostname=$host -d myip=$currip -d user=$user -d pass=$pass"
			spdnsUpdater "$params"
	else
		echo
		echo "Updater for Dynamic DNS at spdns.de"
		echo "==================================="
		echo
		echo "Usage:"
		echo "------"
		echo
		echo "Recommended:	./spdnsUpdater.sh <hostname> <token>"
		echo "Alternative:	./spdnsUpdater.sh <hostname> <user> <password>"
		echo
fi

