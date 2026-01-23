from single_instance import single_instance
from gui import *
from ctypes import windll

windll.shcore.SetProcessDpiAwareness(1)  # Per-monitor DPI aware

if __name__ == "__main__":
    single_instance()
    Gui().run()