# -*- mode: ruby -*-
# vi: set ft=ruby :

# server configuration
vm_ip_address = "192.168.50.25"
vm_naked_hostname = "lucee.dev"
vm_www_hostname = "www.#{vm_naked_hostname}"
vm_sql_hostname = "db.#{vm_naked_hostname}"
vm_timezone  = "US/Eastern"
vm_current_version = "v0.2.0"
vm_name = "Lucee-Dev-#{vm_current_version}"
vm_max_memory = 4096
vm_num_cpus = 2
vm_max_host_cpu_cap = "30"

# database configuration
db_server_type = "mysql"
db_mariadb_version = "5.1.73"
db_root_password = "password"

# synced folder configuration
synced_webroot_local = "www"
synced_webroot_box = "/var/www/sites/"
synced_webroot_id = "vagrant-webroot"
synced_webroot_owner = "vagrant"
synced_webroot_group = "vagrant"


Vagrant.configure("2") do |config|
	config.vm.box = "cyvaquero/centos-6.6_base"
	config.vm.boot_timeout = 180

	config.vm.provider "virtualbox" do |v|
		# set name of vm
		v.name = vm_name
		# no matter how much cpu is used in vm, use no more than vm_max_host_cpu_cap amount
		v.customize ["modifyvm", :id, "--cpuexecutioncap", vm_max_host_cpu_cap]
		# set max amount of host machine ram allotted for vm to use
		v.customize ["modifyvm", :id, "--memory", vm_max_memory]
		# set number of cpus from host machine that vm is allowed to use
		v.customize ["modifyvm", :id, "--cpus", vm_num_cpus]
		# the next two settings enable using the host computer's dns inside the vagrant box
		# enable dns proxy in nat mode
		v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		# use the host's resolver as a dns proxy in nat mode
		v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	end

	# set vm ip address and add auto_correct on forwarded port so it doesn't collide with other vagrant boxes
	config.vm.network :private_network, ip: vm_ip_address
	# config.vm.network :forwarded_port, guest: 22, host: 2223, auto_correct: true

	if Vagrant.has_plugin?("vagrant-hostsupdater")
		# set vm hostname
		config.vm.hostname = vm_naked_hostname
		config.hostsupdater.aliases = [
			vm_www_hostname, vm_sql_hostname
		]
	end

	# set vm timezone and do some cleanup before installations
	config.vm.provision :shell, :path => "bash-scripts/step-1-set-vm-timezone.sh", :privileged => true, :args => vm_timezone

	# install miscellaneous utilities
	config.vm.provision :shell, :path => "bash-scripts/step-2-install-utilities.sh", :privileged => true

	# install/configure apache
	config.vm.provision :shell, :path => "bash-scripts/step-3-install-apache.sh", :privileged => true

	# install/configure lucee
	config.vm.provision :shell, :path => "bash-scripts/step-4-install-lucee.sh", :privileged => true, :args => [
		vm_name, vm_www_hostname, vm_ip_address, vm_sql_hostname
	]

	# install/configure database server
	config.vm.provision :shell, :path => "bash-scripts/step-5-install-#{db_server_type}.sh"

	# restore any databases that have SQL files present in the /data directory
	Dir.chdir('./data')
	Dir.glob('*.sql') do |sql_file|
	  config.vm.provision :shell, :path => "bash-scripts/step-6-restore-database.sh", :privileged => true, :args => [
	  	sql_file
	  ]
	end
	Dir.chdir('../')

	# confirm setup is complete and output connection info
	config.vm.provision :shell, :path => "bash-scripts/step-7-final-output.sh", :privileged => true, :args => [
		vm_name, vm_www_hostname, vm_ip_address, vm_sql_hostname
	]

	# add synced folder
	config.vm.synced_folder synced_webroot_local, synced_webroot_box, :id => synced_webroot_id, :owner => synced_webroot_owner, :group => synced_webroot_group

	# after everything has mounted, start apache
	# this is needed b/c Apache tries to start before sync'd folders are mounted
	config.vm.provision :shell, :inline => "sudo service httpd start", run: "always"
end
