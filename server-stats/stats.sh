#!/bin/bash

echo "###############"
echo "# System Info #"
echo "###############"

. /etc/os-release
echo "OS: $PRETTY_NAME"
echo "Uptime: $(uptime)"

echo

echo "###################"
echo "# Total CPU Usage #"
echo "###################"

top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}'

echo

echo "######################"
echo "# Total Memory Usage #"
echo "######################"
free | grep "Mem:" -w | awk '{printf "Total: %.1fGi\nUsed: %.1fGi (%.2f%%)\nFree: %.1fGi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'

echo

echo "####################"
echo "# Total Disk Usage #"
echo "####################"
# Accounting for reserved space.
df -h | grep "/" -w | awk '{printf "Total: %sG\nUsed: %s (%.2f%%)\nFree: %s (%.2f%%)\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}'

echo

echo "################################"
echo "# Top 5 Processes by CPU Usage #"
echo "################################"
ps -eo pid,cmd,%cpu --sort=-%cpu | sed 1d | head -n 5

echo

echo "###################################"
echo "# Top 5 Processes by Memory Usage #"
echo "###################################"
ps -eo pid,ppid,cmd,%mem,rss --sort=-%mem | head -n 5

echo

echo "###################"
echo "# Logged-in users #"
echo "###################"
who | awk '{print $1}' | sort | uniq

echo

echo "################################"
echo "# Last 5 failed login attempts #"
echo "################################"
tail -n 5 /var/log/auth.log
