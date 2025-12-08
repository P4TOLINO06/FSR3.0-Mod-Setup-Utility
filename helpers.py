import os
import shutil
import json
from tkinter import messagebox
import subprocess
import psutil
import tkinter as tk
import os, json, shutil
import sys

# TOOLTIP
def show_tip(obj, text=None):
    widget = getattr(obj, "widget", obj)

    if text is None:
        text = getattr(widget, "_tooltip_text", "")

    if not text:
        return
    
    if hasattr(widget, "_tipwindow") and widget._tipwindow:
        try:
            widget._tipwindow.destroy()
        except Exception:
            pass
        widget._tipwindow = None

    x = widget.winfo_rootx()
    y = widget.winfo_rooty() + widget.winfo_height()
    widget._tipwindow = tw = tk.Toplevel(widget)
    tw.wm_overrideredirect(True)
    tw.wm_geometry(f"+{x}+{y}")
    label = tk.Label(
        tw, text=text, justify=tk.LEFT, font=("Segoe UI", 10),
        background="#FFFFFF", relief=tk.SOLID, borderwidth=0
    )
    label.pack(ipadx=3, ipady=1)


def hide_tip(obj):
    widget = getattr(obj, "widget", obj)

    if hasattr(widget, "_tipwindow") and widget._tipwindow:
        try:
            widget._tipwindow.destroy()
        except Exception:
            pass
        widget._tipwindow = None


def bind_tooltip(widget, text, limit=33):
    ul= getattr(widget, "widget", widget)
    try:
        ul._tooltip_text = text
    except Exception:
        setattr(widget, "_tooltip_text", text)

    hide_tip(widget)

    if len(text) > limit:
        widget.bind("<Enter>", lambda e, w=widget: show_tip(w))
        widget.bind("<Leave>", lambda e, w=widget: hide_tip(w))
    else:
        widget.unbind("<Enter>")
        widget.unbind("<Leave>")
        hide_tip(widget) 
    
def run_dis_anti_c(dest_path):
    var_anti_c = messagebox.askyesno('Disable Anti Cheat','Do you want to disable the anticheat? (only for Steam users)')

    del_anti_c_path = os.path.join(dest_path,'toggle_anti_cheat.exe')
    if var_anti_c:
        subprocess.call(del_anti_c_path)

def copy_with_progress(src, dst, progress_callback=None):

    if isinstance(src, (list, tuple)):
        for item in src:
            copy_with_progress(item, dst, progress_callback)
        return

    # 1: file -> file (ex: nvngx_dlss.dll -> nvngx.dll)
    if os.path.isfile(src) and (dst.lower().endswith(".dll") or os.path.splitext(dst)[1] != ""):
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copy2(src, dst)
        if progress_callback:
            progress_callback()
        return

    # 2: file -> folder 
    if os.path.isfile(src) and not os.path.exists(dst):
        os.makedirs(dst, exist_ok=True)
        shutil.copy2(src, os.path.join(dst, os.path.basename(src)))
        if progress_callback:
            progress_callback()
        return

    # 3: folder -> folder
    items = []
    if os.path.isdir(src):
        for root, dirs, filenames in os.walk(src):
            for d in dirs:
                items.append(os.path.join(root, d))
            for f in filenames:
                items.append(os.path.join(root, f))
    else:
        items.append(src)

    total = len(items)
    if total == 0:
        if progress_callback:
            progress_callback()
        return
    
    if progress_callback:
        progress_callback()

    for i, item in enumerate(items, 1):
        rel_path = os.path.relpath(item, src)
        dest_item = os.path.join(dst, rel_path)

        if os.path.isdir(item):
            os.makedirs(dest_item, exist_ok=True)
        else:
            os.makedirs(os.path.dirname(dest_item), exist_ok=True)
            shutil.copy2(item, dest_item)

        if progress_callback:
            progress_callback()
    
    if progress_callback:
        progress_callback()


def handle_prompt(window_title, window_message,action_func=None):
    user_choice = messagebox.askyesno(window_title, window_message)
    
    if user_choice and action_func:
        action_func(user_choice)

    return user_choice

def runReg(path_reg):
    reg_path = ['regedit.exe', '/s', path_reg]

    subprocess.run(reg_path,check=True)    

def dlss_to_fsr(dest_path, progress_callback):
    path_dlss_to_fsr = 'mods\\DLSS_TO_FSR'
    dlss_to_fsr_reg = "mods\\Temp\\NvidiaChecks\\DisableNvidiaSignatureChecks.reg"
    
    copy_with_progress(path_dlss_to_fsr, dest_path, progress_callback)
    
    runReg(dlss_to_fsr_reg)

def global_dlss(dest_path, progress_callback = None):
    path_dlss_rtx = 'mods\\DLSS_Global\\RTX'
    path_dlss_rtx_reshade = 'mods\\DLSS_Global\\RTX_Reshade'
    path_dlss_amd = 'mods\\DLSS_Global\\AMD'
    path_dlss_amd_reshade = 'mods\\DLSS_Global\\AMD_Reshade'
    dlss_global_reg = "mods\\Temp\\NvidiaChecks\\DisableNvidiaSignatureChecks.reg"

    if os.path.exists(os.path.join(dest_path, 'reshade-shaders')):
        var_gpu_copy(dest_path, path_dlss_amd_reshade, path_dlss_rtx_reshade, progress_callback)
    else:
        var_gpu_copy(dest_path, path_dlss_amd, path_dlss_rtx, progress_callback)
    
    runReg(dlss_global_reg)

def search_un(): # Search for all available storage drives
    local_disk_names = []

    for partition in psutil.disk_partitions(all=False):
        if 'cdrom' not in partition.opts and partition.fstype != '':
            local_disk_names.append(partition.device)

    return local_disk_names

def get_active_gpu():
    try:
        # Use PowerShell to identify GPUs in Windows with details about the driver and memory
        result = subprocess.check_output(
            ['powershell', '-Command', 
            'Get-CimInstance -ClassName Win32_VideoController | Select-Object Caption, DriverDate, DriverVersion, AdapterRAM'],
            stderr=subprocess.STDOUT, 
            creationflags=subprocess.CREATE_NO_WINDOW
        )
        
        gpu_info = result.decode('utf-8').strip().split("\n")

        # Filter out empty results and split GPU data
        user_gpus = [gpu.strip() for gpu in gpu_info[2:] if gpu.strip()]  # Ignore header lines

        if not user_gpus:
            return None

        # If there's only one GPU, it's automatically the primary one
        if len(user_gpus) == 1:
            return user_gpus[0].lower()  # Return the GPU name in lowercase

        # If there are more than one GPU, try to identify which one is currently in use
        utilization_result = subprocess.check_output(
            ['powershell', '-Command', 
            'Get-CimInstance -ClassName Win32_PerfFormattedData_Counters_GPUUsage | Select-Object GPUTime'],
            stderr=subprocess.STDOUT,
            creationflags=subprocess.CREATE_NO_WINDOW
        )
        utilization_info = utilization_result.decode('utf-8').strip().split("\n")

        # Filter the usage data (considering the first line is a header)
        gpu_usages = [int(usage.strip()) for usage in utilization_info[2:] if usage.strip()]

        # If there are more than one GPU, select the one with the highest usage
        if len(user_gpus) == len(gpu_usages):
            primary_gpu = user_gpus[gpu_usages.index(max(gpu_usages))]  # GPU with the highest usage will be considered the primary one

        return primary_gpu.lower()  # Return the primary GPU 

    except subprocess.CalledProcessError:
        return None

def var_gpu_copy(dest_path, path_amd, path_rtx, progress_callback=None):
    gpu_name = get_active_gpu()

    print(gpu_name)

    if 'nvidia' in gpu_name:
        copy_with_progress(path_rtx, dest_path, progress_callback)
    elif 'amd' in gpu_name or 'intel' in gpu_name:
        copy_with_progress(path_amd, dest_path, progress_callback)
    elif gpu_name is None:
        src = path_rtx if messagebox.askyesno('GPU', 'Do you have an Nvidia GPU?') else path_amd
        copy_with_progress(src, dest_path, progress_callback)

def load_or_create_json(filename, default_data):

    if getattr(sys, "frozen", False):
        exe_dir = os.path.dirname(sys.executable)
    else:
        exe_dir = os.getcwd()

    exe_file = os.path.join(exe_dir, "J", filename)
    print("J/Json file:", exe_file)

    # app data
    appdir = os.path.join(os.getenv("LOCALAPPDATA"), "FSR-Mod-Utility")
    os.makedirs(appdir, exist_ok=True)
    appdata_file = os.path.join(appdir, filename)

    def hide_only(path):
        """ J/Json hidden. """
        if os.path.exists(path) and os.name == "nt":
            subprocess.call(["attrib", "+h", path],
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    def hide_and_protect_appdata(path):
        """ Hidden + Read only appdata json """
        if os.path.exists(path) and os.name == "nt":
            subprocess.call(["attrib", "+h", "+r", path],
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    def make_writable(path):
        """ disable read only """
        if os.path.exists(path) and os.name == "nt":
            subprocess.call(["attrib", "-h", "-r", path],
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    # J/Json load
    exe_json_valid = False
    exe_json_data = None

    if os.path.exists(exe_file) and os.path.getsize(exe_file) > 2:
        try:
            with open(exe_file, "r", encoding="utf-8") as f:
                exe_json_data = json.load(f)
            exe_json_valid = True
            hide_only(exe_file)  # J/Json hidden
        except:
            exe_json_valid = False

    if not os.path.exists(appdata_file):

        if exe_json_valid:
            shutil.copy2(exe_file, appdata_file)
            hide_and_protect_appdata(appdata_file)
            return exe_json_data

        with open(appdata_file, "w", encoding="utf-8") as f:
            json.dump(default_data, f, indent=4)
        hide_and_protect_appdata(appdata_file)
        return default_data

    try:
        with open(appdata_file, "r", encoding="utf-8") as f:
            data = json.load(f)
        hide_and_protect_appdata(appdata_file)
        return data

    except:
        make_writable(appdata_file)

        if exe_json_valid:
            shutil.copy2(exe_file, appdata_file)
            hide_and_protect_appdata(appdata_file)
            return exe_json_data

        with open(appdata_file, "w", encoding="utf-8") as f:
            json.dump(default_data, f, indent=4)
        hide_and_protect_appdata(appdata_file)
        return default_data

def config_json(path_json, values_json,ini_message=None):
    var_config_json = False

    if os.path.exists(path_json):
        try:
            while not var_config_json:

                if os.path.exists(path_json):
                    var_config_json = True
                else:
                    var_config_json = False        
            
            if var_config_json:

                with open(path_json, 'r', encoding='utf8') as file:
                    data = json.load(file)

                for key, new_value in values_json.items():
                    if key in data:
                        data[key] = new_value

                with open(path_json, 'w', encoding='utf8') as file:
                    json.dump(data, file, indent=4)

                messagebox.showinfo('Sucess',ini_message)
        except Exception as e:
            messagebox.showinfo("Error","An error occurred in the Utility. Try closing and reopening it")
    else:
        messagebox.showinfo('Not Found', 'File not found, the installation could not be completed')

def Remove_ini_effect(game_selected, key_ini, value_ini, path_ini, message_path_not_found, message_hb2 = None):
    
    if not os.path.exists(path_ini):
        messagebox.showinfo('Path Not Found', message_path_not_found)
        return

    if game_selected == 'Hellblade 2':
        dest_path = os.path.dirname(path_ini)

    with open(path_ini, 'r') as configfile:
        lines = configfile.readlines()

    section_exists = False
    section_start = None
    section_end = None

    for idx, line in enumerate(lines):
        if line.strip() == f"[{key_ini}]":
            section_exists = True
            section_start = idx
        elif line.startswith('[') and section_start is not None:
            section_end = idx
            break

    if section_exists:
        updated_section = lines[section_start:(section_end if section_end is not None else len(lines))]
        
        for key, new_value in value_ini.items():
            for idx, line in enumerate(updated_section):
                if line.startswith(f"{key}="):
                    updated_section[idx] = f"{key}={new_value}\n"
                    break
            else:
                updated_section.append(f"{key}={new_value}\n")

        lines[section_start:(section_end if section_end is not None else len(lines))] = updated_section
    else:
        lines.append("\n") 
        lines.append(f"\n[{key_ini}]\n")
        lines.extend(f"{key}={value}\n" for key, value in value_ini.items())

    with open(path_ini, 'w') as configfile:
        configfile.writelines(lines)
    
    if message_hb2 != None:
        messagebox.showinfo('Success', message_hb2)
        
def remove_post_processing_effects_hell2(dest_path):
    path_inihb2 = os.getenv("LOCALAPPDATA") + '\\Hellblade2\\Saved\\Config\\Windows\\Engine.ini'
    alt_path_hb2 = os.getenv("LOCALAPPDATA") + '\\Hellblade2\\Saved\\Config\\WinGDK\\Engine.ini'
    
    value_remove_black_bars = {'r.NT.EnableConstrainAspectRatio' :'0'}
    value_remove_black_bars_alt = {
                'r.NT.AllowAspectRatioHorizontalExtension': '0',
                'r.NT.EnableConstrainAspectRatio': '0'
            }
    
    value_remove_all_pos_processing = {
        'r.DefaultFeature.MotionBlur':'0',
        'r.MotionBlurQuality':'0',
        'r.NT.Lens.ChromaticAberration.Intensity':'0',
        'r.Tonemapper.GrainQuantization':'0',
        'r.DepthOfFieldQuality':'0',
        'r.FilmGrain':'0',
        'r.NT.DOF.NTBokehTransform':'0',
        'r.NT.Lens.Distortion.Stretch':'0',
        'r.NT.Lens.Distortion.Intensity':'0',
        'r.SceneColorFringeQuality':'0',
        'r.NT.DOF.RotationalBokeh':'0',
        'r.NT.AllowAspectRatioHorizontalExtension':'0',
        'r.Tonemapper.Quality':'0',
        'r.NT.EnableConstrainAspectRatio':'0'
    }
    
    key_remove_post_processing = 'SystemSettings'
    message_path_not_found_hb2 = 'Path not found, please select manually. The path to the Engine.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\Hellblade2\\Saved\\Config\\Windows or WinGDK. If you need further instructions, refer to the Hellblade 2 FSR Guide'
    path_final = ""

    if os.path.exists(os.path.join(path_inihb2)):
        path_final = path_inihb2
            
    elif os.path.exists(os.path.join(alt_path_hb2)):
        path_final = alt_path_hb2
    
    elif dest_path is None: 
        messagebox.showinfo('Path Not Found','Path not found, please select manually. The path to the Engine.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\Hellblade2\\Saved\\Config\\Windows or WinGDK and then select the option again. If you need further instructions, refer to the Hellblade 2 FSR Guide') 
        return
    else:
        manually_folder_ini = os.path.join(dest_path,'Engine.ini')
        if os.path.exists(manually_folder_ini):
            path_final = manually_folder_ini
    
    if path_final != "":

        # Remove Black Bars   
        handle_prompt(
        'Remove Black Bars',
        'Do you want to remove the Black Bars?',
        lambda _: (
            Remove_ini_effect("Hellblade 2",key_remove_post_processing,value_remove_black_bars,path_final,message_path_not_found_hb2) 
            )
        )

        # Remove Black Bars Alt
        handle_prompt(
        'Remove Black Bars Alt',
        'Do you want to remove the Black Bars? Select this option if the previous option did not work, the removal of the black bars will be\nautomatically performed if the Engine.ini file is found. If it is not found, you need to select the path\nin \'Select Folder\' and press \'Install\'.\n\n',
        lambda _: (
                Remove_ini_effect("Hellblade 2",key_remove_post_processing,value_remove_black_bars_alt,path_final,message_path_not_found_hb2)  
            )
        )    

        # Remove Post Processing Effects
        handle_prompt(
        'Remove Post Processing Effects',
        'Do you want to remove the main post-processing effects? (Lens Distortion, Black Bars, and Chromatic Aberration will be removed). If you want to remove all post-processing effects, select "No" and then select "Yes" in the next window.',
        lambda _: (
                Remove_ini_effect("Hellblade 2",key_remove_post_processing,value_remove_black_bars_alt,path_final,message_path_not_found_hb2)  
            )
        )   

        # Remove All Post Processing Effects
        handle_prompt(
        'Remove All Post Processing Effects',
        'Do you want to remove all post-processing effects?',
        lambda _: (
                Remove_ini_effect("Hellblade 2",key_remove_post_processing,value_remove_all_pos_processing,path_final,message_path_not_found_hb2) 
            )
        )   

        handle_prompt(
        'Restore Post Processing',
        'Do you want to revert to the post-processing options? (Black bars, film grain, etc.)',
        lambda _: (
            path_replace_ini := 'mods\\FSR3_HB2\\Replace_ini\\Engine.ini',

            os.path.exists(os.path.join(path_inihb2)) and shutil.copy2(path_replace_ini, path_inihb2) or
            os.path.exists(os.path.join(alt_path_hb2)) and shutil.copy2(path_replace_ini, alt_path_hb2) or
            dest_path is None or (
                replace_ini_path := os.path.join(dest_path, 'Engine.ini'),
                os.path.exists(replace_ini_path) and shutil.copy2(path_replace_ini, os.path.dirname(replace_ini_path))
                )
            )
        )
    else:
        messagebox.showinfo('Not Found', 'Engine.ini not found, please check if it exists. The path is something like C:\\Users\\YourName\\AppData\\Local\\Hellblade2\\Saved\\Config\\Windows or WinGDK. If it\'s not there, open the game to have the file created.')