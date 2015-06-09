#!/bin/bash

echo "BEGIN Set VM timezone and perform some cleanup pre-install ..."

# set server timezone
echo $1 | ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime

# a little housekeeping
echo "... Doing a little housekeeping ..."
yum update > /dev/null

echo "... END Set VM timezone and perform some cleanup pre-install."
echo " "