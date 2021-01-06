#!/usr/bin/env python3

from asyncio_helpers import asyncio_run
from pyppeteer import launch

async def get_browser_info():
    b = await launch()
    path = b.process.args[0]
    await b.close()
    return path

print(asyncio_run(get_browser_info()))
