#!/bin/bash

source /etc/os-release
echo "OS: $PRETTY_NAME\n"

awk '{print "Uptime (seconds):\n", int($1)}' /proc/uptime
awk '{print "Load average (1m 5m 15m):\n", $1, $2, $3}' /proc/loadavg

echo "\nTotal CPU usage:"
awk '/^cpu / {usage=($2+$4)*100/($2+$4+$5)} END {printf "%f%\n", usage}' /proc/stat

echo "\nTotal memory usage:"
awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {
u=t-a;
printf "Used: %.2f%% (%d MB) | Free: %.2f%% (%d MB)\n",
u/t*100, u/1024, a/t*100, a/1024
}' /proc/meminfo

echo "\nTotal Disk Usage:"
df -h / | awk 'NR==2 {
printf "Total: %s | Used: %s (%s) | Free: %s\n", $2, $3, $5, $4
}'

echo "\nTop 5 processes by CPU usage:"
ps -eo pid,cmd,%cpu --sort=-%cpu | sed 1d | head -n 5

echo "\nTop 5 processes by memory usage:"
ps -eo pid,ppid,cmd,%mem,rss --sort=-%mem | head -n 5

echo "\nLogged-in users:"
who | awk '{print $1}' | sort | uniq
echo ""
echo "Last 5 failed login attempts:"
sudo tail -n 5 /var/log/auth.log
