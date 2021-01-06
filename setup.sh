#!/bin/bash

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PYTHON3="/usr/bin/env python3"
PROXY_USER=cproxy
$PYTHON3 -m venv .env && source .env/bin/activate && $PYTHON3 -m pip install -r requirements.txt

sudo cp $SCRIPT_PATH/chromium-proxy.conf.example /etc/chromium-proxy.conf

source /etc/chromium-proxy.conf
export PYPPETEER_HOME

USER_DIR=$($SCRIPT_PATH/user_dir.py)
sudo mkdir -p $USER_DIR

if ! id $PROXY_USER &>/dev/null; then
    sudo useradd -M -U -s /usr/sbin/nologin $PROXY_USER
fi

sudo chown -R $PROXY_USER:$PROXY_USER $USER_DIR/..
sudo cp $SCRIPT_PATH/chromium-proxy.service /etc/systemd/system/chromium-proxy.service
sudo sed -i "s|%INSTALL_PATH%|${SCRIPT_PATH%/}|g" /etc/systemd/system/chromium-proxy.service
