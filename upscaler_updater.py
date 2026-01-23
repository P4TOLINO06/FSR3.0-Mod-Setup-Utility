import os
from helpers import copy_with_progress
from games_mods_config import addons_files

def update_upscalers(dest_path, copy_dlss = False, copy_dlss_4_5 = False ,copy_dlss_dlssd = False, copy_dlss_fsr4 = False, copy_dlss_fsr3 = False,copy_dlss_xess = False, copy_dlss_dlssg = False,dlssg_path = None, progress_callback = None):
    update_fsr3 = addons_files["FSR3"]["addon_path"]
    update_fsr4 = addons_files["FSR4"]["addon_path"]
    update_dlss = addons_files["DLSS"]["addon_path"]
    update_dlss_45 = addons_files["DLSS 4.5"]["addon_path"]
    update_dlssg = addons_files["DLSSG"]["addon_path"]
    update_xess = addons_files["XESS"]["addon_path"]
    update_dlssd = addons_files["DLSSD"]["addon_path"]

    try: 
        # DLSS
        if copy_dlss:
            copy_with_progress(update_dlss, dest_path, progress_callback, True)
        
        if copy_dlss_4_5:
             copy_with_progress(update_dlss_45, dest_path, progress_callback, True)

        # DLSSG
        if copy_dlss_dlssg:
            if dlssg_path and os.path.exists(os.path.dirname(dlssg_path)):
                copy_with_progress(update_dlssg, dlssg_path, progress_callback, True)
            else:
                copy_with_progress(update_dlssg, dest_path, progress_callback, True)

        # DLSSD
        if copy_dlss_dlssd:
            copy_with_progress(update_dlssd, dest_path, progress_callback, True)

        # XESS
        if copy_dlss_xess:
            copy_with_progress(update_xess, dest_path, progress_callback, True)

        # FSR
        if copy_dlss_fsr4:
            copy_with_progress(update_fsr4, dest_path, progress_callback, True)
        
        if copy_dlss_fsr3:
            copy_with_progress(update_fsr3, dest_path, progress_callback, True)

        if all([copy_dlss, copy_dlss_dlssg, copy_dlss_dlssd, copy_dlss_xess, copy_dlss_fsr4]):
            copy_with_progress(update_fsr4, dest_path, progress_callback, True)
            copy_with_progress(update_dlss, dest_path, progress_callback, True)
            copy_with_progress(update_dlssg, dest_path, progress_callback, True)
            copy_with_progress(update_xess, dest_path, progress_callback, True)
            copy_with_progress(update_dlssd, dest_path, progress_callback, True)

    except Exception as e:
        print(e)

def games_to_update_upscalers(dest_path,game_selected,progress_callback=None,copy_dlss=False, copy_dlss_45=False,copy_dlss_dlssg=False,copy_dlss_dlssd=False,copy_dlss_xess=False,copy_dlss_fsr4=False, copy_dlss_fsr3=False, absolute_path = False):
    if absolute_path:
        default_dlss_path = dest_path
        default_dlssg_path = dest_path
    else:
        default_dlss_path = os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Runtime\\Nvidia\\DLSS\\Binaries\\ThirdParty\\Win64'))
        default_dlssg_path = os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Runtime\\Nvidia\\Streamline\\Binaries\\ThirdParty\\Win64'))

    games_to_update_dlss = {
        'Sifu': dest_path,
        'Shadow of the Tomb Raider': dest_path,
        'The Last of Us Part I' : dest_path,
        'Steelrising' : dest_path,
        'Final Fantasy XVI' : dest_path,
        'Assetto Corsa Evo' : dest_path,
        'Watch Dogs Legion' : dest_path,
        'Alan Wake 2' : dest_path, 
        'GreedFall II: The Dying World' : dest_path,
        'GTA V' : dest_path,
        'Cities: Skylines 2' : dest_path,
        'Crysis Remastered': dest_path,
        'WILD HEARTS' : dest_path,
        'Six Days in Fallujah' : default_dlss_path,
        'FIST: Forged In Shadow Torch' : default_dlss_path,
        'Hogwarts Legacy' :  default_dlss_path,
        'Gotham Knights' :  default_dlss_path,
        'Way Of The Hunter' : default_dlss_path,
        'Evil West' : default_dlss_path,
        'The First Berserker: Khazan' : default_dlss_path,
        'Soulstice' : default_dlss_path,
        'Alone in the Dark' : default_dlss_path,
        'Choo-Choo Charles' : default_dlss_path,
        'Five Nights at Freddy’s: Security Breach' : default_dlss_path,
        'Kena: Bridge of Spirits' : default_dlss_path,
        'Deliver Us The Moon' : default_dlss_path,
        'Chernobylite' : default_dlss_path,
        'Chorus' : default_dlss_path,
        'The Outlast Trials' : default_dlss_path,
        'South Of Midnight' : default_dlss_path,
        'Elder Scrolls IV Oblivion Remaster': os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Marketplace\\nvidia\\DLSS\\DLSS\\Binaries\\ThirdParty')),
        'Clair Obscur Expedition 33' : os.path.abspath(os.path.join(dest_path, '..\\..', 'Plugins\\NVIDIA\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Brothers: A Tale of Two Sons Remake' : os.path.abspath(os.path.join(dest_path, '..\\..', 'Brothers\\Plugins\\NVIDIA\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Pacific Drive' : os.path.abspath(os.path.join(dest_path, '..\\..', 'Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Bright Memory' : os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Binaries\\ThirdParty\\NVIDIA\\NGX\\Win64')),
        'Fobia – St. Dinfna Hotel' : os.path.abspath(os.path.join(dest_path, '..\\..', 'Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Palworld' : os.path.abspath(os.path.join(dest_path, '..\\..', 'Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Kingdom Come: Deliverance II' : os.path.abspath(os.path.join(dest_path, '..' , 'Win64Shared')),
        'Lies of P' : os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Marketplace\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Final Fantasy VII Rebirth' : os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\DLSSSubset\\Binaries\\ThirdParty\\Win64')),
        'Back 4 Blood' : os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Binaries\\ThirdParty\\Nvidia\\NGX\\Win64')),
        'Alone in the Dark' : os.path.abspath(os.path.join(dest_path, '..\\..', 'Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Ghostrunner 2' : os.path.abspath(os.path.join(dest_path, '..\\..', 'Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Remnant II' : os.path.abspath(os.path.join(dest_path,'..\\..', 'Plugins\\Shared\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Mortal Shell': os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Binaries\\ThirdParty\\NVIDIA\\NGX\\Win64')),
        'Path of Exile II': os.path.join(dest_path, 'Streamline'),
        'GTA Trilogy' : os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Runtime\\Nvidia\\DLSS\\Binaries\\ThirdParty\\Win64'))
    }
    
    games_to_update_dlss_dlssg_dlssd = {
        'Black Myth: Wukong': (default_dlss_path, default_dlssg_path),
        'Indiana Jones and the Great Circle' : (os.path.join(dest_path, 'streamline'), os.path.join(dest_path, 'streamline'))
    }

    games_to_update_dlss_dlssg = {
        'A Plague Tale Requiem' : dest_path,
        'The Witcher 3' : dest_path,
        'Dying Light 2' : dest_path,
        'The Last of Us Part II' : dest_path,
        'Hellblade 2':  default_dlss_path,
        'Assassin\'s Creed Shadows' : os.path.join(dest_path, "NVStreamline\\production"),
        'Deliver Us Mars' : (default_dlss_path, default_dlssg_path),
        'STAR WARS Jedi: Survivor' : (default_dlss_path, default_dlssg_path),
        'Frostpunk 2' : (os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Elb\\DLSS\\Binaries\\ThirdParty\\Win64')), os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Elb\\Streamline\\Binaries\\ThirdParty\\Win64'))),
        'Stalker 2' : (os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Marketplace\\DLSS\\Binaries\\ThirdParty\\Win64')), os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\Marketplace\\Streamline\\Binaries\\ThirdParty\\Win64'))),
        'Chernobylite 2: Exclusion Zone' : (os.path.abspath(os.path.join(dest_path, '..\\..\\..', 'Engine\\Plugins\\NVIDIA\\DLSS\\Binaries\\ThirdParty\\Win64')), os.path.abspath(os.path.join(dest_path, '..\\..\\..','Engine\\Plugins\\NVIDIA\\Streamline\\Binaries\\ThirdParty\\Win64')))
    }

    games_to_update_all_upscalers = {
        'Marvel\'s Spider-Man Miles Morales': dest_path,
        'Marvel\'s Spider-Man Remastered': dest_path, 
        'Marvel\'s Spider-Man 2': dest_path,
        'God of War Ragnarök' : dest_path
    }
    games_to_update_fsr4_dlss = {
        'Control' : dest_path,
        'Horizon Zero Dawn/Remastered' : dest_path,
        'Hitman 3' : dest_path,
        'Like a Dragon: Pirate Yakuza in Hawaii' : dest_path
    }
    games_to_update_dlss_xess = {
        'Monster Hunter Wilds' : dest_path
    }
    	
    try:
        all_paths = {}
        all_paths.update(games_to_update_dlss)
        all_paths.update(games_to_update_dlss_dlssg)
        all_paths.update(games_to_update_dlss_dlssg_dlssd)
        all_paths.update(games_to_update_dlss_xess)
        all_paths.update(games_to_update_fsr4_dlss)
        all_paths.update(games_to_update_all_upscalers)

       # Absoluth path -> addons_path  (gui)
        if absolute_path:
            path_target = dest_path

        else:
            path_target = all_paths.get(game_selected)

            if isinstance(path_target, tuple):
                existing_paths = [
                    p for p in path_target
                    if isinstance(p, str) and os.path.exists(p)
                ]
                path_target = existing_paths[0] if existing_paths else dest_path # dest_path ->  same folder selected for mod installation (gui , Game folder)

            if not isinstance(path_target, str) or not os.path.exists(path_target):
                path_target = dest_path

        if not isinstance(path_target, str) or not os.path.exists(path_target):
            print(" No valid path found. (upscalers)")
            return
                        
        update_upscalers(
            path_target,
            copy_dlss=copy_dlss,
            copy_dlss_4_5=copy_dlss_45,
            copy_dlss_dlssg=copy_dlss_dlssg,
            copy_dlss_dlssd=copy_dlss_dlssd,
            copy_dlss_xess=copy_dlss_xess,
            copy_dlss_fsr3=copy_dlss_fsr3,
            copy_dlss_fsr4=copy_dlss_fsr4,
            progress_callback=progress_callback,
        )
    except Exception as e:
        print(f"[ERROR] update upscalers: {e}")