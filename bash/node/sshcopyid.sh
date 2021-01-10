#!/bin/sh

cd ~/bscan/ansible/node &&\
for ip in $(cat nodeip.txt); do
ssh-copy-id -f -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub iwillnotmakeaname@$ip
done
