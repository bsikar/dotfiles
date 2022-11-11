#!/usr/bin/env bash

# exit on error
set -e

# install ansible
pip3 install ansible

# set path
export PATH="$PATH:~/.local/bin"

# run the playbook
ansible-playbook --ask-become-pass -i hosts bootstrap.yml

