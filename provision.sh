#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
tar -xvf prometheus-*.tar.gz
sudo mv prometheus-*/prometheus /usr/local/bin/
sudo mv prometheus-*/promtool /usr/local/bin/
sudo mkdir -p /etc/prometheus
sudo cp -r prometheus-*/consoles /etc/prometheus
sudo cp -r prometheus-*/console_libraries /etc/prometheus
sudo cp prometheus.yml /etc/prometheus/

# Install Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.0/node_exporter-1.8.0.linux-amd64.tar.gz
tar -xvf node_exporter-*.tar.gz
sudo mv node_exporter-*/node_exporter /usr/local/bin/

# Install Grafana
sudo apt install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_10.2.0_amd64.deb
sudo dpkg -i grafana_10.2.0_amd64.deb

# Enable and Start services
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
nohup node_exporter &

# Setup alertmanager (Optional)
# Later step

echo "All tools installed! Visit http://localhost:3000 (Grafana) & http://localhost:9090 (Prometheus)"
