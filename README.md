01: Fire up a Central Data Handler (CDH).  Should be something like 2 cores with 4 gig of ram.
	sudo apt install -y python ansible git-all screen
02: Mount the hard drive to be used on the CDH for data storage as the user home directory.
	sudo mount /dev/sdb1 /home/USER 
    Populate it with the bscan folder if it needs it
	git clone https://github.com/nedwreck/bscan
03: Edit stuff:
	Edit the CDH IP in the following files: BSCANSHARE
		ansible/node/nodeinit.yml
		ansible/dnsvalidator/dnsvalidator.yml
	Edit username in the following files: USER
		ansible/cdh/cdhinit.yml	
		ansible/node/nodeinit.yml
		ansible/dnsvalidator/dnsvalidator.yml
	Edit smb password in the following files: SMBPASS
		ansible/cdh/cdhinit.yml
		ansible/node/nodeinit.yml
		ansible/dnsvalidator/dnsvalidator.yml
	Edit local smb mount location in the following files: BSCANMOUNT 
		ansible/cdh/cdhinit.yml
		ansible/node/nodeinit.yml
		ansible/dnsvalidator/dnsvalidator.yml
04: Edit Ansible stuff:
	The ansible.cfg file is in ansible/ so all ansible scripts need to be run from ansible/
	The ansible.cfg file points to a hosts file in the same directory
	The hosts file should define the CDH as [CDH], the dns validator as [DNSVAL], the full
	collection of nodes as [NODES] and each individual node as [NODE0], [NODE1] etc
