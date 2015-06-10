#!/bin/bash

echo "================= START STEP-3-INSTALL-APACHE.SH $(date +"%r") ================="
echo " "
echo "BEGIN installing and configuring apache ..."

#install apache
if [ ! -d "/etc/httpd" ]; then
	yum install httpd -y > /dev/null
	yum install mod_perl -y > /dev/null
fi

echo "... Configuring apache ..."
# copy our modified apache config files
cp /vagrant/configs/httpd.conf /etc/httpd/conf

# restart apache
service httpd restart > /dev/null

# set apache to start at boot
chkconfig httpd on > /dev/null

echo "... End installing and configuring apache."
echo " "
echo "================= FINISH STEP-3-INSTALL-APACHE.SH $(date +"%r") ================="
echo " "
