#!/bin/sh
sudo yum update -y

# 安装docker
sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker

# 不用sudo可以访问docker
sudo usermod -a -G docker ${USER}
sudo chmod a+rw /var/run/docker.sock

# 安装docker-compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 安装git
sudo yum install git -y
