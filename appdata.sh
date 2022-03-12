#!/bin/bash

yum update -y
yum install -y epel-release python3 python3-pip git


cat << EOF > /etc/systemd/system/app.service
[Unit]
Description=App service
After=multi-user.target
[Service]
Type=simple
Restart=always
ExecStart=/usr/bin/python3 /opt/app/helloworld-python-app/hello.py
[Install]
WantedBy=multi-user.target
EOF

mkdir -p /opt/app && cd /opt/app
git clone https://github.com/azimazad/helloworld-python-app.git
cd helloworld-python-app
pip3 install -r requirements.txt

systemctl daemon-reload
systemctl enable app
systemctl start app