#!/usr/bin/env bash

# exit on error
set -e

# install python3-pip
if ! command -v python3-pip > /dev/null 2>&1
then
  sudo apt-get install python3-pip -y
fi


# install ansible
pip3 install ansible

# set path
export PATH="$PATH:~/.local/bin"

# run the playbook
ansible-playbook --ask-become-pass -i hosts bootstrap.yml
