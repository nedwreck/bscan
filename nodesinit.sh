#!/bin/sh

cd ~/bscan/ansible &&\
ansible-playbook node/nodeinit.yml

# Have each node copy it's particular script over for getting a newfreshdomains split
ansible-playbook node/0/getscripts.yml &&\
ansible-playbook node/1/getscripts.yml &&\
ansible-playbook node/2/getscripts.yml &&\
ansible-playbook node/3/getscripts.yml &&\
ansible-playbook node/4/getscripts.yml &&\
ansible-playbook node/5/getscripts.yml &&\
ansible-playbook node/6/getscripts.yml &&\
ansible-playbook node/7/getscripts.yml &&\
ansible-playbook node/8/getscripts.yml &&\
ansible-playbook node/9/getscripts.yml &&\
ansible-playbook node/10/getscripts.yml &&\
ansible-playbook node/11/getscripts.yml &&\
ansible-playbook node/12/getscripts.yml &&\
ansible-playbook node/13/getscripts.yml &&\
ansible-playbook node/14/getscripts.yml &&\
ansible-playbook node/15/getscripts.yml

