#!/bin/bash

# Exit immediately if a command fails
set -e

echo "Updating package index..."
sudo apt update -y

echo "Installing required packages..."
sudo apt install -y software-properties-common

echo "Adding Ansible repository..."
sudo add-apt-repository --yes --update ppa:ansible/ansible

echo "Installing Ansible..."
sudo apt install -y ansible

echo "Verifying Ansible installation..."
ansible --version

echo "Ansible installation completed successfully."
