#!/bin/bash

awk '/^cpu / {usage=($2+$4)*100/($2+$4+$5)} END {printf "CPU Usage: %f%\n", usage}' /proc/stat

awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {
u=t-a;
printf "Used: %.2f%% (%d MB) | Free: %.2f%% (%d MB)\n",
u/t*100, u/1024, a/t*100, a/1024
}' /proc/meminfo

awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {
u=t-a;
printf "Used: %.2f%% (%d MB) | Free: %.2f%% (%d MB)\n",
u/t*100, u/1024, a/t*100, a/1024
}' /proc/meminfo

echo "\nTop 5 processes by CPU usage"
ps -eo pid,cmd,%cpu --sort=-%cpu | sed 1d | head -n 5

echo "\nTop 5 processes by Memory usage"
ps -eo pid,ppid,cmd,%mem,rss --sort=-%mem | head -n 5