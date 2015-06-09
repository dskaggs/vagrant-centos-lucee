#!/bin/bash

if [ -f /vagrant/data/$1 ]; then
	IFS='.' read -ra myarray <<< "$1"

	echo "... Restoring database from file: $1 ..."
	# create database
	echo "CREATE DATABASE IF NOT EXISTS ${myarray[0]};" | mysql -uroot
	# import sql file
	echo "SOURCE /vagrant/data/$1;" | mysql -uroot -f -D ${myarray[0]}
fi