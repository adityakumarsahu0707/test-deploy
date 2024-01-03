#!/bin/bash

#NOTE: Make sure the user used for this setup is privileged enough for executing below setup 

#Downloading and extracting Prometheus application for Linux Distrubution
wget https://github.com/prometheus/prometheus/releases/download/v2.49.0-rc.1/prometheus-2.49.0-rc.1.linux-amd64.tar.gz
tar -xzf prometheus-2.49.0-rc.1.linux-amd64.tar.gz
cd prometheus-2.49.0-rc.1.linux-amd64

#Creating user for prometheus 
sudo useradd --no-create-home --shell /bin/false prometheus

#Setting up Prometheus requirements
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
sudo cp ./prometheus /usr/local/bin/
sudo cp ./promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo cp -r ./consoles /etc/prometheus
sudo cp -r ./console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo cp prometheus.yml /etc/prometheus/
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

#Creating Prometheus Daemon
sudo cat << EOF > /etc/systemd/system/prometheus.service
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

#Starting Prometheus service
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus

##### Firewall setting
# firewall-cmd --add-port=9090/tcp --permanent 
# firewall-cmd --reload
