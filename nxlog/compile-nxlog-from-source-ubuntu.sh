#!/bin/bash
# Tim H 2022
# compile nxlog from source on Ubuntu 20.04
# designed for container but also VM
# this compiles the binary and the binary works, but 
# it doesn't install the service or setup the user.

cd "$HOME" || exit 1
SRC_FULLPATH="$HOME/nxlog-ce-src.tar.gz"

# install dependencies
# not all of these are present in the Ubuntu docker container:
sudo apt-get install -y vim tree sudo git wget curl file libapr1-dev \
    libaprutil1-dev libpcre3-dev coreutils systemctl \
    libssl-dev libcap2 libcap-dev librust-winapi-dev libdbi-dev zlib1g-dev \
    gawk dpkg-awk bison++ bisonc++ byacc flex python3-dev \
    libssl3 perl libperl5.34 libperl-dev

# download the source code tarball
wget --output-document="$SRC_FULLPATH" "https://nxlog.co/system/files/products/files/348/nxlog-ce-3.0.2272.tar.gz"
# extract it
tar -xzf "$SRC_FULLPATH"

cd "$HOME/nxlog-ce-3.0.14/" || exit 2
# compile and make it, then install it
./configure # this takes 1-2 minutes
make    # this takes 5+ minutes
sudo make install

# see version:
cd "$HOME" && nxlog --help

mkdir -p /usr/local/etc/nxlog /var/log/nxlog/

# add logging to config file
echo "
LogFile /var/log/nxlog/nxlog.log
LogLevel INFO
" | sudo tee -a /usr/local/etc/nxlog/nxlog.conf

cat /usr/local/etc/nxlog/nxlog.conf

# test config file syntax:
nxlog -v

# doesn't install it as a service
