#!/bin/bash

echo "Input log directory: "
read logdir

timestamp=$(date +%s)
mkdir -p ./log-archives

tar -czvf ./log-archives/log_archive_$timestamp.tar.gz $logdir