#!/usr/bin/env python3

import os
import sys
import shutil

from dataclasses import dataclass

@dataclass(kw_only=True, frozen=True)
class DesktopAppComponents:
    desktop_file: str
    app_directory: str


HOME_DIRECTORY = os.path.expanduser("~")
NATIVEFIER_APPS_DIRECTORY = f"{HOME_DIRECTORY}/.nativefier-apps"

get_desktopfile_fullpath = lambda appname: os.path.join(HOME_DIRECTORY, "local", "share", "applications", appname.lower())
get_appdir_fullpath = lambda appname: os.path.join(NATIVEFIER_APPS_DIRECTORY, f"{appname}-linux-x64")

def desktop_app_exists(app_name: str) -> bool:
    return os.path.exists( get_desktopfile_fullpath(app_name) ) or os.path.exists( get_appdir_fullpath(app_name) )


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("[ERROR] Invalid arguments", file=sys.stderr)
        sys.exit(1)

    APP_NAME = sys.argv[1]

    if not desktop_app_exists(APP_NAME):
        print("[ERROR] Desktop App does not exist", file=sys.stderr)
        sys.exit(1)

    # TODO: insert logic here
    print(f"{APP_NAME} exists congrats bro this app exists but no one cares")
