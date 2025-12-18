from gui import *
from admin import run_as_admin 
windll.shcore.SetProcessDpiAwareness(1)  # Per-monitor DPI aware

if __name__ == "__main__":
    run_as_admin()
    Gui().run()