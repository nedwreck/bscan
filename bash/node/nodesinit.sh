#!/bin/sh

cd ~/bscan/ansible/node &&\

# Have each node update and mount the nodeshare and install necessary tools
ansible-playbook nodeinit.yml &&\

# Have each node copy it's particular script over for getting a newfreshdomains split
ansible-playbook 0/getscripts.yml &&\
ansible-playbook 1/getscripts.yml &&\
ansible-playbook 2/getscripts.yml &&\
ansible-playbook 3/getscripts.yml &&\
ansible-playbook 4/getscripts.yml
