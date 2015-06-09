# Vagrant Lucee Development VM (CentOS / Apache / MySQL / Tomcat / Lucee)
Vagrant box for local development with CFML and Java

##### Last Updated June 9, 2015
---

### Prerequisites
NOTE: All version numbers used in this document are confirmed to work, and are current, as of the time of this writing

#### Required
It is assumed you have Virtual Box and Vagrant installed. If not, then grab the latest version of each at the links below:
* [Virtual Box and Virtual Box Guest Additions](https://www.virtualbox.org/wiki/Downloads) (4.3.26)
* [Vagrant](https://www.vagrantup.com/downloads.html) (v1.7.2)

#### Highly Recommended
Once Vagrant is installed, or if it already is, it's highly recommended that you install the following Vagrant plugins:
* [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) (v0.0.11).
```$ vagrant plugin install vagrant-hostsupdater```
* [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) (v0.10.0).
```$ vagrant plugin install vagrant-vbguest```

---

### What's Included
* CentOS 6.6 64bit
	* Make sure curl, wget, unzip, zip, iptables, net-tools are installed
	* Set vm timezone (configure in Vagrantfile)
* Apache 2.4
	* Set up to serve all static content and reverse-proxy cfm/cfc/jsp requests to Lucee
* MySQL 5.1.73
	* lower_case_table_names = 1 (disables case sensitivity)
	* bind-address set to 0.0.0.0 so database server can be accessed from the host machine directly (without ssh tunnel)
	* any SQL files found in the vagrantroot/data directory will be restored to a database with the same name as the SQL file
* Lucee 4.5.1.000

---

### Installation
The first time you clone the repo and bring the box up, it may take several minutes. If it doesn't explicitly fail/quit, then it is still working.
```
$ git clone git@github.com:dskaggs/vagrant-centos-lucee.git
$ cd vagrant-centos-lucee && vagrant up
```

Once the Vagrant box finishes and is ready, you should see something like this in your terminal:
```
==> default: Lucee-Dev-v0.1.0
==> default:
==> default: ========================================================================
==> default:
==> default: http://www.lucee.dev (192.168.50.25)
==> default:
==> default: Lucee Server/Web Context Administrators
==> default:
==> default: http://www.lucee.dev/lucee/admin/server.cfm
==> default: http://www.lucee.dev/lucee/admin/web.cfm
==> default:
==> default: Password (for each admin): password
==> default:
==> default:
==> default: Webmin
==> default: " "
==> default: http://www.lucee.dev:10000
==> default: User: root
==> default: Password: vagrant
==> default: " "
==> default: " "
==> default: Database Server Connection Info for External Connections
==> default: from Host Machine
==> default:
==> default: Server: db.lucee.dev
==> default: Port: 3306
==> default: User: root
==> default: Password: password
==> default:
==> default: ========================================================================
```
Once you see that, you should be able to browse to [http://www.lucee.dev/](http://www.lucee.dev/)
or [http://192.168.50.25/](http://192.168.50.25/)
(it may take a few minutes the first time a page loads after bringing your box up, subsequent requests should be much faster).

**NOTE**
* On Windows (host machines) you should run your terminal as an Administrator; you will also need to make sure your Hosts file isn't set to read-only if you want to take advantage of the hostname functionality. Alternatively, simply use the IP address anywhere you would use the hostname (connecting to database server, etc).
* The VM is configured to share a "Sites" folder from your computer into the webroot of the VM at /var/www/sites. This is where you should check out each repository
	* Windows: C:\Users\<username>\Sites
	* Mac: /Users/<username>/Sites
	* Linux: /home/<username>/Sites

---

#### References
Thanks to Mike Sprague for his work on the Ubuntu version which this project used as a starting point [vagrant-lemtl](https://github.com/mikesprague/vagrant-lemtl)

---

## License
The MIT License (MIT)

Copyright (c) 2015 Dan Skaggs

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
