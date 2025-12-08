import tkinter as tk
import tkinter.font as tkFont

def get_font():
    try:
        return ("Segoe UI", 13, 'bold')
    except tk.TclError:
        return tkFont.Font(family="Arial", size=10)

def get_secondary_font():
    try:
        return ("Segoe UI", 9)
    except tk.TclError:
        return tkFont.Font(family="Arial", size=9)

COLORS = {
   "bg": "#1e1e2f",   
    "fg": "#f0f0f0",   
    "accent": "#4da6ff",  
    "input_bg": "#2e2e3e",
    "text": "#C0C0C0",
}
