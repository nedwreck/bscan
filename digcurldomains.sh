#!/bin/sh

cd ~/bscan/ansible &&\
while :; do
ansible-playbook node/digcurldomains.yml && sleep 10;
done
