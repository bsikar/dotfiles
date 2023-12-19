#!/usr/bin/env bash

# exit on error
set -e

# install python3-pip
if command -v apt-get &> /dev/null || command -v apt &> /dev/null; then
  sudo apt-get install python3-pip -y
  pip3 install ansible
elif command -v pacman &> /dev/null; then
  yes | sudo pacman -S python-pip python-ansible
fi

# set path
export PATH="$PATH:~/.local/bin"

ansible-galaxy collection install community.general

# run the playbook
ansible-playbook --ask-become-pass -i hosts bootstrap.yml
