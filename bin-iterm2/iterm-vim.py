#! /Users/apollotang/_x_conf/custom-scripts/bin-iterm2/.venv/bin/python3.13

import iterm2
import AppKit
import sys
import shlex
import os

# Launch the app
AppKit.NSWorkspace.sharedWorkspace().launchApplication_("iTerm2")

async def main(connection):
    app = await iterm2.async_get_app(connection)

    # Foreground the app
    await app.async_activate()

    # Get command-line arguments excluding the script name itself
    files_to_open = ' '.join(shlex.quote(file) for file in sys.argv[1:])
    
    # Get the current working directory
    cwd = os.getcwd()
    
    # This will run 'vim' with the provided files from bash, setting the correct working directory.
    await iterm2.Window.async_create(connection, command=f"/bin/bash -l -c 'cd {shlex.quote(cwd)} && vim {files_to_open}'")

# Passing True for the second parameter means keep trying to
# connect until the app launches.
iterm2.run_until_complete(main, True)



