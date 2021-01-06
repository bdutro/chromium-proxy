#!/usr/bin/env python3

import os
import pyppeteer

USER_DATA_DIR = os.path.join(pyppeteer.__pyppeteer_home__, 'chrome_user_dir')

if __name__ == '__main__':
    print(USER_DATA_DIR)
