#!/bin/bash
apt update
apt upgrade -y
apt install -y ansible
ansible --version
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.kubernetes
