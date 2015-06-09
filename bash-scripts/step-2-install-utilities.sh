#!/bin/bash

echo "================= START STEP-2-INSTALL-UTILITIES.SH $(date +"%r") ================="
echo " "
echo "BEGIN installing utilities"

# install some common utilities
if [ ! -f /var/log/utils_installed ]; then
	echo "... Installing miscellaneous/common utilities ..."

	yum install perl -y > /dev/null
	yum install wget -y > /dev/null
	yum install nano -y > /dev/null
	yum install curl -y > /dev/null
	yum install zip -y > /dev/null
	yum install unzip -y > /dev/null
	yum install net-tools -y > /dev/null

	echo "... Installing WebMin ..."
	wget -O /root/jcameron-key.asc http://www.webmin.com/jcameron-key.asc > /dev/null
	rpm --import /root/jcameron-key.asc
	cp /vagrant/configs/webmin.repo /etc/yum.repos.d/
	yum install webmin -y > /dev/null

	touch /var/log/utils_installed
fi

echo "... END installing utilities."
echo " "
echo "================= FINISH STEP-2-INSTALL-UTILITIES.SH $(date +"%r") ================="
echo " "
