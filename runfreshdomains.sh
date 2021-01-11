#!/bin/sh

cd ~/bscan/ansible &&\
while :; do
ansible-playbook node/massdnsfirstrun.yml && sleep 10;
done

