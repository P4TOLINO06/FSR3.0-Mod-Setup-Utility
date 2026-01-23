import os 
import shutil
from tkinter import messagebox
import asyncio
from helpers import *
import re

from games_mods_config import addons_files

class ModInstaller:
    def __init__(self, dest_path, game_selected, mod_selected, progress_callback=None):
        self.dest_path = dest_path
        self.game_selected = game_selected
        self.mod_selected = mod_selected
        self.progress_callback = progress_callback
        self.gpu_name = get_active_gpu()
        
        self.game_handlers = {
            "Elden Ring": self.install_elden_ring,
            "Elden Ring Nightreign": self.install_elden_nightreign,
            "Forza Horizon 5": self.install_forza_horizon_5,
            "Icarus": self.install_icarus,
            "Lords of the Fallen": self.install_lords_of_the_fallen,
            "Cod Black Ops Cold War": self.install_cod_black_ops_cold_war,
            "COD MW3": self.install_cod_mw3,
            "Dead Rising Remaster": self.install_dead_rising_remaster,
            "Cyberpunk 2077": self.install_cyberpunk_2077,
            "Black Myth Wukong": self.install_black_myth_wukong,
            "Like a Dragon: Pirate Yakuza in Hawaii": self.install_like_a_dragon_pirate_yakuza,
            "Baldur's Gate 3": self.install_baldurs_gate_3,
            "The Callisto Protocol": self.install_callisto,
            "Palworld": self.install_palworld,
            "Silent Hill 2": self.install_silent_hill_2,
            "Suicide Squad Kill the Justice League": self.install_sskjl,
            "Resident Evil 4 Remake": self.install_re4_remake,
            "Dead Islans 2": self.install_di2,
            "Returnal": self.install_returnal,
            "Stalker 2": self.install_stalker2,
            "Red Dead Redemption 2": self.install_rdr2,
            "Monster Hunter Wilds": self.install_mhw,
            "Dragons Dogma 2": self.install_dd2,
            "Dragon Age: Veilguard": self.install_dg_veil,
            "A Quiet Place: The Road Ahead": self.install_quiet_place,
            "Indiana Jones and the Great Circle": self.install_indy,
            "Red Dead Redemption": self.install_rdr,
            "Warhammer: Space Marine 2": self.install_warhammer_space_marine,
            "Hellblade 2": self.install_hellblade_2,
            "Assassin\'s Creed Valhalla": self.install_ac_valhalla,
            "MOTO GP 24": self.install_moto_gp_24,
            "Final Fantasy XVI": self.install_ff16,
            "Ghost of Tsushima": self.install_ghost_of_tsushima,
            "Alan Wake 2": self.install_alan_wake_2,
            "TEKKEN 8": self.install_unlock_fps_tekken_8,           
        }     
       
        mod_groups = {
            self.install_optiscaler_fsr_dlss: {
                'FSR4/DLSS FG (Only Optiscaler)',
                'FSR4/DLSSG FG (Only Optiscaler)',
                'FSR4/DLSS Gow4',
                'FSR4/DLSS Nightreign RTX',
            },
        }
        self.mods_handlers = {}

        for handler, mods_set in mod_groups.items():
            for mod in mods_set:
                self.mods_handlers[mod] = lambda h=handler: h(self.dest_path, self.game_selected, self.mod_selected)

    def verify_mod_selected(self, mod_selected):
        if not mod_selected:
            messagebox.showwarning("Error", "No mod selected. Please select a mod to install.")
            return False
        return True

    def copy_folder(self, src, dst):
        try:
            for root, dirs, files in os.walk(src):
                relative_path = os.path.relpath(root, src)
                dest_path = os.path.join(dst, relative_path)
                os.makedirs(dest_path, exist_ok=True)
                for file in files:
                    shutil.copy2(os.path.join(root, file), os.path.join(dest_path, file))
        except Exception as e:
            messagebox.showerror("Error", f"Failed to copy folder: {e}")
    
    def copy_progress(self, src, dst):
        copy_with_progress(src, dst, self.progress_callback)
    
    def install_mod(self, game_path, mod_selected):
        if not self.verify_mod_selected(mod_selected):
            return
        
        mod_path = os.path.join(mod_path, mod_selected)
        
        try:
            self.copy_folder(mod_path, game_path)            
        except Exception as e:
            messagebox.showerror("Error", f"Failed to install mod: {e}")
            return
    
    # Game-specific installation methods

    # FSR4/DLSS FG (Only Optiscaler) (Default)
    def install_optiscaler_fsr_dlss(self, dest_path, game_selected, mod_selected, copy_dlss = True, copy_nvapi = True): # Default Optiscaler is used for games that don't work with Custom Optiscaler or other mods
        path_optiscaler = 'mods\\Addons_mods\\OptiScaler'
        path_optiscaler_dlss = 'mods\\Addons_mods\\Optiscaler DLSS'
        path_optiscaler_dlssg = 'mods\\Addons_mods\\Optiscaler DLSSG\\OptiScaler.ini'
        path_dlss_to_fsr = 'mods\\Addons_mods\\Optiscaler DLSSG\\dlssg_to_fsr3_amd_is_better.dll'
        path_ini_only_upscalers = 'mods\\Addons_mods\\Optiscaler Only Upscalers\\OptiScaler.ini'
        nvapi_amd = 'mods\\Addons_mods\\Nvapi AMD\\Nvapi'
        nvapi_ini = 'mods\\Addons_mods\\Nvapi AMD\\Nvapi Ini\\OptiScaler.ini'
        nvapi_ini_dlssg = 'mods\\Addons_mods\\Nvapi AMD\\DLSSG Nvapi Ini\\OptiScaler.ini'
        fake_nvapi = 'mods\\Addons_mods\\Fake_Nvapi'
        games_to_install_nvapi_amd = ['Microsoft Flight Simulator 2024', 'Death Stranding Director\'s Cut', 'Shadow of the Tomb Raider', 'Rise of The Tomb Raider', 'The Witcher 3', 'Uncharted Legacy of Thieves Collection', 'Suicide Squad: Kill the Justice League','Sifu', 'Mortal Shell', 'FIST: Forged In Shadow Torch', 'Ghostrunner 2', 'Final Fantasy XVI', 'Sengoku Dynasty', 'Red Dead Redemption 2', 'S.T.A.L.K.E.R. 2', 'Monster Hunter Wilds', 'AVOWED', 'Frostpunk 2', 'STAR WARS Jedi: Survivor', 'Deliver Us Mars', 'GTA V', 'Chernobylite 2: Exclusion Zone', 'South Of Midnight', 'Assassin\'s Creed Shadows', 'Star Wars Outlaws', 'Elder Scrolls IV Oblivion Remaster', 'The Alters', 'Satisfactory']
        games_to_use_anti_lag_2 = ['God of War Ragnarök', 'God Of War 4', 'Path of Exile II', 'Hitman 3', 'Marvel\'s Midnight Suns', 'Hogwarts Legacy', 'The First Berserker: Khazan']
        games_only_upscalers = ['The Last of Us Part I']
        games_with_dlssg = ['The First Berserker: Khazan', 'Atomic Heart','Marvel\'s Spider-Man Remastered', 'Marvel\'s Spider-Man Miles Morales', 'Marvel\'s Spider-Man 2', 'Alan Wake 2', 'S.T.A.L.K.E.R. 2', 'Eternal Strands', 'Monster Hunter Wilds', 'AVOWED', 'Frostpunk 2', 'God of War Ragnarök', 'STAR WARS Jedi: Survivor', 'Deliver Us Mars', 'Chernobylite 2: Exclusion Zone', 'Assassin\'s Creed Shadows', 'The Last of Us Part II', 'Star Wars Outlaws', 'Elder Scrolls IV Oblivion Remaster', 'The Alters', 'Satisfactory' ]
        games_with_anti_cheat = ['Back 4 Blood', 'GTA V']
        games_no_nvngx = ['Red Dead Redemption 2', 'Marvel\'s Spider-Man Remastered', 'Marvel\'s Spider-Man Miles Morales', 'Marvel\'s Spider-Man 2'] # Games that don't need the file nvngx_dlss.dll renamed to nvngx.dll (Only RTX)
        games_with_d3d12 = ['GTA Trilogy'] # Some games (especially Rockstar) do not work with the nvngx.dll file renamed to dxgi.dll; it must be renamed to d3d12.dll instead

        print(self.gpu_name)
        
        try:
            # Rename the dxgi.dll file from ReShade to d3d12.dll
            if os.path.exists(os.path.join(dest_path, 'dxgi.dll')) and os.path.exists(os.path.join(dest_path, 'reshade-shaders')):
                os.replace(os.path.join(dest_path, 'dxgi.dll'), os.path.join(dest_path, 'd3d12.dll'))

            # Rename the DLSS file (nvngx_dlss.dll) to nvngx.dll.
            if os.path.exists(os.path.join(dest_path, 'nvngx_dlss.dll')) and copy_dlss:
                self.copy_progress(path_optiscaler, self.dest_path)
                os.replace(os.path.join(dest_path, 'nvngx.dll'), os.path.join(dest_path, 'dxgi.dll'))

                if not game_selected in games_no_nvngx or self.gpu_name in ['amd', 'rx', 'intel', 'arc', 'gtx']:
                    self.copy_progress(os.path.join(dest_path, 'nvngx_dlss.dll'), os.path.join(dest_path, 'nvngx.dll'))
            else:
                self.copy_progress(path_optiscaler_dlss, dest_path)

                if game_selected in games_no_nvngx and 'rtx' in self.gpu_name and os.path.exists(os.path.join(dest_path, 'nvngx.dll')):
                    os.replace(os.path.join(dest_path, 'nvngx.dll'), os.path.join(dest_path, 'nvngx_dlss.dll'))
            
            # Rename the DLSS file (nvngx_dlss.dll) to d3d12.dll
            if os.path.exists(os.path.join(dest_path, 'dxgi.dll')) and game_selected in games_with_d3d12:
                os.replace(os.path.join(dest_path, 'dxgi.dll'), os.path.join(dest_path, 'd3d12.dll'))

            if mod_selected == 'FSR4/DLSSG FG (Only Optiscaler)':
                self.copy_progress(path_optiscaler_dlssg, dest_path)

                # Install the dlss_to_fsr file if the mod does not work with the default files
                if not re.search(r"rtx\s*(40|50)\d{2}", self.gpu_name) and game_selected not in games_only_upscalers and messagebox.askyesno('DLSS/FSR','Do you want to install the dlssg_to_fsr3_amd_is_better.dll file? It is recommended to install this only if you are unable to enable the game\'s DLSS Frame Generation (this mod does not have its own FG; the game\'s DLSS FG is used).' or game_selected in games_with_dlssg ):
                    self.copy_progress(path_dlss_to_fsr, dest_path)

            if game_selected in games_only_upscalers:
                self.copy_progress(path_ini_only_upscalers, dest_path)

            # AMD Anti Lag 2
            if game_selected in games_to_use_anti_lag_2 and messagebox.askyesno('Anti Lag 2', f'Do you want to use AMD Anti Lag 2? Check the {game_selected} guide in FSR Guide to see how to enable it.'):
                self.copy_progress(nvapi_amd, dest_path)

                nvapi_ini_file = nvapi_ini_dlssg if mod_selected == 'FSR4/DLSSG FG (Only Optiscaler)' else nvapi_ini
                self.copy_progress(nvapi_ini_file, dest_path)

            # Nvapi for non-RTX users
            elif copy_nvapi and any(gpus in self.gpu_name for gpus in ['amd', 'rx', 'intel', 'arc', 'gtx']) and game_selected in games_to_install_nvapi_amd and messagebox.askyesno('Nvapi', 'Do you want to install Nvapi? Only select "Yes" if the mod doesn\'t work with the default files.'):
                self.copy_progress(nvapi_amd, dest_path)
                
                nvapi_ini_file = nvapi_ini_dlssg if mod_selected == 'FSR4/DLSSG FG (Only Optiscaler)' else nvapi_ini
                self.copy_progress(nvapi_ini_file, dest_path)

            if game_selected in games_with_anti_cheat:
                messagebox.showinfo('Anti Cheat','Do not use the mod in Online mode, or you may be banned')
        
            # Fake Nvapi for non-RTX 40/50x users
            if not re.search(r"rtx\s*(40|50)\d{2}", self.gpu_name) and mod_selected in ["FSR4/DLSS FG (Only Optiscaler)", "FSR4/DLSSG FG (Only Optiscaler)"]:
                self.copy_progress(fake_nvapi, dest_path)

        except Exception as e:
            print(e)
  
    # Elden Ring & Nightreign
    def install_elden_ring(self):
        er_origins = {'Disable_Anti-Cheat':'mods\\Elden_Ring_FSR3\\ToggleAntiCheat',
              'Elden_Ring_FSR3':'mods\\Elden_Ring_FSR3\\EldenRing_FSR3',
              'Elden_Ring_FSR3 V2':'mods\\Elden_Ring_FSR3\\EldenRing_FSR3 v2',
              'FSR4/DLSS FG Custom Elden':'mods\\Elden_Ring_FSR3\\EldenRing_FSR3 v3',
              }
        
        if self.game_selected == 'Elden Ring':
            update_fsr_elden = 'mods\\Temp\\Upscalers\\AMD'
            update_dlss_elden = 'mods\\Temp\\Upscalers\\Nvidia\\nvngx_dlss.dll'

            if self.mod_selected in er_origins:
                elden_folder = er_origins[self.mod_selected]

            if self.mod_selected in er_origins:
                self.copy_progress(elden_folder,self.dest_path)

            if self.mod_selected == 'Unlock FPS Elden':  

                self.copy_progress('mods\\Elden_Ring_FSR3\\Unlock_Fps', self.dest_path)

            if os.path.exists(os.path.join(self.dest_path, 'toggle_anti_cheat.exe')):
                run_dis_anti_c(self.dest_path)
            
            if self.mod_selected == 'FSR4/DLSS FG Custom Elden' and os.path.exists(os.path.join(self.dest_path,'ERSS2\\bin')):
                self.copy_progress(update_fsr_elden, os.path.join(self.dest_path,'ERSS2\\bin'))
                self.copy_progress(update_dlss_elden,os.path.join(self.dest_path,'ERSS2\\bin'))
    
    # Elden Ring Nightreign
    def install_elden_nightreign(self):     
        if self.game_selected == 'Elden Ring Nightreign':
            disable_eac_nightreign = 'mods\\Elden_Ring_FSR3\\Nightreign FSR3\\Disable EAC'
            nrss_nightreign = 'mods\\Elden_Ring_FSR3\\Nightreign FSR3\\NRSS'
            remove_vignette_aberration = 'mods\\Elden_Ring_FSR3\\Nightreign FSR3\\Remove Vignette & Aberration'
            
            if self.mod_selected == 'FSR4/DLSS Nightreign RTX':   
                self.copy_progress(disable_eac_nightreign, self.dest_path)
                self.copy_progress(nrss_nightreign, self.dest_path)   
                self.copy_progress(remove_vignette_aberration, self.dest_path)                  
                messagebox.showinfo('Guide', 'It is recommended to check the guide in FSR Guide to complete the installation (it includes additional steps, such as disabling the Anti-Cheat).')        
    
    # Forza Horizon 5
    def install_forza_horizon_5(self):
        path_rtx = 'mods\\FSR3_FH\\RTX'
        path_ot_gpu = 'mods\\FSR3_FH\\Ot_Gpu'       
        en_rtx_reg = "mods\\FSR3_FH\\RTX\\DisableNvidiaSignatureChecks.reg"
        
        if 'rtx' in self.gpu_name:
            self.copy_progress(path_rtx, self.dest_path)
            runReg(en_rtx_reg)
        else:
            self.copy_progress(path_ot_gpu, self.dest_path)
    
    # Palworld
    def install_palworld(self):
        path_pw_mod = 'mods\\FSR3_PW\\FG'
        path_ini_fg_rtx = 'mods\\FSR3_PW\\Ini FG RTX\\PalworldUpscaler.ini'
        appdata_pw = os.getenv("LOCALAPPDATA")
        path_ini_pw = os.path.join(appdata_pw, 'Pal\\Saved\\Config\\WinGDK')
        dx12_ini_pw = 'mods\\FSR3_PW\\Dx12\\Engine.ini'

        if self.mod_selected == 'Palworld Build03':
            self.copy_progress(path_pw_mod, self.dest_path)

            if 'rtx' in self.gpu_name and os.path.exists(os.path.join(self.dest_path, 'mods')):
                self.copy_progress(path_ini_fg_rtx, os.path.join(self.dest_path, 'mods'))

        try:
            if os.path.exists(os.path.join(self.dest_path, 'Palworld-WinGDK-Shipping.exe')):

                if os.path.exists(path_ini_pw):
                    if not os.path.exists(os.path.abspath(os.path.join(path_ini_pw, '..', 'Engine.ini'))):
                        self.copy_progress(os.path.join(path_ini_pw, 'Engine.ini'), os.path.abspath(os.path.join(path_ini_pw, '..'))) # Engine.ini Backup

                        self.copy_progress(dx12_ini_pw, path_ini_pw)
                else:
                    self.copy_progress(dx12_ini_pw, self.dest_path)
                    messagebox.showinfo('Error', 'Unable to activate DX12 (it is required for the mod to work). Try reinstalling or copy the Engine.ini file, which was installed in the selected folder in Utility, to the following path:"C:\\Users\\YourName\\AppData\\Local\\Pal\\Saved\\Config\\WinGDK".')
            
            elif os.path.exists(os.path.join(self.dest_path, 'Palworld-Win64-Shipping.exe')):
                messagebox.showinfo('DX12', 'Check the "Palworld" guide in FSR Guide on how to enable DX12 (it is required for the mod to work).')
        except:
            self.copy_progress(dx12_ini_pw, self.dest_path)
            messagebox.showinfo('Error', 'Unable to activate DX12 (it is required for the mod to work). Try reinstalling or copy the Engine.ini file, which was installed in the selected folder in Utility, to the following path:"C:\\Users\\YourName\\AppData\\Local\\Pal\\Saved\\Config\\WinGDK".')
    
    # Tekken 8
    def install_unlock_fps_tekken_8(self):
        path_tekken = 'mods\\Unlock_fps_Tekken'
        
        if self.mod_selected == 'Unlock Fps Tekken 8':
            self.copy_progress(path_tekken, self.dest_path)

        messagebox.showinfo('Run Overlay','Run TekkenOverlay.exe for the mod to work, refer to the FSR GUIDE if needed.') 
    
    # Icarus
    def install_icarus(self):
        icr_rtx = 'mods\\FSR3_ICR\\ICARUS_DLSS_3_FOR_RTX'
        icr_ot_gpu = 'mods\\FSR3_ICR\\ICARUS_FSR_3_FOR_AMD_GTX'
        icr_rtx_reg = "mods\\FSR3_ICR\\ICARUS_DLSS_3_FOR_RTX\\DisableNvidiaSignatureChecks.reg"
        
        if self.mod_selected == 'Icarus DLSSG RTX':
            self.copy_progress(icr_rtx, self.dest_path)
            act_dlss = messagebox.askyesno('DLSS','Do you want to run DisableNvidiaSignatureChecks.reg? It\'s necessary for the mod to work')
            
            if act_dlss:
                runReg(icr_rtx_reg)
        
        elif self.mod_selected == 'Icarus FSR3 AMD/GTX':
            self.copy_progress(icr_ot_gpu, self.dest_path)
  
    # Monster Hunter Wilds
    def install_mhw(self):
        dlssg_rtx_mhw = 'mods\\FSR3_Wilds\\DLSSG RTX' 

        if self.mod_selected == 'DLSSG Wilds (Only RTX)':
            self.copy_progress(dlssg_rtx_mhw, self.dest_path) 
    
    # Lords of the Fallen
    def install_lords_of_the_fallen(self):
        disableEacLotf2 = """\
        set SteamAppId=1501750
        set SteamGameId=1501750
        start LOTF2-Win64-Shipping.exe -DLSSFG
        """ # Disable the Anti-Cheat for the mod to work. You need to launch the game using the .bat file
        
        if self.mod_selected == 'DLSS FG LOTF2 (RTX)':
            dlss_to_fsr(self.dest_path, self.progress_callback)
            
            with open(os.path.join(self.dest_path, "rungame.bat"), "w") as file:
                file.write(disableEacLotf2)    
                
            messagebox.showinfo('Guide', 'Run the game using the "rungame.bat" file that was created in the mod installation folder. It is recommended to check the guide if you need more information')   
    
    # Cod Black Ops Cold War
    def install_cod_black_ops_cold_war(self):
        messagebox.showinfo('Ban','Do not use the mod in multiplayer, otherwise you may be banned. We are not responsible for any bans')
         
    # Cod MW3
    def install_cod_mw3(self):
        global_dlss(self.dest_path, self.progress_callback)
    
    # Dragon Age Veilguard
    def install_dg_veil(self):
        amd_dg_veil = 'mods\\DLSS_Global\\For games that have native FG\\AMD'
        rtx_dg_veil = 'mods\\DLSS_Global\\For games that have native FG\\RTX'

        if self.mod_selected == 'FSR4/DLSS DG Veil':
            var_gpu_copy(self.dest_path,amd_dg_veil, rtx_dg_veil, self.progress_callback)
    
    # Dragons Dogma 2
    def install_dd2(self):
        dinput_dd2 = 'mods\\FSR3_DD2\\DD2_Framework\\dinput8.dll'

        if self.mod_selected == 'Dinput8 DD2':
            self.copy_progress(dinput_dd2, self.dest_path)
        elif not os.path.exists(os.path.join(self.dest_path, 'dinput8.dll')):
            messagebox.showinfo('Dinput8','If you haven\'t installed the dinput8.dll file, check the DD2 guide in the FSR Guide for installation instructions. It is required for the mod to work')
            return
        
        if self.mod_selected == 'DD2 FG':
            dlss_to_fsr(self.dest_path, self.progress_callback)

        if os.path.exists(os.path.join(self.dest_path,'shader.cache2')):
            if messagebox.showinfo('Do you want to remove the sharder_cache2? It is necessary for the mod to work'):
                os.remove(os.path.join(self.dest_path,'shader.cache2'))
    
    # Alan Wake 2
    def install_alan_wake_2(self):
        path_rtx = 'mods\\FSR3_AW2\\RTX'
        path_dlss = 'mods\\Temp\\Upscalers\\Nvidia\\nvngx_dlss.dll'
        
        if self.mod_selected == 'Alan Wake 2 FG RTX':
            self.copy_progress(path_rtx, self.dest_path)
            self.copy_progress(path_dlss, self.dest_path)

    # Moto GP 24
    def install_moto_gp_24(self):
        if self.dest_path == 'MOTO GP 24':
            path_uni = os.path.join(self.dest_path,'uniscaler')
            
            if os.path.exists(path_uni):
                shutil.rmtree(path_uni)
    
    # Ghost of Tsushima
    def install_ghost_of_tsushima(self):
        path_dlss_got = 'mods\\FSR3_GOT\\DLSS FG'
        got_reg = "mods\\FSR3_GOT\\DLSS FG\\DisableNvidiaSignatureChecks.reg"
        
        if self.mod_selected == 'Ghost of Tsushima FG DLSS':
            shutil.copytree(path_dlss_got,self.dest_path,dirs_exist_ok=True)
            
            runReg(got_reg)
    
    # Yakuza Like a Dragon: Pirate
    def install_like_a_dragon_pirate_yakuza(self):
        nvidia_checks = 'mods\\Temp\\NvidiaChecks\\DisableNvidiaSignatureChecks.reg'

        if self.mod_selected == 'DLSSG Yakuza':
            dlss_to_fsr(self.dest_path, self.progress_callback)
            runReg(nvidia_checks)
  
    # Assassin's Creed Valhalla
    def install_ac_valhalla(self):
        path_dlss = 'mods\\Ac_Valhalla_DLSS'
        path_dlss2 = 'mods\\Ac_Valhalla_DLSS2'
        
        if self.mod_selected == "Ac Valhalla DLSS3 (Only RTX)":
            self.copy_progress(path_dlss, self.dest_path)
        elif  self.mod_selected == "Ac Valhalla FSR3 All GPU":
            self.copy_progress(path_dlss2, self.dest_path)
    
    # Final Fantasy XVI
    def install_ff16(self):
        if self.mod_selected == 'FFXVI DLSS RTX':
            dlss_to_fsr(self.progress_callback, self.dest_path)
    
    # Warhammer: Space Marine 2
    def install_warhammer_space_marine(self):
        path_dxgi = os.path.join(self.dest_path, 'dxgi.dll')
        
        if self.mod_selected == 'FSR4/DLSS FG Marine':
            global_dlss(self.dest_path, self.progress_callback)
        
        if os.path.exists(path_dxgi):
            backup_folder_marine = os.path.join(self.dest_path, 'Backup_DXGI')
            os.makedirs(backup_folder_marine, exist_ok=True)

            self.copy_progress(path_dxgi, backup_folder_marine)

            os.rename(path_dxgi, os.path.join(self.dest_path, 'd3d12.dll'))
    
    # Black Myth Wukong
    def install_black_myth_wukong(self):
        cache_wukong = os.path.join(os.getenv('USERPROFILE'), 'AppData')
          
        try:
            if self.mod_selected == 'FSR4/DLSS FG (Only Optiscaler)' or self.mod_selected == 'FSR4/DLSSG FG (Only Optiscaler)':
                if os.path.exists(os.path.join(cache_wukong, 'Local\\b1\\Saved')) and messagebox.askyesno('Cache','Do you want to clear the game cache? (it may prevent possible texture errors caused by the mod)'):
                    for wukong_cache in os.listdir(os.path.join(cache_wukong, 'Local\\b1\\Saved')):
                        if wukong_cache.endswith(".ushaderprecache"):  
                            path_cache_wukong = os.path.join(os.path.join(cache_wukong, 'Local\\b1\\Saved'), wukong_cache) 
                            if os.path.isfile(path_cache_wukong):  
                                os.remove(path_cache_wukong)                      
        except Exception as e:
            print(e)

    # Hellblade 2
    def install_hellblade_2(self):
        path_dlss_hb2 = 'mods\\FSR3_GOT\\DLSS FG'
        hb2_reg = "mods\\FSR3_GOT\\DLSS FG\\DisableNvidiaSignatureChecks.reg"

        if self.mod_selected == 'Hellblade 2 FSR3 (Only RTX)':
            self.copy_progress(path_dlss_hb2, self.dest_path,)

            runReg(hb2_reg)
        
        if self.mod_selected == 'Others Mods HB2':
            remove_post_processing_effects_hell2(self.dest_path)
    
    # Silent Hill 2
    def install_silent_hill_2(self):
        rtx_fg_sh2 = 'mods\\FSR3_SH2\\RTX_FG'

        if self.mod_selected == 'DLSS FG RTX':
            self.copy_folder(self.dest_path, rtx_fg_sh2)  
    
    # Red Dead Redemption 
    def install_rdr(self):
        if self.mod_selected == 'FSR4/DLSS FG (Only Optiscaler)':
        
            runReg('mods\\Temp\\NvidiaChecks\\DisableNvidiaSignatureChecks.reg')

        if messagebox.askyesno('Enable', 'Do you want to enable Nvidia Signature Checks? Select "Yes" only if the mod does not work'):
            runReg('mods\\Temp\\NvidiaChecks\\RestoreNvidiaSignatureChecks.reg')
    
    # Red Dead Redemption 2
    def install_rdr2(self):
        rdr2_mix = 'mods\\FSR3_RDR2\\RDR2_FSR3_mix'
        rdr2_fg_custom = 'mods\\FSR3_RDR2\\RDR2 FG Custom\\FG'
        rdr2_amd_ini  = 'mods\\FSR3_RDR2\\RDR2 FG Custom\\Amd Ini\\RDR2Upscaler.ini'   
        rdr2_optiscaler = 'mods\\FSR3_RDR2\\Optiscaler_fsr_dlss'

        if self.mod_selected == 'FSR4/DLSS FG (Only Optiscaler RDR2)':
            self.copy_progress(rdr2_optiscaler, self.dest_path)

        if self.mod_selected == 'RDR2 Mix':
            self.copy_progress(rdr2_mix, self.dest_path)
        
        if self.mod_selected == 'RDR2 FG Custom':
            self.copy_progress(rdr2_fg_custom, self.dest_path)

            if 'amd' in self.gpu_name and os.path.exists(os.path.join(self.dest_path, 'mods')):
                self.copy_progress(rdr2_amd_ini, os.path.join(self.dest_path, 'mods'))
        
    # Stalker 2
    def install_stalker2(self):
        dlss_fg_stalker = 'mods\\FSR3_Stalker2\\FG DLSS'
        
        if self.mod_selected == 'DLSS FG (Only RTX)':
            self.copy_progress(dlss_fg_stalker, self.dest_path)
            runReg('mods\\Temp\\NvidiaChecks\\DisableNvidiaSignatureChecks.reg')
    
    # Dead Rising Remasrter
    def install_dead_rising_remaster(self):
        dlss_to_fg_drr = 'mods\\FSR3_DRR\\FSR3FG\\Dlss_to_Fsr'
        dinput_drr = 'mods\\FSR3_DRR\\FSR3FG\\Dinput'
        dlss_drr = 'mods\\Temp\\Upscalers\\Nvidia\\nvngx_dlss.dll'

        if self.mod_selected == 'Dinput8 DRR':
            self.copy_progress(dinput_drr, self.dest_path)

        if self.mod_selected == 'DDR FG':
            if os.path.exists(os.path.join(self.dest_path,'reframework\\plugins')) and os.path.exists(os.path.join(self.dest_path,'dinput8.dll')):
                self.copy_progress(dlss_to_fg_drr, os.path.join(self.dest_path,'reframework\\plugins'))
                self.copy_progress(dlss_drr, self.dest_path)
            else:
                messagebox.showinfo('Not Found', 'First, install the "Dinput8 DRR" before installing the main mod. See the DRR guide in the FSR Guide to learn how to install the mod.')
                return False
        return True
    
    # Dead Island 2
    def install_di2(self):
        path_tcp_di2 = 'mods\\FSR3_DI2\\TCP'

        if self.mod_selected == 'FSR4/DLSS FG (Only Optiscaler)':
            self.copy_progress(path_tcp_di2, self.dest_path)
            runReg('mods\\FSR3_DI2\\TCP\\EnableNvidiaSigOverride.reg')
    
    # Resident Evil 4 Remake
    def install_re4_remake(self):
        fsr_dlss_re4 = 'mods\\FSR3_RE4Remake\\FSR_DLSS'

        if self.mod_selected == 'FSR4/DLSS RE4':
            self.copy_progress(fsr_dlss_re4, self.dest_path)
    
    # Suicide Squad: Kill the Justice League
    def install_sskjl(self):
        root_path_sskjl = os.path.abspath(os.path.join(self.dest_path, '..\\..\\..'))
        path_dxgi_sskjl = os.path.join(self.dest_path, 'dxgi.dll')
        path_nvngx_sskjl = os.path.join(self.dest_path, 'nvngx.dll')
        path_disable_eac = 'mods\\FSR3_SSKJL\\Disable_EAC\\EAC Bypass'
        
        if self.mod_selected == 'FSR4/DLSS FG (Only Optiscaler)':
            if os.path.exists(path_dxgi_sskjl):
                os.replace(path_dxgi_sskjl, os.path.join(self.dest_path, 'winmm.dll')) ## Necessary to rename the file so it won't be replaced by the Disable EAC files.

            if os.path.exists(path_nvngx_sskjl) and 'rtx' in self.gpu_name:
                os.remove(path_nvngx_sskjl)

                ## Backup EAC
                if os.path.exists(os.path.join(root_path_sskjl,'EasyAntiCheat')):
                    self.copy_progress(os.path.join(root_path_sskjl,'EasyAntiCheat'), os.path.join(root_path_sskjl, 'Backup EAC\\EasyAntiCheat'))
                    self.copy_progress(root_path_sskjl, 'start_protected_game.exe'), os.path.join(root_path_sskjl, 'Backup EAC')

            ## Disable EAC
            self.copy_progress(path_disable_eac, root_path_sskjl)
    
    # Returnal
    def install_returnal(self):
        root_path_returnal = os.path.abspath(os.path.join(self.dest_path, '..\\..\\..'))
        path_default_folder_dlss_returnal = os.path.join(root_path_returnal, 'Engine\\Binaries\\ThirdParty\\NVIDIA\\NGX\\Win64')
        path_nvapi_returnal = 'mods\\FSR3_Flight_Simulator24\\Amd'

        try:
            if os.path.exists(path_default_folder_dlss_returnal):
                
                if self.mod_selected == 'FSR4/DLSS FG (Only Optiscaler)':
                    self.copy_progress(os.path.join(path_default_folder_dlss_returnal, 'nvngx_dlss.dll'), os.path.join(self.dest_path, 'nvngx.dll'))

                if self.mod_selected == 'FSR4/DLSS FG (Only Optiscaler)' and messagebox.askyesno('Nvapi', 'Do you want to install nvapi.dll? Select "Yes" only if you are an AMD user and DLSS does not appear in the game after installing the mod.'):
                    self.copy_progress(path_nvapi_returnal, self.dest_path)

        except Exception as e:
            print(e)
    
    # Indiana Jones and the Great Circle  
    def install_indy(self):
        optiscaler_indy = 'mods\\FSR3_Indy\\Optiscaler Indy'
        fg_indy = 'mods\\FSR3_Indy\\FG\\Mod'
        config_file_path_indy = os.path.join(os.environ['USERPROFILE'], 'Saved Games\\MachineGames\\TheGreatCircle\\base')
        config_file_indy = 'mods\\FSR3_Indy\\FG\\Config File\\TheGreatCircleConfig.local'
        old_config_file_indy = os.path.join(config_file_path_indy,'TheGreatCircleConfig.local')
        
        if self.mod_selected == 'FSR4/DLSS FG (Only Optiscaler Indy)':
            self.copy_progress(optiscaler_indy, self.dest_path)

        if self.mod_selected == 'Indy FG (Only RTX)':
            self.copy_progress(fg_indy, self.dest_path)

            if os.path.exists(old_config_file_indy):
                os.rename(old_config_file_indy, os.path.join(config_file_path_indy,'TheGreatCircleConfig.txt'))
                self.copy_progress(config_file_indy, config_file_path_indy)
            else:
                self.copy_progress(config_file_indy, self.dest_path)
                messagebox.showinfo('Not Found','The file TheGreatCircleConfig.local was not found. Please check if it exists (C:\\Users\\YourName\\Saved Games\\MachineGames\\TheGreatCircle\\base). If it doesn\'t exist, open the game to have the file created. You can also manually copy the file to this path. The TheGreatCircleConfig.local file is in the folder selected in the Utility.')

    # A Quiet Place
    def install_quiet_place(self):
        optiscaler_quiet_place = 'mods\\Addons_mods\\OptiScaler'

        if self.mod_selected == 'FSR4/DLSS Quiet Place':
            self.copy_progress(optiscaler_quiet_place, self.dest_path)
            runReg('mods\\Temp\\enable signature override\\EnableSignatureOverride.reg')
    
    # Cyberpunk 2077
    async def install_cyberpunk_2077(self):
        path_rtx_dlss = "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal"
        cb2077_reg = "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal\\DisableNvidiaSignatureChecks.reg"
        
        if self.mod_selected == "RTX DLSS FG":
            await asyncio.to_thread(self.copy_progress(path_rtx_dlss, self.dest_path))
            await asyncio.to_thread(runReg(cb2077_reg))
    
    # The Callisto Protocol
    def install_callisto(self):
        tcp_callisto = 'mods\\FSR3_Callisto\\TCP'

        self.copy_progress(self.dest_path, tcp_callisto)
    
    # Baldur's Gate 3
    def install_baldurs_gate_3(self):
        base_bdg = "mods\\FSR3_BDG\\FSR_BDG"
        v2_bdg = "mods\\FSR3_BDG\\FSR3_BDG_2"
        v3_ini = "mods\\FSR3_BDG\\FSR3_BDG_3\\BG3Upscaler.ini"

        self.copy_progress(base_bdg, self.dest_path)

        if self.mod_selected == "Baldur's Gate 3 FSR3 V2":
            self.copy_progress(v2_bdg, self.dest_path)

        elif self.mod_selected == "Baldur's Gate 3 FSR3 V3":
            self.copy_progress(v2_bdg, self.dest_path)

            path_mods_bdg = os.path.join(self.dest_path, "mods")
            if os.path.exists(path_mods_bdg):
                self.copy_progress(v3_ini, path_mods_bdg)
    
    def install_addons(self, var_addons, dest_path, selected_addons):
        if not var_addons or not selected_addons:
            return

        for addon_name in selected_addons:
            config = addons_files.get(addon_name)

            if not config:
                messagebox.showerror("Error", f"Addon '{addon_name}' not found.")
                continue

            addon_path = config.get("addon_path")
            target = config.get("target")

            if not addon_path or not target:
                messagebox.showwarning("Error", f" Addon '{addon_name}' Missing path.")
                continue

            try:
                self.copy_progress(addon_path, dest_path)
                print(f"Addon '{addon_name}' installer sucessfully {dest_path}")

            except Exception as e:
                print("Error", f"Error installing the addon'{addon_name}': {e}")