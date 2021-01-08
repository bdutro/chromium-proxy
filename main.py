import asyncio
from asyncio_helpers import asyncio_run
from flask import Flask, request
from multiprocessing import Process, Manager
import os
from pyppeteer import launch
import sys
from user_dir import USER_DATA_DIR
import urllib.parse

app = Flask(__name__)

async def get_async(d):
    url = d['url']
    browser = await launch(userDataDir=USER_DATA_DIR, args=['--no-sandbox'])

    try:
        page = await browser.newPage()
        decoded_url = urllib.parse.unquote(url)
        await page.goto(decoded_url)
        #await page.waitForNavigation({"waitUtil": 'networkidle0', "timeout": 0})
        #await asyncio.sleep(5)
        html = await page.evaluate("() => document.querySelector('*').outerHTML")
        await browser.close()
        d['html'] = html
    except:
        await browser.close()
        raise

def get_process(url):
    return asyncio_run(get_async(url))

@app.route('/proxy', methods=['GET'])
def get():
    with Manager() as manager:
        d = manager.dict()
        d['url'] = request.args.get('url')
        try:
            p = Process(target=get_process, args=(d,))
            p.start()
            p.join()
        except:
            raise
        return d['html']


if __name__ == "__main__":
    app.run(host='127.0.0.1')
