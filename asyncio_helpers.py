import asyncio
import sys

if sys.version_info < (3, 7):
    def asyncio_run(p):
        loop = asyncio.get_event_loop()
        return loop.run_until_complete(p)
else:
    def asyncio_run(p):
        return asyncio.run(p)
