#!/bin/bash

cd /tmp
sudo mkdir folder1
sudo mkdir folder2
sudo mkdir script
cd script
sudo touch script.sh
sudo chmod +x /tmp/script/script.sh
echo $'while true \ndo \nif [ -n "$(ls -A /tmp/folder1)" ]; then \nmv /tmp/folder1/*.* /tmp/folder2/ \nfi \ndone' >> /tmp/script/script.sh
cd /lib/systemd/system
sudo touch movefiles.service
echo $'[Unit] \nDescription=Files Mover Service \nAfter=network.target \n\n[Service] \nUser=root \nExecStart=/bin/bash /tmp/script/script.sh \nRestartSec=5s \nRestart=on-failure \n\n[Install] \nWantedBy=multi-user.target' >> /lib/systemd/system/movefiles.service
sudo systemctl daemon-reload
sudo systemctl start movefiles.service
sudo systemctl enable movefiles.service