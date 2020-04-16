#!/bin/bash
# This script will download and add domains from the rep to adblockplus_blocklist.txt file.
# Project homepage: https://github.com/kevinkok/pihole_scripts
# Licence: https://github.com/kevinkok/pihole_scripts/blob/master/LICENSE
# Created by KevinKok
#================================================================================
TICK="[\e[32m ✔ \e[0m]"
PIHOLE_LOCATION="/etc/pihole"
BLOCKLIST_LOCATION="/root/adblockplus_blocklist.txt"
GRAVITY_UPDATE_COMMAND="pihole -g"

echo -e " \e[1m This script will download and add domains from the repo to adblockplus_blocklist.txt \e[0m"
sleep 1
echo -e "\n"

if [ "$(id -u)" != "0" ] ; then
	echo "This script requires root permissions. Please run this as root!"
	exit 2
fi

echo -e " ${TICK} \e[32m Retrieving domains... \e[0m"
curl -s -L https://easylist-downloads.adblockplus.org/fanboy-social.txt https://raw.githubusercontent.com/k2jp/abp-japanese-filters/master/abpjf.txt https://raw.githubusercontent.com/ABPindo/indonesianadblockrules/master/subscriptions/abpindo.txt https://280blocker.net/files/280blocker_adblock.txt https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt https://easylist-downloads.adblockplus.org/malwaredomains_full.txt > adblock.unsorted

#curl -sS https://easylist.to/easylist/easylist.txt | sudo tee -a "${BLOCKLIST_LOCATION}" >/dev/null

sleep 0.1

echo -e " ${TICK} \e[32m Sorting blocklist... \e[0m"
sort -u adblock.unsorted | grep ^\|\|.*\^$ | grep -v \/ > adblock.sorted

sleep 0.1

echo -e " ${TICK} \e[32m Formatting blocklist... \e[0m"
sed 's/[\|^]//g' < adblock.sorted > "${BLOCKLIST_LOCATION}"

echo -e " ${TICK} \e[32m Removing unnecessary files... \e[0m"
rm adblock.unsorted adblock.sorted

echo -e " ${TICK} \e[32m Removing duplicates... \e[0m"
mv "${BLOCKLIST_LOCATION}" "${BLOCKLIST_LOCATION}".old && cat "${BLOCKLIST_LOCATION}".old | sort | uniq >> "${BLOCKLIST_LOCATION}"

echo -e " [...] \e[32m Pi-hole gravity rebuilding lists. This may take a while... \e[0m"
${GRAVITY_UPDATE_COMMAND} > /dev/null
 
echo -e " ${TICK} \e[32m Pi-hole's gravity updated \e[0m"
echo -e " ${TICK} \e[32m Done! \e[0m"