#!/bin/bash
# This script will download and add domains from the rep to adblockplus_blocklist.txt file.
# Project homepage: https://github.com/kevinkok/pihole_scripts
# Licence: https://github.com/kevinkok/pihole_scripts/blob/master/LICENSE
# Created by KevinKok
#================================================================================
TICK="[\e[32m ✔ \e[0m]"

echo -e " \e[1m This script will download and add domains from the repo to adblockplus_blocklist.txt \e[0m"
sleep 1
echo -e "\n"

if [ "$(id -u)" != "0" ] ; then
	echo "This script requires root permissions. Please run this as root!"
	exit 2
fi

echo -e " ${TICK} \e[32m Retrieving domains... \e[0m"
#curl -sS -L https://easylist-downloads.adblockplus.org/fanboy-social.txt https://raw.githubusercontent.com/k2jp/abp-japanese-filters/master/abpjf.txt https://raw.githubusercontent.com/ABPindo/indonesianadblockrules/master/subscriptions/abpindo.txt https://280blocker.net/files/280blocker_adblock.txt https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt https://easylist-downloads.adblockplus.org/malwaredomains_full.txt > /root/adblock.unsorted

#sleep 0.1

#echo -e " ${TICK} \e[32m Sorting blocklist... \e[0m"
#sort -u /root/adblock.unsorted | grep ^\|\|.*\^$ | grep -v \/ > /root/adblock.sorted

#sleep 0.1

#echo -e " ${TICK} \e[32m Formatting blocklist... \e[0m"
#sed 's/[\|^]//g' < /root/adblock.sorted > /root/adblockplus_blocklist.txt

#echo -e " ${TICK} \e[32m Removing unnecessary files... \e[0m"
#rm /root/adblock.unsorted /root/adblock.sorted

#echo -e " ${TICK} \e[32m Removing duplicates... \e[0m"
#mv /root/adblockplus_blocklist.txt /root/adblockplus_blocklist.txt.old && cat /root/adblockplus_blocklist.old | sort | uniq >> /root/adblockplus_blocklist.txt

#echo -e " [...] \e[32m Pi-hole gravity rebuilding lists. This may take a while... \e[0m"
#pihole -g
 
echo -e " ${TICK} \e[32m Pi-hole's gravity updated \e[0m"
echo -e " ${TICK} \e[32m Done! \e[0m"