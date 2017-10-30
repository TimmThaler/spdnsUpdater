#!/bin/bash

# spDYN installation on Raspbian for NextcloudPi
#
#
# Copyleft 2017 by Timm Goldenstein
# GPL licensed (see end of file) * Use at your own risk!
#

ACTIVE_=no
DOMAIN_=mycloud.spdyn.de
TOKEN_=your-spdns-token

INSTALLDIR=spdnsupdater
INSTALLPATH=/usr/local/etc/$INSTALLDIR
CRONFILE=/etc/cron.d/spdnsupdater
DESCRIPTION="Free Dynamic DNS provider (need account from https://spdyn.de)"

install() { :; }

configure() 
{
  if [[ $ACTIVE_ == "yes" ]]; then
    mkdir -p "$INSTALLPATH"

    # Creates spdnsUpdater.sh script that checks for updates to DNS records
    wget -O "$INSTALLPATH"/spdnsUpdater.sh https://raw.githubusercontent.com/TimmThaler/spdnsUpdater/master/spdnsUpdater.sh

    # Adds file to cron to run script for DNS record updates and change permissions 
    touch $CRONFILE
    echo "0 * * * * root $INSTALLPATH/spDNSupdater.sh $DOMAIN $TOKEN >/dev/null 2>&1" > "$CRONFILE"
    chmod 700 "$INSTALLPATH"/spdnsUpdater.sh
    chmod +x "$CRONFILE"

    # First-time execution of duck script
    "$INSTALLPATH"/spDNSupdater.sh $DOMAIN $TOKEN > /dev/null 2>&1

    # Removes config files and cron job if ACTIVE_ is set to no
  elif [[ $ACTIVE_ == "no" ]]; then
    rm -f "$CRONFILE"
    rm -f "$INSTALLPATH"/spdnsUpdater.sh
    rmdir "$INSTALLPATH"
    echo "spdnsUpdater is now disabled"
  fi
}

# License
#
# This script is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330,
# Boston, MA  02111-1307  USA
