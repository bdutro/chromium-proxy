#!/bin/bash

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $SCRIPT_PATH/.env/bin/activate

source /etc/chromium-proxy.conf
export PYPPETEER_HOME

USER_DIR=$($SCRIPT_PATH/user_dir.py)

mkdir -p $USER_DIR
BROWSER=$($SCRIPT_DIR/get_browser.py)
$BROWSER --user-data-dir=$USER_DIR
