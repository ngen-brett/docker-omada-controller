#!/bin/bash

export DEBIAN_FRONTEND=non-interactive
apt-get -y update
apt-get -y install wget curl zip

mkdir -p /app/download
pushd /app/download/
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
wget https://static.tp-link.com/upload/software/2024/202401/20240112/Omada_SDN_Controller_v5.13.23_linux_x64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-server_4.4.27_amd64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-mongos_4.4.27_amd64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-shell_4.4.27_amd64.deb
dpkg -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb
apt-get -y install libcurl4 libgssapi-krb5-2 libldap-2.5-0 libwrap0 libsasl2-2 libsasl2-modules libsasl2-modules-gssapi-mit openssl liblzma5 tzdata jsvc openjdk-8-jre-headless
dpkg -i mongodb-org-server_4.4.27_amd64.deb
dpkg -i mongodb-org-mongos_4.4.27_amd64.deb
dpkg -i mongodb-org-shell_4.4.27_amd64.deb
