#!/bin/bash

# this script is a userdata for preparing my working environment in the ubuntu instance

# Update and Upgrade the library
apt-get update -y
apt-get upgrade -y

# install necessary packages
apt-get install -y unzip wget apt-transport-https ca-certificates curl software-properties-common gnupg2 git

# install terraform
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
unzip terraform_0.12.24_linux_amd64.zip
mv terraform /usr/local/bin/

# install ansible
apt-add-repository --yes --update ppa:ansible/ansible
apt-get update -y
apt-get install -y ansible

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce
usermod -aG docker ${USER}
systemctl enable docker
systemctl start docker

# install kubectl
snap install kubectl --classic

# install helm
wget https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
tar -zxvf helm-v3.2.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

# install azurecli
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list
apt-get update
apt-get install azure-cli

# install google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -f
