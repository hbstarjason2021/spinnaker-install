#! /bin/bash

sudo apt-get update -y

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
newgrp docker


################################################################
<< CONTENT
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://jngj6il2.mirror.aliyuncs.com"]
}
EOF
CONTENT

## curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
## systemctl enable docker
## systemctl start docker
