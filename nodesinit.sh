#!/bin/sh

cd ~/bscan/ansible &&\
ansible-playbook node/nodeinit.yml

# Have each node copy it's particular script over for getting a newfreshdomains split
ansible-playbook node/0/getscripts.yml &&\
#ansible-playbook node/1/getscripts.yml &&\
#ansible-playbook node/2/getscripts.yml &&\
#ansible-playbook node/3/getscripts.yml &&\
#ansible-playbook node/4/getscripts.yml
