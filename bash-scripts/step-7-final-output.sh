#!/bin/bash

echo "================= START STEP-7-FINAL-OUTPUT.SH $(date +"%r") ================="
echo " "
echo "Doing some last minute cleanup ..."

# some final housekeeping
yum update > /dev/null

rm /root/*.run > /dev/null
rm /root/lucee-options.txt > /dev/null
rm /root/jcameron-key.asc > /dev/null

# disable iptables
/etc/init.d/iptables save
/etc/init.d/iptables stop
chkconfig iptables off


echo " "
echo "================= END STEP-7-FINAL-OUTPUT.SH $(date +"%r") ================="
echo " "
echo " "
echo "$1"
echo " "
echo "========================================================================"
echo " "
echo "http://$2 ($3)"
echo " "
echo "Lucee Server/Web Context Administrators"
echo " "
echo "http://$2:8888/lucee/admin/server.cfm"
echo "http://$2:8888/lucee/admin/web.cfm"
echo " "
echo "Password (for each admin): password"
echo " "
echo " "
echo "Webmin"
echo " "
echo "https://$2:10000"
echo "User: root"
echo "Password: vagrant"
echo " "
echo " "
echo "Database Server Connection Info for External Connections "
echo "from Host Machine"
echo " "
echo "Server: $4"
echo "Port: 3306"
echo "User: root"
echo "Password: password"
echo " "
echo "========================================================================"
