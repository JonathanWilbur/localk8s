#!/bin/bash
apt update
apt upgrade -y
apt install -y ansible python3-pip
ansible --version
ansible-galaxy collection install community.general ansible.posix community.kubernetes
pip3 install --upgrade requests