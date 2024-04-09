#!/bin/bash

# Function to update Ubuntu
update_ubuntu() {
  echo "Updating Ubuntu..."
  sudo apt update -y && sudo apt upgrade -y
}

# Function to update Amazon Linux
update_amazon_linux() {
  echo "Updating Amazon Linux..."
  sudo yum update -y
}

# Check for apt (Ubuntu)
if command -v apt &> /dev/null
then
    update_ubuntu
# Check for yum (Amazon Linux)
elif command -v yum &> /dev/null
then
    update_amazon_linux
else
    echo "Unsupported Linux distribution."
fi

# #Steps to run this script
# To use this script:
# Save the script to a file, for example, update_system.sh.
# Give it executable permissions with the command chmod +x update_system.sh.
# Run the script with ./update_system.sh.
# This script assumes you have sudo privileges on the system you're running it on, as updating software packages typically requires such privileges.

