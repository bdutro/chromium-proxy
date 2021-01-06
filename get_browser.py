#!/usr/bin/env python3

import asyncio
from pyppeteer import launch

async def get_browser_info():
    b = await launch()
    path = b.process.args[0]
    await b.close()
    return path

print(asyncio.run(get_browser_info()))
