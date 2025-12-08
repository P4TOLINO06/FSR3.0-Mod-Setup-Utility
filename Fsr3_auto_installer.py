from customtkinter import *
from guide import *
from upscaler_updater import *
from gui import *
from admin import run_as_admin 
from ctypes import windll
windll.shcore.SetProcessDpiAwareness(1)  # Per-monitor DPI aware

if __name__ == "__main__":
    run_as_admin()
    Gui().run()