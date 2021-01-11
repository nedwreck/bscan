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
	The ansible.cfg file is in ansible/ so ALL ansible scripts need to be run from ansible/
	The ansible.cfg file points to a hosts file in the same directory
	The hosts file should define the CDH as [CDH], the dns validator as [DNSVAL], the full
	collection of nodes as [NODES] and each individual node as [NODE0], [NODE1] etc
	Put all of the ip addresses into file ansible/node/nodeip.txt for ssh-copy-id 
05: Get the cdh initialized
	screen -S cdhinit ansible-playbook cdh/cdhinit.sh
	Configure VPC network firewall settings to allow port 445 for samba
06: Run the dns validator:
	This script is NOT idempotent and needs to have a fresh instance fired up for each
	attempt
	ansible/dnsvalidator/dnsvalidator.yml
07: Get the nodes initialized:
	Make sure ssh key has already been shared with CDH
	Script nodesinit.sh runs ansible/node/nodeinit.yml and then runs
	ansible/node/{0..15}/getscripts.yml. This has each node download it's own personalized
	script to run later to get it's share of domains to work with
		screen -dmS nodeinit ./nodesinit.sh
10: Process all freshly delivered domains:
		screen -dmS runfreshdomains ./runfreshdomains.sh
	This runs ansible/node/massdnsfirstrun.yml in an infinite loop with 10s sleep
11: Process found cnames:
		screen -dmS digcurldomains ./digcurldomains.sh
	This runs ansible/node/digcurldomains.yml in an infinite loop with 10s sleep
