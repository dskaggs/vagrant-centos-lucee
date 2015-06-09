#!/bin/bash

echo "================= START STEP-4-INSTALL-LUCEE.SH $(date +"%r") ================="
echo " "
echo "BEGIN setting up Lucee"

# install lucee
echo "... Copying the Lucee installer into the VM ..."
cp /vagrant/bin/lucee-4.5.1.000-pl0-linux-x64-installer.run /root
cp /vagrant/configs/lucee-options.txt /root
chmod +x /root/lucee-4.5.1.000-pl0-linux-x64-installer.run

echo "... Installing Lucee ..."
/root/lucee-4.5.1.000-pl0-linux-x64-installer.run --mode unattended --optionfile /root/lucee-options.txt

echo "... Copying the Lucee config files into place ..."
#sudo cp /vagrant/configs/setenv.sh /opt/lucee/tomcat/bin
cp /vagrant/configs/lucee-server.xml /opt/lucee/lib/lucee-server/context

echo "... Restarting Lucee ..."
service lucee_ctl restart > /dev/null

echo "... END setting up Lucee."
echo " "
echo "================= FINISH STEP-4-INSTALL-LUCEE.SH $(date +"%r") ================="
echo " "
