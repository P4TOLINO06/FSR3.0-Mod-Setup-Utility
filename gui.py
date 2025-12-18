import tkinter as tk
import asyncio
import inspect
from customtkinter import *
from tkinter import filedialog,messagebox
import os
import sys
from tkinter import font as tkFont
import threading
import json
import requests
import webbrowser
import subprocess

from theme import *
from cleanup import *
from games_mods_config import game_mods_config, game_config, addons_presets
from installer import ModInstaller
from helpers import runReg, bind_tooltip
from guide import FsrGuide
from upscaler_updater import games_to_update_upscalers
from helpers import load_or_create_json
from ctypes import windll
windll.shcore.SetProcessDpiAwareness(1)  # Per-monitor DPI aware

UPDATE_STATE_FILE = os.path.join(os.getenv('LOCALAPPDATA'), "FSR-Mod-Utility", "update_state.json")
GITHUB_API_URL = "https://api.github.com/repos/P4TOLINO06/FSR3.0-Mod-Setup-Utility/releases/latest"
CURRENT_VERSION = "4.1v" 

class Gui:
    def __init__(self):
        self.root = CTk()
        icon = tk.PhotoImage(file="images/Hat.gif")   
        self.root.wm_iconphoto(True, icon) 
        self.root.title("FSR3.0 Mod Setup Utility - 4.1v")
        self.root.configure(bg='')  
        self.font = get_font()
        self.root.geometry("450x360")
        self.root.resizable(0,0)
        self.root.configure(bg="#222223")

        self.update_available = False
        self.update_version = None
        self.update_state = self.load_update_state()
        self.check_for_update()
        self.game_selected = None
        self.dest_folder = None
        self.addons_dest_folder = None
        self.mod_options = ['FSR4/DLSS FG (Only Optiscaler)','FSR4/DLSSG FG (Only Optiscaler)']
        self.mod_selected = None
        self.addons_listbox_visible = False
        self.selected_addon = None
        self.game_options_listbox_visible = False
        self.disable_sigover_var = IntVar(value=0)
        self.enable_sigover_var = IntVar(value=0)
        self.enable_dlss_overlay_var = IntVar(value=0)
        self._active_dropdown = None
        self._active_menu_btn = None
        self.gpu_name = get_active_gpu()
        self.total_steps_progress = 0
        self.completed_steps_progress = 0
        self.progress_finished = False

        self.build_ui()
    
    def build_ui(self):
        self.game_selection()
        self.folder_selection()
        self.mod_selection()
        self.addons_selection()
        self.enable_signature_override()
        self.disable_signature_override()
        self.enable_dlss_overlay()
        self.guide()
        self.toopTip()
        self.install_gui()
        self.exit()
        self.cleanup_mod()
        self.root.iconbitmap("images\\Hat.ico")
    
    def run(self):
        self.root.mainloop()

    def load_update_state(self):
        os.makedirs(os.path.dirname(UPDATE_STATE_FILE), exist_ok=True)
        return load_or_create_json("update_state.json", {"hidden": False})

    def save_update_state(self):
        try:
            # Remove all atributtes
            subprocess.call(["attrib", "-h", "-r", UPDATE_STATE_FILE],
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

            with open(UPDATE_STATE_FILE, "w", encoding="utf-8") as f:
                json.dump(self.update_state, f, indent=4)

            # Hidden + ReadOnly
            subprocess.call(["attrib", "+h", "+r", UPDATE_STATE_FILE],
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

        except Exception as e:
            print("Error saving update_state:", e)

    def check_for_update(self):
        def fetch_latest():
            try:
                response = requests.get(GITHUB_API_URL, timeout=5)
                if response.status_code == 200:
                    data = response.json()
                    tag = data.get("tag_name") or data.get("name") or ""
                    if tag and tag.replace("v", "") > CURRENT_VERSION.replace("v", ""):
                        self.update_available = True
                        self.update_version = tag
                        self.root.after(0, self.show_update_button)
            except Exception as e:
                print("Error checking for update:", e)

        threading.Thread(target=fetch_latest, daemon=True).start()

    def show_update_button(self):
        if self.update_state.get("hidden"):
            self.show_discreet_update_icon()
            return

        if not self.update_available:
            return

        # Update btn
        self.update_btn = CTkButton(
            self.root,
            text="Update",
            width=70,
            height=25,
            corner_radius=8,
            fg_color="#ff9933",
            hover_color="#ffb366",
            text_color="white",
            command=self.open_latest_release
        )
        self.update_btn.place(x=170, y=227)

        bind_tooltip(self.update_btn, f"Update available ({self.update_version})", 0)

        # Close btn
        self.close_update_btn = CTkButton(
            self.root,
            text="X",
            width=25,
            height=25,
            corner_radius=8,
            fg_color="#555a64",
            hover_color="#777",
            text_color="white",
            command=self.hide_update_button
        )
        self.close_update_btn.place(x=245, y=227)

        bind_tooltip(self.close_update_btn, "Close", 0)

    def hide_update_button(self):
        if hasattr(self, "update_btn"):
            self.update_btn.destroy()
        if hasattr(self, "close_update_btn"):
            self.close_update_btn.destroy()

        self.update_state["hidden"] = True
        self.save_update_state()
        self.show_discreet_update_icon()

    def show_discreet_update_icon(self):
        if hasattr(self, "update_icon_btn"):
            return 

        self.update_icon_btn = CTkButton(
            self.root,
            text="⬇",
            width=25,
            height=25,
            corner_radius=50,
            fg_color="#3a3f4b",
            hover_color="#5b6373",
            text_color="white",
            command=self.open_latest_release
        )
        self.update_icon_btn.place(x=415, y=330)
        bind_tooltip(self.update_icon_btn, f"Update available ({self.update_version})", 0)

    def open_latest_release(self):
        webbrowser.open("https://github.com/P4TOLINO06/FSR3.0-Mod-Setup-Utility/releases/latest")

    def main_screen(self):
        # ICON
        icon_image = tk.PhotoImage(file="images\\Hat.gif")
        self.root.iconphoto(True, icon_image)
        
        # FONT
        self.change_text = False
        
        try:
            self.font_selected = (self.font, 11, 'bold')
            
            self.var_font = tk.Label(self.root,text=".", font=self.font,fg=COLORS['fg'], bg=COLORS['bg'])
            
        except tk.TclError:
            self.font_selected = tkFont.Font(family="Arial",size=10)
            self.change_text = True
                
        second_tittle = tk.Label(self.root, text="FSR4/DLSS FG Mods", font=("Arial", 11, "bold"), fg="#778899", bg=COLORS['bg']) 
        second_tittle.pack(anchor='w',pady=0)
    
    # GAME SELECTION
    def game_selection(self):
        self.game_selected_label = CTkLabel(
            self.root, text="Game Select -",
            font=(self.font[0], 17, 'bold'),
            text_color=COLORS["text"]
        )   
        self.game_selected_label.place(x=0,y=1) 

        self.game_selected, self.game_options_menu = self._Combobox(self.root,game_config,115,4)

        self.game_selected.trace_add("write", self.on_game_selected)

    def on_game_selected(self, *_):
        game = self.game_selected.get()
        if game:
            self.update_mod_list(game, game_mods_config)
        
        if hasattr(self, "sub_addons"):
            self.update_addons_for_game()
        
        print(game)

    # FOLDER SELECTION
    def folder_selection(self):  
        self.selected_folder = None
        
        self.game_folder_label = CTkLabel(
            self.root, text="Game folder -",
            font=(self.font[0], 17, 'bold'),
            text_color=COLORS["text"]
        )
        self.game_folder_label.place(x=0,y=35)

        self.text_selected_game_folder,self.selected_game_folder_canvas = self._CanvasLabel(self.root, self.dest_folder, 115,38, text_color="white")

        self.btn_selected_folder = self._Button(
            self.root,
            "Browser",
            359, 39,
            lambda: self.open_explorer("dest_folder", self.text_selected_game_folder, self.selected_game_folder_canvas),
            fg_color="#555a64",
            hover_color="#6b7180"
        )
          
    # OPEN EXPLORER
    def open_explorer(self, attr_name, text_var=None, widget=None, limited_text=29):
        folder = filedialog.askdirectory()

        setattr(self, attr_name, folder if folder else "")

        if folder:
            if text_var:
                
                text_var.set(folder if len (folder) <= limited_text else folder[:limited_text] + "…")

            if widget:
                bind_tooltip(widget, folder, 0)
        else:
            if text_var:
                text_var.set("")
            if widget:
                bind_tooltip(widget, "", 0)
    
    # MOD SELECTION
    def mod_selection(self):
        self.mod_version_label = CTkLabel(
            self.root, text="Mod version -",
            font=(self.font[0], 17, 'bold'),
            text_color=COLORS["text"]
        )
        self.mod_version_label.place(x=0,y=69)
              
        self.mod_selected, self.mod_version_menu = self._Combobox(self.root, self.mod_options, 115, 72, max_visible_items=4)

    def update_mod_list(self, game_selected, game_mods_config):
        
        if game_selected in game_mods_config:
            self.mod_options = game_mods_config[game_selected]
        else:
            self.mod_options = ['FSR4/DLSS FG (Only Optiscaler)','FSR4/DLSSG FG (Only Optiscaler)']

        self.mod_selected, self.mod_version_menu = self._Combobox(self.root, self.mod_options, 115, 72, max_visible_items=4)

        print(self.mod_selected.get())
    
    def on_mod_selected(self, event=None):
        self.mod_selected = self.mod_version_menu.get()
        self.mod_version_menu.place_forget()
    
    # ADDONS
    def addons_selection(self):
        # Addons Cbox
        self.addons_var = IntVar()
        self.addons_cbox = CTkCheckBox(
            self.root, text="Addons",
            font=self.font,
            fg_color=COLORS["accent"],
            hover_color="#66b2ff",
            text_color=COLORS["text"],
            variable=self.addons_var,
            corner_radius=7,
            checkbox_width=20,
            checkbox_height=20,
            command=self.on_addons_toggle
        )
        self.addons_cbox.place(x=3, y=108)

        # Addons Btn
        self.addons_selected = tk.StringVar(value="")

        self.addons_canvas_btn = CTkButton(
            self.root,
            textvariable=self.addons_selected,
            width=238,
            height=25,
            corner_radius=6,
            fg_color="#2e3a5a",
            hover_color="#6a5aff",
            text_color="white",
            font=self.font,
            command=self.toggle_addons_menu 
        )
        self.addons_canvas_btn.place(x=115, y=108)

        # Browser
        self.addons_selected_btn = self._Button(
            self.root,
            "Browser",
            359, 109,
            command=lambda: self.open_explorer("addons_dest_folder", None, self.addons_selected_btn, 0),
            fg_color="#555a64",
            hover_color="#6b7180"
        )

        addons_opt = ["FSR4", "FSR3", "DLSS", "DLSSG", "DLSSD", "XESS"]
        self.sub_addons = {n: IntVar() for n in addons_opt}          

        self._addons_dropdown = None

    def on_addons_toggle(self):
        if not self.addons_var.get():
            if self._addons_dropdown and self._addons_dropdown.winfo_exists():
                self._addons_dropdown.destroy()
            self._addons_dropdown = None
            self.addons_selected.set("")
            [v.set(0) for v in self.sub_addons.values()]
            bind_tooltip(self.addons_canvas_btn, "")
        else:
            self.update_addons_for_game()

    def toggle_addons_menu(self):
        if not self.addons_var.get():
            return

        if self._addons_dropdown and self._addons_dropdown.winfo_exists():
            self._addons_dropdown.destroy()
            self._addons_dropdown = None
            self.root.unbind_all("<MouseWheel>")
            return

        dropdown = tk.Toplevel(self.root)
        dropdown.wm_overrideredirect(True)
        dropdown.configure(bg="#353535")
        dropdown.pack_propagate(False)

        self._addons_dropdown = dropdown

        x = self.addons_canvas_btn.winfo_rootx()
        y = self.addons_canvas_btn.winfo_rooty() + self.addons_canvas_btn.winfo_height()

        # DPI/Height
        dpi_scale = self.root.winfo_fpixels('1i') / 96
        item_height = int(30 * dpi_scale)

        visible_count = len(self.sub_addons)

        # Submenu limit
        min_items = 2
        max_items = 3

        dropdown_items = max(min_items, min(visible_count, max_items))
        height = dropdown_items * item_height

        # Width
        self.addons_canvas_btn.update_idletasks()
        button_width = self.addons_canvas_btn.winfo_width()

        scroll_width = 25
        canvas_width = button_width - scroll_width

        width_total = button_width

        self.root.bind(
            "<Configure>",
            lambda e, w=dropdown, b=self.addons_canvas_btn, wt=width_total, ht=height:
                self.follow_root(w, b, wt, ht),
            add="+"
        )

        dropdown.geometry(f"{width_total}x{height}+{x}+{y}")

        # Canvas 
        canvas = tk.Canvas(dropdown, bg="#353535", highlightthickness=0, bd=0,
                        width=canvas_width, height=height)
        canvas.pack(side="left", fill="y")

        # Scrollbar
        scroll = tk.Scrollbar(dropdown, command=canvas.yview)
        scroll.pack(side="right", fill="y")
        canvas.configure(yscrollcommand=scroll.set)

        # Frame Cboxes
        inner = tk.Frame(canvas, bg="#353535")
        canvas.create_window((0, 0), window=inner, anchor="nw", width=canvas_width)

        canvas.bind("<Enter>", lambda e, c=canvas:
            self.root.bind_all("<MouseWheel>", lambda ev: self.on_mouse_wheel(ev, c)))
        canvas.bind("<Leave>", lambda e: self.root.unbind_all("<MouseWheel>"))

        # Upscalers cbox
        for name, var in self.sub_addons.items():
            CTkCheckBox(inner, text=name, variable=var, font=self.font,
                        text_color="white", fg_color="#555a64", hover_color="#6b7180",
                        corner_radius=5, checkbox_width=18, checkbox_height=18,
                        command=self.update_addons_button_text).pack(anchor="w", padx=10, pady=3)
        
        inner.configure(bg="#353535")
        inner.update_idletasks()
        canvas.configure(scrollregion=canvas.bbox("all"))

        self.root.bind("<Button-1>", lambda e: (
            dropdown.destroy(),
            setattr(self, "_addons_dropdown", None),
            self.root.unbind_all("<MouseWheel>"),
            self.root.unbind("<Button-1>")
        ) if dropdown and not dropdown.winfo_containing(e.x_root, e.y_root) else None, add="+")
    
    def update_addons_button_text(self):
        selected = [name for name, var in self.sub_addons.items() if var.get()]
        text = ", ".join(selected) if selected else ""

        self.addons_selected.set(text[:33]) 

        bind_tooltip(self.addons_canvas_btn, text)
    
    def update_addons_for_game(self):
        # Marks the upscaler preset according to the selected game
        game = self.game_selected.get() if self.game_selected else None
        if not game:
            return

        for v in self.sub_addons.values():
            v.set(0)

        for combo, games in addons_presets.items():
            if game in games:
                for name in combo.split("_"):
                    if name in self.sub_addons:
                        self.sub_addons[name].set(1)

        if self.addons_var.get() == 1:
            self.update_addons_button_text()

    def get_selected_upscalers(self):
        return {k: v.get() for k, v in self.sub_addons.items()}

    # ENABLE SIGNATURE OVERRIDE
    def enable_signature_override(self):    
       self._Checkbox(
            "Enable Signature", 3, 147, "enable_sigover_var",
            command=lambda: runReg("mods\\Temp\\enable signature override\\EnableSignatureOverride.reg")
            if self.enable_sigover_var.get() == 1 else None
        )
    
    # DISABLE SIGNATURE OVERRIDE
    def disable_signature_override(self):
        self._Checkbox(
            "Disable Signature", 163, 147, "disable_sigover_var",
            command=lambda: runReg("mods\\Temp\\disable signature override\\DisableSignatureOverride.reg")
            if self.disable_sigover_var.get() == 1 else None
        )
    
    # DLSS Overlay (Only RTX)
    def enable_dlss_overlay(self):
        visible = 'rtx' in self.gpu_name
        self.dlss_overlay_cbox = self._Checkbox(
            "DLSS Overlay", 323, 147, "enable_dlss_overlay_var",
            command=lambda: runReg(
                "mods\\Addons_mods\\DLSS Preset Overlay\\Enable Overlay.reg"
                if self.enable_dlss_overlay_var.get() == 1 else
                "mods\\Addons_mods\\DLSS Preset Overlay\\Disable Overlay.reg"
            ),
            visible=visible
        )
       
    def guide(self):
        self.fsr_guide = FsrGuide(self.root, self._Combobox)
        
        self.guide_cbox = self._Checkbox(
            "GUIDE", 163, 186, "fsr_guide_var", command=self.fsr_guide.toggle_guide, variable=self.fsr_guide.fsr_guide_var
        )
        
    # Cleanup Mods
    def cleanup_mod(self):
        self.cleanup_var = IntVar()
        self.cleanup_cbox = self._Checkbox(
            "Cleanup Mod", 3, 186, "cleanup_var", command=self.cbox_cleanup
        )  
         
    def cbox_cleanup(self):
        if self.cleanup_var.get() == 1:
            try:
                if self.dest_folder is None:
                    messagebox.showinfo('Select Folder','Please select the destination folder')
                    self.cleanup_cbox.deselect()
                    return

                if not messagebox.askyesno('Uninstall','Would you like to proceed with the uninstallation of the mod?'):
                    self.cleanup_cbox.deselect()
                    return

                total = count_cleanup_items(self.dest_folder, self.game_selected.get() if self.game_selected else None, self.mod_selected.get() if self.mod_selected else None)
                self.cleanup_total_steps = total
                self.cleanup_completed_steps = 0
                self.cleanup_finished = False
                self.cleanup_progress.set(0)

                if total == 0:
                    messagebox.showinfo('Info','No files were found for removal.')
                    self.cleanup_cbox.after(400, self.cleanup_cbox.deselect)
                    return

                threading.Thread(target=self._run_cleanup_thread, daemon=True).start()

            except Exception as e:
                print(e)
    
    def toopTip(self):        
        # Game selection tooltip
        bind_tooltip(self.game_selected_label, "Select a game to install the mod.", 0)
        
        # Game folder tooltip
        bind_tooltip(self.game_folder_label, "Select the game folder where you want to install the mod.", 0)
        
        # Mod version tooltip
        bind_tooltip(self.mod_version_label, "Select the version of the mod you want to install\n(it is recommended to check the FSR Guide before installing any mod).", 0)
        
        # Guide tooltip
        bind_tooltip(self.guide_cbox, "It includes installation guides for most games\n(it is highly recommended to check the guides before performing any installation).", 0)

        # DLSS Overlay tooltip
        bind_tooltip(self.dlss_overlay_cbox, "Displays the version and preset of DLSS being used,\nas well as the version of DLSSG currently active\n(Check or uncheck the box to enable/disable)", 0)

    # INSTALL   
    def install_gui(self, event=None):
        self.install_button = CTkButton(
            self.root, text="Install", 
            fg_color=COLORS["accent"], 
            text_color="white", 
            corner_radius=8,
            hover_color="#66b2ff",
            width=70,
            height=25,
            command=self.start_install_thread
        )
        self.install_button.place(x=90, y=227)

        # Installation progress
        self.progress = CTkProgressBar(
            self.root, 
            width=153, 
            height=15, 
            corner_radius=8
        )
        self.progress.set(0)

        # Cleanup progress
        self.cleanup_progress = CTkProgressBar(
            self.root,
            width=153,
            height=15,
            corner_radius=8
        )
        self.cleanup_progress.set(0)

        self.cleanup_total_steps = 0
        self.cleanup_completed_steps = 0
        self.cleanup_finished = False
     
    def install(self, event=None):
        self.progress_finished = False

        fields = {
            "Game": self.game_selected.get() if self.game_selected else "",
            "Destination Folder": self.dest_folder.strip() if self.dest_folder else "",
            "Mod": self.mod_selected.get() if self.mod_selected else ""
        }

        self.total_steps_progress = 0
        self.completed_steps_progress = 0
        self.progress.set(0)

        # Total Files
        selected_upscalers = self.get_selected_upscalers()

        self.total_steps_progress = self.files_to_install_progress(self.dest_folder, selected_upscalers)
        print(f"Total mods files to install: {self.total_steps_progress}")
        
        try:
            installer = ModInstaller(
            dest_path=self.dest_folder,
            game_selected=self.game_selected.get() if self.game_selected else None,
            mod_selected=self.mod_selected.get() if self.mod_selected else None,
            progress_callback=self.update_progress
            )

            if self.missing_fields(fields, True):
                handler = installer.game_handlers.get(self.game_selected.get())
                mod_handler = installer.mods_handlers.get(self.mod_selected.get())

                def install_mod():
                    if handler:
                        self.run_handler(handler)
                    if mod_handler:
                        self.run_handler(mod_handler)

                mod_thread = threading.Thread(target=install_mod)
                mod_thread.start()
                mod_thread.join()

                if self.addons_var.get():
                    def install_addons():
                        try:
                            dest_path = self.addons_dest_folder or self.dest_folder
                            games_to_update_upscalers(
                                dest_path,
                                self.game_selected.get(),
                                copy_dlss=bool(selected_upscalers["DLSS"]),
                                copy_dlss_dlssg=bool(selected_upscalers["DLSSG"]),
                                copy_dlss_dlssd=bool(selected_upscalers["DLSSD"]),
                                copy_dlss_xess=bool(selected_upscalers["XESS"]),
                                copy_dlss_fsr3=bool(selected_upscalers["FSR3"]),
                                copy_dlss_fsr4=bool(selected_upscalers["FSR4"]),
                                progress_callback=self.update_progress,
                                absolute_path = True if dest_path == self.addons_dest_folder else False
                            )

                            print(dest_path)
                        except Exception as e:
                            print(e)
                        finally:
                            self.root.after(200, self.finish_progress)

                    addons_thread = threading.Thread(target=install_addons)
                    addons_thread.start()
                    addons_thread.join()
                else:
                    self.root.after(200, self.finish_progress)

        except Exception as e:
            messagebox.showwarning('Error', f'Installation error {self.addons_selected.get()}')
            print(f"Error: {e}")

    def files_to_install_progress(self, dest_path, selected_upscalers):
        total = 0

        # Mods
        mod_dirs = []
        if dest_path and os.path.exists(dest_path):
            mod_dirs.append(dest_path)

        # Addons
        upscaler_paths = {
            "DLSS": r'mods\Temp\Upscalers\Nvidia\Dlss',
            "DLSSG": r'mods\Temp\Upscalers\Nvidia\Dlssg',
            "DLSSD": r'mods\Temp\Upscalers\Nvidia\Dlssd',
            "XESS": r'mods\Temp\Upscalers\Intel',
            "FSR3": r'mods\Temp\Upscalers\AMD\FSR3',
            "FSR4": r'mods\Temp\Upscalers\AMD\FSR4'
        }


        # Only marked addons
        if selected_upscalers.get("DLSS"):
            mod_dirs.append(upscaler_paths["DLSS"])

        if selected_upscalers.get("DLSSG"):
            mod_dirs.append(upscaler_paths["DLSSG"])

        if selected_upscalers.get("DLSSD"):
            mod_dirs.append(upscaler_paths["DLSSD"])

        if selected_upscalers.get("XESS"):
            mod_dirs.append(upscaler_paths["XESS"])

        if selected_upscalers.get("FSR3"):
            mod_dirs.append(upscaler_paths["FSR3"])

        if selected_upscalers.get("FSR4"):
            mod_dirs.append(upscaler_paths["FSR4"])

        # Total Files
        for path in mod_dirs:
            if os.path.isfile(path):
                total += 1
            elif os.path.isdir(path):
                for _, _, files in os.walk(path):
                    total += len(files)

        return total

    def start_install_thread(self):
        threading.Thread(target=self.install, daemon=True).start()
    
    def finish_progress(self):
        if self.progress_finished:
            return 
        self.progress_finished = True

        self.progress.place_forget()
        self.sucess = CTkLabel(
            self.root, text="Successful installation!",
            font=(self.font[0], 15, 'bold'),
            fg_color="#222223",
            text_color="#A8B0C0"
        )
        self.sucess.place(x=5, y=260)
        self.root.after(3000, self.sucess.destroy)
    
    def update_progress(self):
        if self.progress_finished or not self.total_steps_progress:
            return

        def safe_update():
            if self.progress_finished:
                return

            self.completed_steps_progress += 1
            value = min(self.completed_steps_progress / self.total_steps_progress, 1.0)
            self.progress.set(value)

            if not self.progress.winfo_ismapped():
                self.progress.place(x=5, y=265)

        self.root.after(0, safe_update)
    
    def _run_cleanup_thread(self):
        try:
            if not self.cleanup_progress.winfo_ismapped():
                self.cleanup_progress.place(x=0, y=300)

            setup_cleanup(
                self.dest_folder,
                self.game_selected.get() if self.game_selected else None,
                self.mod_selected.get() if self.mod_selected else None,
                progress_callback=self.update_cleanup_progress
            )

            self.root.after(200, self._finish_cleanup)

        except Exception as e:
            print("Cleanup error:", e)
            self.root.after(200, lambda: messagebox.showwarning('Error', f'Cleanup error, please try again'))
            self.root.after(400, self.cleanup_cbox.deselect)

    def update_cleanup_progress(self):
        def safe_update():
            if self.cleanup_finished or not self.cleanup_total_steps:
                return
            self.cleanup_completed_steps += 1
            value = min(self.cleanup_completed_steps / self.cleanup_total_steps, 1.0)
            self.cleanup_progress.set(value)
        self.root.after(0, safe_update)

    def _finish_cleanup(self):
        if self.cleanup_finished:
            return
        self.cleanup_finished = True
        self.cleanup_progress.place_forget()
        self.cleanup_success = CTkLabel(
            self.root, text="Successful cleanup!",
            font=(self.font[0], 15, 'bold'),
            fg_color="#222223",
            text_color="#A8B0C0"
        )
        self.cleanup_success.place(x=5, y=300)
        self.root.after(3000, self.cleanup_success.destroy)
        self.cleanup_cbox.after(400, self.cleanup_cbox.deselect)

    # EXIT
    def exit(self):
        self._Button(self.root, "Exit", 3, 227, sys.exit, width=70, height=25, fg_color=COLORS["accent"], hover_color="#66b2ff")

    def run_handler(self,handler):
        if inspect.iscoroutinefunction(handler):
            asyncio.run(handler())
        else:
            handler()
    
    def missing_fields(self, fields: dict, message = False):

        missing = [name for name, value in fields.items() if not value]

        if missing:
            if message:
                messagebox.showinfo(
                    "Missing Information",
                    "Please fill out the following field(s): " + ", ".join(missing)
                )
            return False
        
        return True

    def on_mouse_wheel(self, event, canvas):
        if canvas.winfo_exists():
            canvas.yview_scroll(int(-1 * (event.delta / 120)), "units")

    def _Combobox(
        self, root, options, place_x, place_y,
        width=238, height=25, width_menu=0, limit_chars=32, max_visible_items=5,
        fg_color="#2e3a5a", hover_color="#6a5aff", cbox_var=None, persistent=False):

        selected = tk.StringVar(value="")

        menu_btn = CTkButton(
            root, text="",
            width=width, height=height,
            corner_radius=6, font=self.font,
            fg_color=fg_color, hover_color=hover_color, text_color="white"
        )
        menu_btn._persistent = persistent
        menu_btn.place(x=place_x, y=place_y)

        def close_active_dropdown(ignore_persistent: bool = False):
            ad = getattr(self, "_active_dropdown", None)
            amb = getattr(self, "_active_menu_btn", None)

            if amb and getattr(amb, "_persistent", False) and not ignore_persistent:
                return

            closed_something = False
            if ad and ad.winfo_exists():
                try:
                    ad.destroy()
                    closed_something = True
                except Exception:
                    pass

            if closed_something:
                self.root.unbind_all("<MouseWheel>")

            if closed_something or ignore_persistent:
                self._active_dropdown = None
                self._active_menu_btn = None

        def toggle_menu():
            if hasattr(menu_btn, "_dropdown") and menu_btn._dropdown and menu_btn._dropdown.winfo_exists():
                try: menu_btn._dropdown.destroy()
                except: pass
                menu_btn._dropdown = None
                root.unbind_all("<MouseWheel>")
                return

            if (getattr(self, "_active_menu_btn", None) is menu_btn and
                getattr(self, "_active_dropdown", None) and self._active_dropdown.winfo_exists()):
                close_active_dropdown()
                return

            close_active_dropdown()

            if cbox_var is not None and not bool(cbox_var.get()):
                return

            x = menu_btn.winfo_rootx()
            y = menu_btn.winfo_rooty() + menu_btn.winfo_height()

            menu_btn.update_idletasks()
            button_width = menu_btn.winfo_width()

            menu_width = max(button_width, width_menu) if width_menu > 0 else button_width 

            item_height = int(30 * self.root.winfo_fpixels('1i') / 96)  

            visible_count = min(len(options), max_visible_items)

            min_items = 2
            max_items = 6

            dropdown_height = max(
                min_items * item_height,
                min(visible_count, max_items) * item_height + 10
            )
            
            dropdown = tk.Toplevel(root)
            dropdown.wm_overrideredirect(True)

            self._active_dropdown = dropdown
            self._active_menu_btn = menu_btn
            menu_btn._dropdown = dropdown

            dropdown.geometry(f"{menu_width}x{dropdown_height}+{x}+{y}")

            root.bind(
                "<Configure>",
                lambda e, w=dropdown, b=menu_btn: self.follow_root(w, b, menu_width, dropdown_height),
                add="+"
            )

            frame = tk.Frame(dropdown, bg="#353535")
            frame.pack(fill="both", expand=True)

            needs_scroll = len(options) > max_visible_items
            scrollbar_width = 15 if needs_scroll else 0
            canvas_width = menu_width - scrollbar_width

            canvas = tk.Canvas(
                frame,
                bg="#353535",
                highlightthickness=0,
                bd=0,
                width=canvas_width,
                height=dropdown_height,
            )
            scrollbar = None

            if needs_scroll:
                scrollbar = tk.Scrollbar(
                    frame, orient="vertical",
                    command=canvas.yview, bd=0, highlightthickness=0
                )
                canvas.configure(yscrollcommand=scrollbar.set)
                scrollbar.pack(side="right", fill="y")

            canvas.pack(side="left", fill="both", expand=True)

            inner = tk.Frame(canvas, bg="#353535")
            inner_id = canvas.create_window((0, 0), window=inner, anchor="nw", width=canvas_width)

            canvas.bind("<Enter>", lambda e: self.root.bind_all("<MouseWheel>", lambda ev: self.on_mouse_wheel(ev, canvas)))
            canvas.bind("<Leave>", lambda e: self.root.unbind_all("<MouseWheel>"))

            for opt in options:
                lbl = tk.Label(
                    inner,
                    text=opt,
                    anchor="w",
                    bg="#353535",
                    fg="white",
                    padx=15,
                    pady=7,
                    cursor="hand2",
                    wraplength=menu_width - 30,
                    font=(self.font[0], 10)
                )
                lbl.pack(fill="x")

                lbl.bind("<Enter>", lambda e, w=lbl: w.configure(bg="#444444"))
                lbl.bind("<Leave>", lambda e, w=lbl: w.configure(bg="#353535"))

                def on_label_click(v=opt):
                    selected.set(v)
                    menu_btn.configure(text=(v if len(v) <= limit_chars else v[:limit_chars] + "…"))
                    bind_tooltip(menu_btn, "", 0)
                    bind_tooltip(menu_btn, v, limit_chars)

                    if not persistent:
                        close_active_dropdown()

                lbl.bind("<Button-1>", lambda e, v=opt: on_label_click(v))

            inner.update_idletasks()
            canvas.configure(scrollregion=canvas.bbox("all"))
            canvas.itemconfig(inner_id, width=canvas_width)

            if not persistent:
                dropdown.bind("<FocusOut>", lambda e: close_active_dropdown())

        menu_btn.configure(command=toggle_menu)
        return selected, menu_btn


    def _CanvasLabel(self, root, text, place_x, place_y, width=238, height=25,fg_color="#2e3a5a", text_color="white", corner_radius=6):

        selected = StringVar(value=text)

        label_btn = CTkButton(
            root,
            textvariable=selected,   
            width=width,
            height=height,
            corner_radius=corner_radius,
            fg_color=fg_color,
            text_color=text_color,
            font=self.font,
            hover=False,            
            command=None             
        )

        label_btn.place(x=place_x, y=place_y)

        return selected, label_btn
    
    def _Button(self, root, text, place_x, place_y, command, width=50, height=19, fg_color="#2e3a5a", hover_color="#6a5aff", text_color="white", corner_radius=6, font=None):

        btn = CTkButton(
        root,
        text=text,
        command=command,
        width=width,
        height=height,
        corner_radius=corner_radius,
        fg_color=fg_color,
        hover_color=hover_color,
        text_color=text_color,
        font=font if font else self.font
        )

        btn.place(x=place_x, y=place_y)
        return btn

    def _Checkbox(self, text, x, y, var_name, command=None, visible=True, variable=None):
        var = variable or IntVar()

        checkbox = CTkCheckBox(
            self.root, text=text, font=self.font,
            fg_color=COLORS["accent"], hover_color="#66b2ff",
            text_color=COLORS["text"],
            variable=var, corner_radius=7,
            checkbox_width=20, checkbox_height=20,
            command=command
        )
        if visible:
            checkbox.place(x=x, y=y)

        setattr(self, var_name, var)
        return checkbox
    

    def follow_root(self, window, button, width, height):
        if window and window.winfo_exists():
            x = button.winfo_rootx()
            y = button.winfo_rooty() + button.winfo_height()
            window.geometry(f"{width}x{height}+{x}+{y}")