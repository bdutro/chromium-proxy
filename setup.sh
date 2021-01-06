#!/bin/bash

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
virtualenv .env && source .env/bin/activate && pip install -r requirements.txt

sudo cp $SCRIPT_PATH/chromium-proxy.conf.example /etc/chromium-proxy.conf

source /etc/chromium-proxy.conf
export PYPPETEER_HOME

USER_DIR=$($SCRIPT_PATH/user_dir.py)
sudo mkdir -p $USER_DIR
