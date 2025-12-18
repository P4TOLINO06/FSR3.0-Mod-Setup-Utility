import tkinter as tk
from theme import *
from customtkinter import *
import re
from helpers import load_or_create_json

class FsrGuide:
    def __init__(self, screen, combobox_func=None):
        self.screen = screen
        self.font = get_font()

        self.screen_guide = None
        self.fsr_guide_label = None
        self.fsr_guide_var = tk.IntVar()
        self.combobox_func = combobox_func
        self.game_guides = []
        self.load_data()

    def load_data(self):
        data = load_or_create_json("guides.json", {
            "templates": {},
            "template_dlss_games": [],
            "template_dlssg_games": [],
            "template_dlss_dlssg_games": [],
            "custom_games": []
        })

        self.game_data = {}
        templates = data.get("templates", {})

        def add_games(game_list, dimension, template_keys):
            if not game_list:
                return
            for game in game_list:
                guide_text = ""
                if "dlss_dlssg" in template_keys:
                    guide_text = (
                        f"{templates.get('fsr_dlss_optiscaler_fg', '')}\n\n"
                        f"{templates.get('dlssg_optiscaler', '')}\n\n"
                        f"{templates.get('additional_info_fsr_dlss_fg', '')}"
                    )
                elif "dlssg" in template_keys:
                    guide_text = templates.get("dlssg_optiscaler", "")
                else:
                    guide_text = templates.get("fsr_dlss_optiscaler_fg", "")
                    guide_text += f"\n\n{templates.get('additional_info_fsr_dlss_fg', '')}"

                self.game_data[game] = {
                    "guide": guide_text.strip(),
                    "dimension": dimension,
            }

        add_games(data.get("template_dlss_games"), data.get("dimension_dlss_games"), "dlss")
        add_games(data.get("template_dlssg_games"), data.get("dimension_dlssg_games"), "dlssg")
        add_games(data.get("template_dlss_dlssg_games"), data.get("dimension_dlss_dlssg_games"), "dlss_dlssg")

        for custom in data.get("custom_games", []):
            name = custom["name"]
            self.game_data[name] = {
                "guide": custom.get("extra_guides", ""),
                "dimension": custom.get("dimension", "800x560"),
        }

        self.game_data = dict(sorted(
            self.game_data.items(),
            key=lambda x: (
                not x[0].lower().startswith("initial information"),
                x[0].lower()
            )
        ))

    def toggle_guide(self):
        if self.fsr_guide_var.get() == 1:
            self.open_guide()
        elif self.screen_guide:
            self.screen_guide.destroy()
            self.screen_guide = None
            self.guide_label = None

    def open_guide(self):
        if self.screen_guide:
            self.screen_guide.deiconify()
            return
        
        self.screen_guide = CTkToplevel(self.screen)
        self.screen_guide.iconbitmap("images/Hat.ico")
        self.screen_guide.title("FSR GUIDE")
        self.screen_guide.geometry("500x360")
        self.screen_guide.configure(bg="#222223")
        self.screen_guide.resizable(0, 0)
        self.screen_guide.protocol("WM_DELETE_WINDOW", self.exit_fsr_guide)
        self.screen_guide.configure(fg_color="#222223")

        def apply_icon():
            try:
                self.screen_guide.wm_iconbitmap("images/Hat.ico")
            except Exception as e:
                print("icon error:", e)

        self.screen_guide.after(350, apply_icon)

        self.create_guide_selector()

        self.guide_frame = CTkScrollableFrame(
            self.screen_guide,
            fg_color="#222223",
            bg_color="#222223",
            corner_radius=0,
        )
        self.guide_frame.place(x=170, y=0, relwidth=1, relheight=1)

    def create_guide_selector(self):
        self.game_guides = list(self.game_data.keys())

        if self.combobox_func is not None:
            self.guide_selected, self.combobox = self.combobox_func(
                self.screen_guide,
                self.game_guides,
                2, 0,
                165, 25,
                0,     
                21,
                persistent=True
            )
            self.guide_selected.trace_add("write", self.update_guide)


    def update_guide(self, *args):
        if not self.screen_guide or not self.guide_frame:
            return

        index = self.guide_selected.get()
        if not index:
            return

        info = self.game_data.get(index, {})
        dimension = info.get("dimension", "520x360")
        guide_text = info.get("guide", "No guide available.")

        self.screen_guide.geometry(dimension)

        for widget in self.guide_frame.winfo_children():
            widget.destroy()

        for line in guide_text.split("\n"):
            label = CTkLabel(
                self.guide_frame,
                text=line if line.strip() != "" else " ",
                font=("Segoe UI", 14, "bold" if self.is_title_line(line) else "normal"),
                text_color="white",
                anchor="w",
                justify="left",
            )
            label.pack(fill="x", pady=0, padx=0, ipady=0)
            label._label.configure(pady=0)


    def exit_fsr_guide(self):
        if self.screen_guide:
            self.screen_guide.destroy()
            self.screen_guide = None
            self.guide_label = None
            self.fsr_guide_var.set(0)
    

    def is_title_line(self, line):
        stripped = line.strip()

        if stripped == "":
            return False

        whitelist = ["Additional Info FSR4/DLSS FG", "Red Dead Redemption 2 MIX", "RDR2 FG Custom", "Ghost of Tsushima FG DLSS", "FSR4/DLSS (Only Optiscaler) + AMD Anti Lag 2", "Indy FG (Only RTX)", "Unlock FPS"]
        if any(word.lower() in stripped.lower() for word in whitelist):
            return True

        if re.match(r"^\d+\.", stripped):
            return False

        if stripped.startswith("-"):
            return False

        blacklist = ["Output", "Enabled", "Disabled", "Select", "Chose", "Choose", "Mode"]
        if any(word.lower() in stripped.lower() for word in blacklist):
            return False

        title_starts = ["FSR", "DLSS", "DLSSG", "RTX"]
        if not any(stripped.startswith(prefix) for prefix in title_starts):
            return False

        if len(stripped.split()) > 5:
            return False

        if "." in stripped:
            return False

        return True