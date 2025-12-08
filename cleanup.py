import os
import shutil
from tkinter import messagebox
from helpers import runReg, handle_prompt, get_active_gpu

del_uni = ['winmm.ini','winmm.dll','uniscaler.config.toml','Uniscaler.asi','nvngx.dll']

del_elden_fsr3 =['_steam_appid.txt','_winhttp.dll','anti_cheat_toggler_config.ini','anti_cheat_toggler_mod_list.txt',
                    'start_game_in_offline_mode.exe','toggle_anti_cheat.exe','ReShade.ini','EldenRingUpscalerPreset.ini',
                    'dxgi.dll','d3dcompiler_47.dll']

del_elden_fsr3_v3 = ['ERSS2.dll','dxgi.dll','ERSS-FG.dll']

del_elden_nightreign = ['dinput8.dll','mod_loader.ini','d3d12.dll','NRSS.dll','steam_appid.txt']

del_bdg_fsr3 = ['nvngx.dll','version.dll','version.org']

del_sh2_dlss = ['dxgi.dll','ReShade.ini','SH2UpscalerPreset.ini']

del_fl4_fsr3 = ['f4se_whatsnew.txt','f4se_steam_loader.dll','f4se_readme.txt','f4se_loader.exe','f4se_1_10_163.dll',
                'CustomControlMap.txt']

del_fh_fsr3 = ['DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','nvngx.dll','RestoreNvidiaSignatureChecks.reg',
                'dinput8.dll','dlssg_to_fsr3.asi','nvapi64.asi','winmm.dll','winmm.ini']

del_rdr2_fsr3 = ['ReShade.ini','RDR2UpscalerPreset.ini','d3dcompiler_47.dll','d3d12.dll','dinput8.dll','ScriptHookRDR2.dll','NVNGX_Loader.asi',
                    'd3dcompiler_47.dll','nvngx.dll','winmm.ini','winmm.dll','fsr2fsr3.config.toml','FSR2FSR3.asi','fsr2fsr3.log']

del_icarus_otgpu_fsr3 = ['nvngx.dll', 'FSR2FSR3.asi','fsr2fsr3.config.toml','winmm.dll','winmm.ini']
del_icarus_rtx_fsr3 = ['RestoreNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg']
                    
del_tekken_fsr3 = ['TekkenOverlay.exe','Tekken8OverlaySettings.yaml','Tekken8Overlay.dll','Tekken7Overlay.dll']

del_gtav_fsr3 = ['GTAVUpscaler.org.asi','GTAVUpscaler.asi','d3d12.dll','dxgi.asi','GTAVUpscaler.dll','GTAVUpscaler.org.dll','dinput8.dll']

del_lotf_fsr3 = ['version.dll','RestoreNvidiaSignatureChecks.reg','nvngx.dll','launch.bat','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg',
                    'Uniscaler.asi','DisableEasyAntiCheat.bat','winmm.dll','winmm.ini']
del_cb2077 = ['nvngx.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll']

del_got = ['version.dll','RestoreNvidiaSignatureChecks.reg','dxgi.dll','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg','d3d12core.dll','d3d12.dll','no-filmgrain.reg']

del_valhalla_fsr3 = ['ReShade.ini','dxgi.dll','ACVUpscalerPreset.ini']

del_hb2 = ['version.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll']

del_aw2_rtx = ['nvngx.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','amd_fidelityfx_vk.dll','amd_fidelityfx_dx12.dll']

del_dd2 = ['dinput8.dll','dlssg_to_fsr3_amd_is_better.dll', 'version.dll']

del_drr_dlss_to_fg_custom = ['dlssg_to_fsr3_amd_is_better.dll', 'version.dll']

del_optiscaler = ['OptiScaler.ini','nvngx.dll','libxess.dll','winmm.dll', 'nvapi64.dll','fakenvapi.ini', 'fakenvapi.dll','dlssg_to_fsr3_amd_is_better.dll','nvngx.ini']

del_dlss_rtx = [ 
'dlss-enabler-upscaler.dll', 'dlss-enabler.dll', 'dlss-enabler.log', 'dlssg_to_fsr3.log',
'dlssg_to_fsr3_amd_is_better-3.0.dll', 'dlssg_to_fsr3_amd_is_better.dll', 'dxgi.dll', 'fakenvapi.log', 'nvngx-wrapper.dll',
'nvngx.ini', 'unins000.dat','nvapi64-proxy.dll','winmm.dll'
]

del_dlss_amd = [
'nvapi64-proxy.dll','dlss-enabler-upscaler.dll', 'dlss-enabler.dll', 'dlss-enabler.log', 'dlssg_to_fsr3.log',
'dlssg_to_fsr3_amd_is_better-3.0.dll', 'dlssg_to_fsr3_amd_is_better.dll', 'dxgi.dll', 'fakenvapi.ini', 'fakenvapi.log',
'nvapi64.dll', 'nvngx-wrapper.dll', 'nvngx.dll', 'nvngx.ini', 'unins000.dat', 'fakenvapi.ini', 'nvapi64.dll', 'winmm.dll'
]

del_dlss_to_fg = ['dlssg_to_fsr3_amd_is_better.dll','version.dll']

def get_cleanup_registry(game_selected, mod_selected, dest_path):
    return {
        ("", ""): {
            "condition": lambda: mod_selected in [
                'FSR4/DLSS FG (Only Optiscaler)',
                'FSR4/DLSSG FG (Only Optiscaler)',
                'FSR4/DLSS Gow4',
                'FSR4/DLSS Nightreign RTX'
            ],
            "actions": [
                {"type": "run_del_optiscaler", "def": True, "base_path": dest_path, "mod": mod_selected},
                {"type": "reg", "path": "mods\\Addons_mods\\DLSS Preset Overlay\\Disable Overlay.reg",
                 "remove_reg": os.path.join(dest_path,"Enable Overlay.reg"), "base_path": dest_path,"show_message": True}
            ]
        },

        ("Elden Ring", ""): {
            "condition": lambda: game_selected == "Elden Ring",
            "actions": [
                *(
                    [
                        {"type": "remove_list", "files": del_elden_fsr3, "base_path": dest_path},
                        {"type": "delete_folder", "path": os.path.join(dest_path, "mods")},
                        {"type": "delete_folder", "path": os.path.join(dest_path, "reshade-shaders")}
                    ] if mod_selected not in ["FSR4/DLSS FG Custom Elden", "Unlock FPS Elden"] else []
                ),
                *(
                    [{"type": "remove_list", "files": del_elden_fsr3_v3, "base_path": dest_path}]
                    if mod_selected == "FSR4/DLSS FG Custom Elden" else []
                ),
                *(
                    [
                        {"type": "delete_folder", "path": os.path.join(dest_path, "mods\\UnlockTheFps")},
                        {"type": "delete_file", "file": os.path.join(dest_path, "mods\\UnlockTheFps.dll")},
                        {"type": "delete_file", "file": os.path.join(dest_path, "UnlockFps.txt")}
                    ] if mod_selected == "Unlock FPS Elden" else []
                )
            ]
        },

        ("Elden Ring Nightreign", ""): {
            "condition": lambda: game_selected == "Elden Ring Nightreign",
            "actions": [
                {"type": "remove_list", "files": del_elden_nightreign, "base_path": dest_path},
                {"type": "delete_folder", "path": os.path.join(dest_path, "NRSS")},
                {"type": "delete_file", "file": os.path.join(dest_path, 'mods\\RemoveChromaticAberration.dll')},
                {"type": "delete_file", "file": os.path.join(dest_path, 'mods\\RemoveVignette.dll')},
                {"type": "run_del_optiscaler", "def": True}
            ]
        },

        ("Dragons Dogma 2", ""): {
            "condition": lambda: game_selected == "Dragons Dogma 2",
            "actions": [
                {"type": "remove_list", "files": del_dd2, "base_path": dest_path}
            ]
        },

        ("Baldur's Gate 3", ""): {
            "condition": lambda: game_selected == "Baldur's Gate 3",
            "actions": [
                {"type": "remove_list", "files": del_bdg_fsr3, "base_path": dest_path},
                {"type": "delete_folder", "path": os.path.join(dest_path,'mods')}
            ]
        },

        ("Cyberpunk 2077", "RTX DLSS FG"): {
            "condition": lambda: game_selected == "Cyberpunk 2077" and mod_selected == "RTX DLSS FG",
            "actions": [
                {"type": "remove_list", "files": del_cb2077, "base_path": dest_path},
                {"type": "reg", "path": "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal\\RestoreNvidiaSignatureChecks.reg"}
            ]
        },

        ("Red Dead Redemption 2", ""): {
            "condition": lambda: game_selected == "Red Dead Redemption 2",
            "actions": [
                *(
                    [
                        {"type": "remove_list", "files": del_optiscaler, "base_path": dest_path},
                        {"type": "remove_file", "file": os.path.join(dest_path, "winmm.dll")}
                    ] if mod_selected == "FSR4/DLSS FG (Only Optiscaler RDR2)" else []
                ),
                *(
                    [
                        {"type": "remove_list", "files": del_rdr2_fsr3, "base_path": dest_path},
                        {"type": "delete_folder", "path": os.path.join(dest_path, "mods")},
                        {"type": "delete_folder", "path": os.path.join(dest_path,'reshade-shaders')}
                    ] if mod_selected in ["RDR2 FG Custom", "RDR2 Mix"] else []
                )
            ]
        },

        ("Palworld", ""): {
            "condition": lambda: game_selected == "Palworld",
            "actions": [
                {"type": "remove_list", "files": del_rdr2_fsr3, "base_path": dest_path},
                {"type": "delete_folder", "path": os.path.join(dest_path, "mods")},
                {"type": "delete_folder", "path": os.path.join(dest_path,'reshade-shaders')},
                {"type": "delete_file", "file": os.path.join(dest_path,'PalworldUpscalerPreset.ini')},
                {"type": "copy_file", "file": os.path.abspath(os.path.join(os.getenv("LOCALAPPDATA"), r"Pal\\Saved\\Config\\WinGDK\\..\\Engine.ini")), 
                 "dest": os.path.join(os.getenv("LOCALAPPDATA"), r"Pal\\Saved\\Config\\WinGDK")}
            ]
        },

        ("Forza Horizon 5", ""): {
            "condition": lambda: game_selected == "Forza Horizon 5",
            "actions": [
                {"type": "remove_list", "files": del_fh_fsr3, "base_path": dest_path},
                {"type": "reg", "path": "mods\\FSR3_FH\\RTX\\RestoreNvidiaSignatureChecks.reg"}
            ]
        },

        ("Dragon Age: Veilguard", ""): {
            "condition": lambda: game_selected == "Dragon Age: Veilguard" and mod_selected == "FSR4/DLSS DG Veil",
            "actions": [
                {"type": "del_fsr_dlss_mods", "rtx": del_dlss_rtx, "amd": del_dlss_amd,"base_path": dest_path},
                {"type": "reg", "path": "mods\\Optiscaler FSR 3.1 Custom\\RestoreNvidiaSignatureChecks.reg"}
            ]
        },

        ("Like a Dragon: Pirate Yakuza in Hawaii", "DLSSG Yakuza"): {
            "condition": lambda: game_selected == "Like a Dragon: Pirate Yakuza in Hawaii" and mod_selected == "DLSSG Yakuza",
            "actions": [
                {"type": "del_fsr_dlss_mods", "rtx": del_dlss_rtx, "amd": del_dlss_amd,"base_path": dest_path},
                {"type": "reg", "path": "mods\\Temp\\NvidiaChecks\\RestoreNvidiaSignatureChecks.reg"}
            ]
        },

        ("Warhammer: Space Marine 2", "FSR4/DLSS FG Marine"): {
            "condition": lambda: game_selected == "Warhammer: Space Marine 2" and mod_selected == "FSR4/DLSS FG Marine",
            "actions": [
                {"type": "del_fsr_dlss_mods", "rtx": del_dlss_rtx, "amd": del_dlss_amd,"base_path": dest_path},
                {"type": "reg", "path": "mods\\Temp\\disable signature override\\DisableSignatureOverride.reg"}
            ]
        },

        ("Icarus", ""): {
            "condition": lambda: game_selected == "Icarus",
            "actions": lambda: [
                *(
                    [
                        {"type": "remove_list", "files": del_icarus_otgpu_fsr3, "base_path": dest_path},
                        {"type": "reg", "path": "mods\\FSR3_FH\\RTX\\RestoreNvidiaSignatureChecks.reg"}
                    ] if mod_selected == "Icarus FSR3 AMD/GTX" else []
                ),
                *(
                   [
                       {"type": "remove_list", "files": del_icarus_rtx_fsr3}
                   ] if mod_selected == "Icarus FSR3 RTX" else []
                )
            ]
        },

        ("TEKKEN 8", "Unlock Fps Tekken 8"): {
            "condition": lambda: game_selected == "TEKKEN 8" and mod_selected == "Unlock Fps Tekken 8",
            "actions": [
                {"type": "remove_list", "files": del_tekken_fsr3, "base_path": dest_path},
                {"type": "delete_folder", "path": os.path.join(dest_path, "assets")}
            ]
        },

        ("Indiana Jones and the Great Circle", ""): {
            "condition": lambda: game_selected == "Indiana Jones and the Great Circle",
            "actions": [
                *(
                    [
                        {"type": "remove_list", "files": del_tekken_fsr3, "base_path": dest_path},
                        {"type": "delete_folder", "path": os.path.join(dest_path, "assets")}
                    ] if mod_selected == "FSR4/DLSS FG (Only Optiscaler Indy)" else []
                ),
                *(
                    [
                        {"type": "remove_list", "files": del_dlss_to_fg, "base_path": dest_path},
                        {"type": "remove_file", "file": os.path.join(os.environ['USERPROFILE'], 'Saved Games\\MachineGames\\TheGreatCircle\\base\\TheGreatCircleConfig.local')},
                        {
                            "type": "rename",
                            "old": os.path.join(
                                os.environ['USERPROFILE'],
                                'Saved Games\\MachineGames\\TheGreatCircle\\base\\TheGreatCircleConfig.txt'
                            ),
                            "new": os.path.join(
                                os.environ['USERPROFILE'],
                                'Saved Games\\MachineGames\\TheGreatCircle\\base\\TheGreatCircleConfig.local'
                            )
                        }
                    ] if mod_selected == "Indy FG (Only RTX)" else []
                )
            ]
        },

        ("Monster Hunter Wilds", "DLSSG Wilds (Only RTX)"): {
            "condition": lambda: game_selected == "Monster Hunter Wilds" and mod_selected == "DLSSG Wilds (Only RTX)",
            "actions": [
                {"type": "remove_list", "files": del_dlss_to_fg, "base_path": dest_path},
                {"type": "remove_file", "file": os.path.join(dest_path, "dinput8.dll")}
            ]
        },

        ("Dead Rising Remaster", "FSR 3.1 FG DRR"): {
            "condition": lambda: game_selected == "Dead Rising Remaster" and mod_selected == "FSR 3.1 FG DRR",
            "actions": [
                {"type": "remove_list", "files": del_drr_dlss_to_fg_custom, "base_path": os.path.join(dest_path, 'reframework\\plugins')},
                {"type": "remove_file", "file": os.path.join(dest_path, "dinput8.dll")}
            ]
        },

        ("GTA V", ""): {
            "condition": lambda: game_selected == "GTA V" and mod_selected not in ['FSR4/DLSS FG (Only Optiscaler)'],
            "actions": [
                {"type": "rename", 
                 "old": os.path.join(dest_path,'dxgi.dll'),
                 "new": os.path.join(dest_path,'dxgi.asi')},
                {"type": "delete_folder", "file": os.path.join(dest_path, "mods\\Shaders")}
            ]
        },

        ("Lords of the Fallen", "DLSS FG LOTF2 (RTX)"): {
            "condition": lambda: game_selected == "Lords of the Fallen" and mod_selected == "DLSS FG LOTF2 (RTX)",
            "actions": [
                {"type": "remove_list", "files": del_dlss_to_fg, "base_path": dest_path},
                {"type": "remove_file", "file": os.path.join(dest_path, "rungame.bat")}
            ]
        },

        ("The Callisto Protocol", ""): {
            "condition": lambda: game_selected == "The Callisto Protocol",
            "actions": [
                *(
                    [
                        {"type": "remove_list", "files": del_uni, "base_path": dest_path},
                        {"type": "delete_folder", "file": os.path.join(dest_path, "uniscale")}
                    ] if mod_selected == "The Callisto Protocol FSR3" else []
                ),
                *(
                    [
                        {"type": "remove_list", "files": del_optiscaler, "base_path": dest_path}
                    ] if mod_selected == "FSR4/DLSS Custom Callisto" else []
                )
            ]
        },

        ("Resident Evil 4 Remake", ""):{
            "condition": lambda: game_selected == "Resident Evil 4 Remake",
            "actions": [ 
                {"type": "delete_folder", "path": os.path.join(dest_path,'reframework')},  
                {"type": "remove_file", "file": os.path.join(dest_path, "dinput8.dll")},
            ]             
        },

        ("Silent Hill 2", ""):{
            "condition": lambda: game_selected == "Silent Hill 2" and mod_selected == "DLSS FG RTX",
            "actions": [ 
                {"type": "remove_list", "files": del_sh2_dlss, "base_path": dest_path},  
                {"type": "delete_folder", "path": os.path.join(dest_path,'mods')},
                {"type": "delete_folder", "path": os.path.join(dest_path,'reshade-shaders')},
            ]             
        },

        ("Suicide Squad: Kill the Justice League", ""):{
            "condition": lambda: game_selected == "Suicide Squad: Kill the Justice League",
            "actions": [ 
                {"type": "remove_copy", "dest":os.path.abspath(os.path.join(dest_path, '..\\..\\..')),
                 "folder": os.path.abspath(os.path.join(dest_path, '..\\..\\..\\EasyAntiCheat')), 
                 "folder_copy": os.path.abspath(os.path.join(dest_path, '..\\..\\..\\Backup EAC')), 
                 "del_folder":  os.path.abspath(os.path.join(dest_path, '..\\..\\..\\Backup EAC'))},
            ]             
        },

        ("God Of War 4", ""):{
            "condition": lambda: game_selected == "God Of War 4",
            "actions": [ 
                {"type": "remove_list", "files": del_optiscaler, "base_path": dest_path},  
                {"type": "reg", "path": "mods\\Temp\\disable signature override\\DisableSignatureOverride.reg"}
            ]             
        },

        ("Ghost of Tsushima", "Ghost of Tsushima FG DLSS"):{
            "condition": lambda: game_selected == "Ghost of Tsushima" and mod_selected == "Ghost of Tsushima FG DLSS",
            "actions": [ 
                {"type": "remove_list", "files": del_got, "base_path": dest_path},  
                {"type": "reg", "path": "mods\\Temp\\NvidiaChecks\\RestoreNvidiaSignatureChecks.reg"}
            ]             
        },

        ("Hellblade 2", "Hellblade 2 FSR3 (Only RTX)"):{
            "condition": lambda: game_selected == "Hellblade 2" and mod_selected == "Hellblade 2 FSR3 (Only RTX)",
            "actions": [ 
                {"type": "remove_list", "files": del_hb2, "base_path": dest_path},  
                {"type": "reg", "path": "mods\\Temp\\NvidiaChecks\\RestoreNvidiaSignatureChecks.reg"}
            ]             
        },

        ("Assassin's Creed Valhalla", ""):{
            "condition": lambda: game_selected == "Assassin's Creed Valhalla",
            "actions": [ 
                {"type": "remove_list", "files": del_valhalla_fsr3, "base_path": dest_path},  
                {"type": "delete_folder", "path": os.path.join(dest_path,'reshade-shaders')},
                {"type": "delete_folder", "path": os.path.join(dest_path,'mods')},
            ]             
        },

        ("Alan Wake 2", "Alan Wake 2 FG RTX"):{
            "condition": lambda: game_selected == "Alan Wake 2" and mod_selected == "Alan Wake 2 FG RTX",
            "actions": [ 
                {"type": "remove_list", "files": del_aw2_rtx, "base_path": dest_path},  
            ]             
        },

        ("Black Myth: Wukong", "DLSS FG (ALL GPUs) Wukong"):{
            "condition": lambda: game_selected == "Black Myth: Wukong" and mod_selected == "DLSS FG (ALL GPUs) Wukong",
            "actions": [ 
                {"type": "remove_list", "files": del_dlss_to_fg, "base_path": dest_path},  
                {"type": "reg", "path": "mods\\Addons_mods\\OptiScaler\\EnableSignatureOverride.reg"}
            ]             
        },

        ("Final Fantasy XVI", "FFXVI DLSS RTX"):{
            "condition": lambda: game_selected == "Final Fantasy XVI" and mod_selected == "FFXVI DLSS RTX",
            "actions": [ 
                {"type": "remove_list", "files": del_dlss_to_fg, "base_path": dest_path},  
                {"type": "del_fsr_dlss_mods", "rtx": del_dlss_rtx, "amd": del_dlss_amd,"base_path": dest_path},
            ]             
        }
    }

def count_cleanup_items(dest_path, game_selected, mod_selected=None):
    registry = get_cleanup_registry(game_selected, mod_selected, dest_path)
    total = 0
    for (game, mod), data in registry.items():
        try:
            if not data["condition"]():
                continue
            actions = data["actions"]
            if callable(actions):
                actions = actions()
            for action in actions:
                t = action.get("type")
                if t == "remove_list":
                    base = action.get("base_path", dest_path)
                    for f in action.get("files", []):
                        if os.path.exists(os.path.join(base, f)):
                            total += 1
                elif t == "delete_folder":
                    if os.path.exists(action.get("path")):
                        total += 1
                elif t == "delete_file":
                    if os.path.exists(action.get("file")):
                        total += 1
                elif t == "copy_file":
                    if os.path.exists(action.get("file")):
                        total += 1
                elif t == "del_fsr_dlss_mods":
                    gpu_name = get_active_gpu()
                    target = action.get("rtx") if "nvidia" in gpu_name.lower() else action.get("amd", [])
                    for fn in target:
                        if os.path.exists(os.path.join(action.get("base_path", dest_path), fn)):
                            total += 1
                elif t == "run_del_optiscaler":
                    base = action.get("base_path", dest_path)
                    found = False
                    for fn in del_optiscaler:
                        if os.path.exists(os.path.join(base, fn)):
                            found = True
                            break
                    if found:
                        total += 1
                elif t == "remove_copy":
                    if os.path.exists(action.get("folder")):
                        total += 1
                elif t == "rename":
                    if os.path.exists(action.get("old")):
                        total += 1
        except Exception:
            pass
    return total

def del_all_mods_optiscaler(dest_path, mod_list, remove_dxgi=False, search_folder_name=None, progress_callback=None):
    try:
        nvngx = os.path.join(dest_path, 'nvngx.dll')
        nvngx_dlss = os.path.join(dest_path, 'nvngx_dlss.dll')
        if os.path.exists(nvngx):
            try:
                os.replace(nvngx, nvngx_dlss)
                if progress_callback: progress_callback()
            except Exception:
                pass

        if remove_dxgi:
            dxgi = os.path.join(dest_path, 'dxgi.dll')
            if os.path.exists(dxgi):
                os.remove(dxgi)
                if progress_callback: progress_callback()

        for item in mod_list:
            full = os.path.join(dest_path, item)
            if os.path.exists(full):
                os.remove(full)
                if progress_callback: progress_callback()

        if search_folder_name is not None:
            mods_path = os.path.join(dest_path, search_folder_name)
            if os.path.exists(mods_path):
                shutil.rmtree(mods_path)
                if progress_callback: progress_callback()
        return True

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.') 
        print(e)
        return False

def perform_cleanup_action(action, progress_callback=None):
    try:
        action_type = action.get("type")
        if action_type == "remove_list":
            base = action.get("base_path", "")
            for file in action.get("files", []):
                full_path = os.path.join(base, file)
                if os.path.exists(full_path):
                    os.remove(full_path)
                    if progress_callback:
                        progress_callback()

        elif action_type == "del_fsr_dlss_mods":
            gpu_name = get_active_gpu()
            target_list = action.get("rtx") if "nvidia" in gpu_name.lower() else action.get("amd", [])
            base = action.get("base_path", "")
            for file_name in target_list:
                full_path = os.path.join(base, file_name)
                if os.path.exists(full_path):
                    os.remove(full_path)
                    if progress_callback:
                        progress_callback()

        elif action_type == "reg":
            path_reg = action.get("path")
            base = action.get("base_path", "")
            if path_reg and os.path.exists(os.path.join(base, "Enable Overlay.reg")):
                if action.get("show_message"):
                    handle_prompt(
                        'DLSS Overlay',
                        'Do you want to disable the DLSS Overlay?',
                        lambda _: (
                            runReg(action["path"]),
                            os.remove(action.get("remove_reg")) if action.get("remove_reg") else None,
                            progress_callback() if progress_callback else None
                        )
                    )
                else:
                    runReg(action["path"])
                    if progress_callback:
                        progress_callback()

        elif action_type == "delete_folder":
            p = action.get("path")
            if os.path.exists(p):
                shutil.rmtree(p)
                if progress_callback:
                    progress_callback()

        elif action_type == "remove_copy":
            if os.path.exists(action.get("folder")):
                if action.get("handle_message") is not None:
                    handle_prompt(
                        'File',
                        action["handle_message"],
                        lambda _: (
                            shutil.rmtree(action["folder"]),
                            shutil.copytree(action["folder_copy"], action["dest"], dirs_exist_ok=True),
                            progress_callback() if progress_callback else None
                        )
                    )
                if action.get("del_folder") == True:
                    shutil.rmtree(action["folder_copy"])
                    if progress_callback:
                        progress_callback()

        elif action_type == "delete_file":
            if os.path.exists(action.get("file")):
                os.remove(action.get("file"))
                if progress_callback:
                    progress_callback()

        elif action_type == "copy_file":
            if os.path.exists(action.get("file")):
                shutil.copy2(action.get("file"), action.get("dest"))
                os.remove(action.get("file"))
                if progress_callback:
                    progress_callback()

        elif action_type == "run_del_optiscaler":
            if action.get("def") == True:
                del_all_mods_optiscaler(
                    action["base_path"],
                    del_optiscaler, 
                    remove_dxgi=True,
                    search_folder_name=None,
                    progress_callback=progress_callback
                )

        elif action_type == "rename":
            if os.path.exists(action.get("old")):
                os.rename(action.get("old"), action.get("new"))
                if progress_callback:
                    progress_callback()

    except Exception as e:
        print(e)

def setup_cleanup(dest_path, game_selected, mod_selected=None, progress_callback=None):
    registry = get_cleanup_registry(game_selected, mod_selected, dest_path)
    
    for (game, mod), data in registry.items():
        try:
            cond = data["condition"]()
            if cond:
                actions = data["actions"]
                if callable(actions):
                    actions = actions()
                for action in actions:
                    perform_cleanup_action(action, progress_callback=progress_callback)
        except Exception as e:
            print(e)