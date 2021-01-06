#!/usr/bin/env python3

from pyppeteer.util import check_chromium, download_chromium, chromium_executable

if not check_chromium():
    download_chromium()

print(chromium_executable())
