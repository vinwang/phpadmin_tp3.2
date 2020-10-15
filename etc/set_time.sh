#!/bin/sh
time=$(cat /lysrv/cu/web/etc/time.txt)
sudo date -s "$time"
sudo hwclock -w
