#!/bin/bash

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $SCRIPT_PATH/.env/bin/activate

source /etc/chromium-proxy.conf
export PYPPETEER_HOME

USER_DIR=$($SCRIPT_PATH/user_dir.py)

mkdir -p $USER_DIR
BROWSER=$(sudo -E -u cproxy bash -c "source $SCRIPT_PATH/.env/bin/activate; $SCRIPT_PATH/get_browser.py")
sudo -u cproxy $BROWSER --user-data-dir=$USER_DIR
