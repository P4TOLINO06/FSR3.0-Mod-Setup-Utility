import os
from cx_Freeze import setup, Executable

includefiles = [
    ("Fonts", "Fonts"), 
    ("Fonts/notably_absent", "Fonts/notably_absent"), 
    ("images", "images"), 
    ("mods", "mods"), 
]

setup(
    name="FSR3.0 Mod Setup Utility",
    version="0.9.1",
    description="Application to assist in the installation of FSR mods",
    executables=[Executable("Fsr3_auto_installer.py", base="Win32GUI",target_name='Fsr3_auto_installer.exe')], 
    options={
        'build_exe': {
            'include_files': includefiles,
            'includes': ["tkinter", "PIL", "customtkinter", "pyglet", "configobj", "win32com", "psutil"]
        }
    }
)
