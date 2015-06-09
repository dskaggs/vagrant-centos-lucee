#!/bin/bash

echo "================= START STEP-5-INSTALL-MYSQL.SH $(date +"%r") ================="
echo " "
echo "BEGIN Database server setup ..."

if [ ! -d "/var/lib/mysql" ]; then
	echo "... Installing MySQL Server ..."
		sudo yum install mysql-server -y > /dev/null

	# make mysql available to connect to from outside world without ssh tunnel
	# copy file with above changes and the lower_case_table_names = 1 flag set to
	# ignore case sensitivity in the database
	cp /vagrant/configs/mysql-my.cnf /etc/my.cnf

	service mysqld restart > /dev/null

	# set mysql to start at boot
	chkconfig mysqld on > /dev/null
fi

# create databases used for railo client and session storage
echo "... Creating databases for Railo's session and client storage ..."
echo "CREATE DATABASE IF NOT EXISTS railo_client;" | mysql -uroot
echo "CREATE DATABASE IF NOT EXISTS railo_session;" | mysql -uroot

# grant all privileges to mysql root user (from all hosts) on all databases
echo "... Giving root user acces to all databases  ..."
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$1' WITH GRANT OPTION;" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot

echo "... END Database server setup."
echo " "
echo "================= END STEP-5-INSTALL-MYSQL.SH $(date +"%r") ================="
