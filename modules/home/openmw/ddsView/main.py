#!/usr/bin/env python

import os
import click
from PIL import Image
import subprocess
import sys

@click.command()
@click.option('-k', '--keep', is_flag=True, default=False, help="If temporary .png files should be kept in your /tmp/ directory")
@click.option('--no-open', is_flag=True, default=False, help="Just convert the file to .png without opening it")
@click.argument('filename', type=click.Path(exists=True, readable=True, dir_okay=False))
def main(keep, no_open, filename):
    """Tool for opening unsupported image files on your default image viewing application"""
    with Image.open(filename) as img:
        base = os.path.splitext(os.path.basename(filename))[0]
        temp = f"/tmp/{base}.png"

        try:
            with open(temp, 'wb') as out:
                img.save(out, format="PNG")

            if no_open: return

            process = subprocess.Popen(["mimeopen", temp])
            process.wait()
        finally:
            if not keep and os.path.exists(temp):
                os.remove(temp)

if __name__ == "__main__":
    main()
