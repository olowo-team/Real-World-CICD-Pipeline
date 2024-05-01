#!/bin/bash

# Ensure script is executed with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Add Grafana APT repository
echo "Adding Grafana APT repository..."
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list
curl https://packages.grafana.com/gpg.key | apt-key add -

# Update package index
echo "Updating package index..."
apt update

# Install Grafana
echo "Installing Grafana..."
apt install grafana

# Start Grafana service
echo "Starting Grafana service..."
systemctl start grafana-server

# Enable Grafana service to start on boot
echo "Enabling Grafana service to start on boot..."
systemctl enable grafana-server

# Display Grafana service status
echo "Grafana service status:"
systemctl status grafana-server

# Provide URL to access Grafana
echo "You can access Grafana by navigating to http://localhost:3000 in your web browser"
