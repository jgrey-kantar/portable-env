#!/bin/bash

# Parse the JSON formatted configuration file
apt_deps=$(jq -r '.apt_dependencies[]' dependencies.json)
npm_deps=$(jq -r '.npm_dependencies[]' dependencies.json)
dpkg_deps=$(jq -r '.dpkg_dependencies[]' dependencies.json)

# Install apt dependencies
if [ -n "$apt_deps" ]; then
  apt-get update
  apt-get install -y $apt_deps
fi

# Install npm dependencies
if [ -n "$npm_deps" ]; then
  npm install -g $npm_deps
fi

# Install dpkg dependencies
# if [ -n "$dpkg_deps" ]; then
#   dpkg --install $dpkg_deps
# fi

# Download and Install Java 11
curl -LO https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.deb
dpkg --install amazon-corretto-11-x64-linux-jdk.deb