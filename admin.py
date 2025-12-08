import ctypes
import sys
import os

def uac():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except Exception:
        return False

unlock_screen = True

def run_as_admin():
    global unlock_screen
    if uac():
        unlock_screen = True
    else:
        unlock_screen = False
        try:
            ctypes.windll.shell32.ShellExecuteW(
                None,
                "runas",
                sys.executable,
                f'"{os.path.abspath(__file__)}"',
                None,
                1
            )
            sys.exit(0)
        except Exception as e:
            sys.exit(1)

run_as_admin()