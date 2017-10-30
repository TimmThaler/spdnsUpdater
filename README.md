# spdnsUpdate -- Securepoint DNS Updater
# Shell Version

Bash script based on [Gerold Bausch's python script](https://github.com/gbausch/spdnsUpdater) to update IP addresses on [Securepoint Dynamic DNS Service](https://spdyn.de).

**Usage:**
-	Recommended usage:	```./spdnsUpdater.sh <hostname> <token>```
-	Alternative usage:	```./spdnsUpdater.sh <hostname> <user> <passwd>```

In case you want to auto update the device ip address at every reboot, insert one of the lines above in ```/etc/rc.local``` (Linux only).

**Required packages:** ```curl```
