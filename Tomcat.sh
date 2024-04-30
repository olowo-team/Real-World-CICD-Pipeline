#!/bin/bash
set -x

# hostnamectl set-hostname prometheus

# Prometheus is an open-source monitoring and alerting toolkit designed for reliability and scalability. Here are the general steps to install Prometheus on a Linux/Ubuntu system:
	
# Download Prometheus
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz

# Extract Files
sudo tar vxf prometheus*.tar.gz

# Create a System User for Prometheus
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus

# Create Directories for Prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# Navigate to the Prometheus Directory
cd prometheus*/

# Move Files
#Move the Binary Files
sudo mv prometheus /usr/local/bin
sudo mv promtool /usr/local/bin

#Move other Files
sudo mv console* /etc/prometheus
sudo mv prometheus.yml /etc/prometheus

# Set Owner
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus


# Adjust the target to your node exporter endpoint
# Add more scrape configurations as needed for other exporters or targets

# Create Prometheus Systemd Service
#sudo nano /etc/systemd/system/prometheus.service
# Include these settings to the file, save, and exit:

cat << EOF >> /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Reload Systemd
sudo systemctl daemon-reload

# Enable Prometheus
sudo systemctl enable prometheus

# Start Prometheus
sudo systemctl start prometheus

# Check Prometheus Status
sudo systemctl status prometheus

# Following a successful setup, you can access the Prometheus web interface by navigating to localhost:9090 in your web browser. Upon reaching this address, you will be presented with the Prometheus graphical user interface, confirming that the installation and configuration have been completed successfully.#!/bin/bash
set -x

# hostnamectl set-hostname prometheus

# Prometheus is an open-source monitoring and alerting toolkit designed for reliability and scalability. Here are the general steps to install Prometheus on a Linux/Ubuntu system:
	
# Download Prometheus
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz

# Extract Files
sudo tar vxf prometheus*.tar.gz

# Create a System User for Prometheus
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus

# Create Directories for Prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# Navigate to the Prometheus Directory
cd prometheus*/

# Move Files
#Move the Binary Files
sudo mv prometheus /usr/local/bin
sudo mv promtool /usr/local/bin

#Move other Files
sudo mv console* /etc/prometheus
sudo mv prometheus.yml /etc/prometheus

# Set Owner
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus


# Adjust the target to your node exporter endpoint
# Add more scrape configurations as needed for other exporters or targets

# Create Prometheus Systemd Service
#sudo nano /etc/systemd/system/prometheus.service
# Include these settings to the file, save, and exit:

cat << EOF >> /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Reload Systemd
sudo systemctl daemon-reload

# Enable Prometheus
sudo systemctl enable prometheus

# Start Prometheus
sudo systemctl start prometheus

# Check Prometheus Status
sudo systemctl status prometheus

# Following a successful setup, you can access the Prometheus web interface by navigating to localhost:9090 in your web browser. Upon reaching this address, you will be presented with the Prometheus graphical user interface, confirming that the installation and configuration have been completed successfully.
