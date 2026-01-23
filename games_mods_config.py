game_config = ['Achilles Legends Untold','Alan Wake 2','Alan Wake Remastered','Alone in the Dark','A Plague Tale Requiem', 'A Quiet Place: The Road Ahead','Assassin\'s Creed Mirage','Assassin\'s Creed Shadows','Assassin\'s Creed Valhalla','Assetto Corsa Evo','Atomic Heart','AVOWED','Back 4 Blood','Baldur\'s Gate 3','Banishers: Ghosts of New Eden','Black Myth: Wukong','Blacktail','Bright Memory','Bright Memory: Infinite','Brothers a Tale of Two Sons','Brothers: A Tale of Two Sons Remake','Chernobylite','Chernobylite 2: Exclusion Zone','Choo-Choo Charles','Chorus','Cities: Skylines 2','COD MW3','Control','Clair Obscur Expedition 33','Crime Boss Rockay City', 'Crysis Remastered','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Dead Rising Remaster','Deathloop','Death Stranding Director\'s Cut','Dead Space (2023)','Dragon Age: Veilguard','Dragons Dogma 2','Deliver Us Mars','Deliver Us The Moon','Dying Light 2','Dynasty Warriors: Origins','Elden Ring', 'Elden Ring Nightreign','Elder Scrolls IV Oblivion Remaster','Empire of the Ants','Everspace 2','Eternal Strands','Evil West','F1 2022','F1 2023','Final Fantasy VII Rebirth','Final Fantasy XVI','FIST: Forged In Shadow Torch','Five Nights at Freddy’s: Security Breach','Flintlock: The Siege of Dawn','Fobia – St. Dinfna Hotel','Fort Solis',
        'Forza Horizon 5','Frostpunk 2','Ghost of Tsushima','Ghostrunner 2','Ghostwire: Tokyo','God Of War 4','God of War Ragnarök','Gotham Knights','GreedFall II: The Dying World','GTA Trilogy','GTA V','Hellblade: Senua\'s Sacrifice','Hellblade 2','High On Life','Hitman 3','Hogwarts Legacy','Horizon Zero Dawn/Remastered','Horizon Forbidden West','Hot Wheels Unleashed','Icarus','Indiana Jones and the Great Circle','Judgment','Jusant','Kingdom Come: Deliverance II','Kena: Bridge of Spirits','Layers of Fear','Lego Horizon Adventures','Lies of P','Like a Dragon: Pirate Yakuza in Hawaii','Lords of the Fallen','Loopmancer','Lost Records Bloom And Rage','Manor Lords','Martha Is Dead','Marvel\'s Avengers','Marvel\'s Guardians of the Galaxy','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man 2','Marvel\'s Spider-Man Miles Morales','Marvel\'s Midnight Suns','Metro Exodus Enhanced Edition','Microsoft Flight Simulator 2024','Monster Hunter Rise','Monster Hunter Wilds','Mortal Shell','MOTO GP 24','Nightingale','Ninja Gaiden 2 Black','Nobody Wants To Die','Orcs Must Die! Deathtrap','Outpost: Infinity Siege','Pacific Drive','Palworld','Path of Exile II','Ratchet & Clank - Rift Apart',
        'Red Dead Redemption','Red Dead Redemption 2','Ready or Not','Remnant II','Resident Evil 4 Remake','Returnal','Rise of The Tomb Raider','Ripout','RoboCop: Rogue City','Saints Row','Satisfactory','Sackboy: A Big Adventure','Scorn','Sengoku Dynasty','Shadow Warrior 3','Shadow of the Tomb Raider','Sifu','Silent Hill 2','Smalland','Soulslinger Envoy of Death','Soulstice','South Of Midnight','S.T.A.L.K.E.R. 2','Starfield','STAR WARS Jedi: Survivor','Star Wars Outlaws','Steelrising','Suicide Squad: Kill the Justice League','Tainted Grail Fall of Avalon','The Alters','TEKKEN 8','Test Drive Ultimate Solar Crown','The Ascent','The Callisto Protocol','The Casting Of Frank Stone','The Chant','The First Berserker: Khazan','The Invincible','The Last of Us Part I','The Last of Us Part II','The Medium','The Outer Worlds: Spacer\'s Choice Edition','The Outlast Trials','The Talos Principle 2','The Thaumaturge','Thymesia','The Witcher 3','Uncharted Legacy of Thieves Collection','Unknown 9: Awakening','Until Dawn','Wanted: Dead','Warhammer: Space Marine 2', 'Watch Dogs Legion', 'Way Of The Hunter','Wayfinder','WILD HEARTS']

fsr_31_dlss_mods = [
    'FSR4/DLSS FG (Only Optiscaler)',
    'FSR4/DLSSG FG (Only Optiscaler)'
]

addons_files = {
    "XESS" : {
        "target": ["libxess.dll", "libxess_fg.dll", "libxell.dll", "libxess_dx11.dll"],
        "addon_path": [
            r"mods\Temp\Upscalers\Intel\libxess.dll",
            r"mods\Temp\Upscalers\Intel\libxess_fg.dll",
            r"mods\Temp\Upscalers\Intel\libxell.dll",
            r"mods\Temp\Upscalers\Intel\libxess_dx11.dll"
        ]

    },
    "DLSS":{
        "target": "nvngx_dlss.dll",
        "addon_path": r"mods\Temp\Upscalers\Nvidia\\Dlss\nvngx_dlss.dll"
    },
    "DLSS 4.5":{
        "target": "nvngx_dlss.dll",
        "addon_path": r"mods\Temp\Upscalers\Nvidia\\Dlss 4.5\nvngx_dlss.dll"
    },
    "DLSSD":{
        "target": "nvngx_dlssd.dll",
        "addon_path": r"mods\Temp\Upscalers\Nvidia\\Dlssd\nvngx_dlssd.dll"
    },
    "DLSSG":{
        "target": "nvngx_dlssg.dll",
        "addon_path": r"mods\Temp\Upscalers\Nvidia\\Dlssg\nvngx_dlssg.dll"
    },
    "FSR4":{
        "target": ["amd_fidelityfx_framegeneration_dx12.dll", "amd_fidelityfx_upscaler_dx12.dll", "amd_fidelityfx_vk.dll", "amd_fidelityfx_dx12.dll"],
        "addon_path": [
            r"mods\Temp\Upscalers\\AMD\FSR4\amd_fidelityfx_framegeneration_dx12.dll",
            r"mods\Temp\Upscalers\\AMD\FSR4\amd_fidelityfx_upscaler_dx12.dll",
            r"mods\Temp\Upscalers\\AMD\FSR4\amd_fidelityfx_vk.dll",
            r"mods\Temp\Upscalers\\AMD\FSR4\amd_fidelityfx_dx12.dll",
        ]
    },
    "FSR3":{
        "target": ["amd_fidelityfx_vk.dll", "amd_fidelityfx_dx12.dll"],
        "addon_path":[
            r"mods\Temp\Upscalers\AMD\FSR3\amd_fidelityfx_vk.dll",
            r"mods\Temp\Upscalers\AMD\FSR3\amd_fidelityfx_dx12.dll"
        ]
    }
}

addons_presets = {
"DLSS": [
    "Sifu", "Shadow of the Tomb Raider", "The Last of Us Part I", "Steelrising", "Final Fantasy XVI",
    "Assetto Corsa Evo", "Watch Dogs Legion", "Alan Wake 2", "GreedFall II: The Dying World", "GTA V",
    "Cities: Skylines 2", "Crysis Remastered", "WILD HEARTS", "Six Days in Fallujah",
    "FIST: Forged In Shadow Torch", "Hogwarts Legacy", "Gotham Knights", "Way Of The Hunter", "Path of Exile II"
    "Evil West", "The First Berserker: Khazan", "Soulstice", "GTA Trilogy", "Atomic Heart", "Choo-Choo Charles",
    "Five Nights at Freddy’s: Security Breach", "Kena: Bridge of Spirits", "Deliver Us The Moon", "Chernobylite", "Chorus",
    "The Outlast Trials", "South Of Midnight", "Elder Scrolls IV Oblivion Remaster", "Clair Obscur Expedition 33", "Brothers: A Tale of Two Sons Remake",
    "Pacific Drive", "Bright Memory", "Fobia – St. Dinfna Hotel", "Palworld", "Kingdom Come: Deliverance II",
    "Lies of P", "Final Fantasy VII Rebirth", "Back 4 Blood", "Alone in the Dark", "Ghostrunner 2",
    "Remnant II", "Mortal Shell"
],

"DLSS_DLSSG":[
    "A Plague Tale Requiem", "The Witcher 3", "Dying Light 2", "The Last of Us Part II", "Assassin\'s Creed Shadows",
    "Deliver Us Mars", "STAR WARS Jedi: Survivor", "Frostpunk 2", "Lost Records Bloom And Rage", "Stalker 2",
    "Chernobylite 2: Exclusion Zone", "Hellblade 2"
],

"DLSS_DLSSG_DLSSD":[
    "Black Myth: Wukong", "Indiana Jones and the Great Circle"
],

"DLSS_FSR4": [
    "Control", "Horizon Zero Dawn/Remastered", "Hitman 3", "Like a Dragon: Pirate Yakuza in Hawaii"
],

"DLSS_XESS":[
    "Monster Hunter Wilds"
],

"DLSS_DLSSG_DLSSD_FSR_XESS": ["Marvel\'s Spider-Man Miles Morales", "Marvel\'s Spider-Man Remastered", "Marvel\'s Spider-Man 2", "God of War Ragnarök"]
}

game_mods_config = {
        'A Plague Tale Requiem': [*fsr_31_dlss_mods],
        'A Quiet Place: The Road Ahead': [*fsr_31_dlss_mods],
        'Alan Wake 2': ['Alan Wake 2 FG RTX', *fsr_31_dlss_mods],
        'Alan Wake Remastered': [*fsr_31_dlss_mods],
        'Alone in the Dark' : [*fsr_31_dlss_mods],
        'Assassin\'s Creed Mirage': [*fsr_31_dlss_mods],
        'Assassin\'s Creed Shadows' : [*fsr_31_dlss_mods],
        'Assassin\'s Creed Valhalla': ['Ac Valhalla DLSS3 (Only RTX)', 'Ac Valhalla FSR3 All GPU'],
        'Assetto Corsa EVO': [*fsr_31_dlss_mods],
        'Atomic Heart' : [*fsr_31_dlss_mods],
        'Back 4 Blood' : [*fsr_31_dlss_mods],
        'Baldur\'s Gate 3': ['Baldur\'s Gate 3 FSR3', 'Baldur\'s Gate 3 FSR3 V2', 'Baldur\'s Gate 3 FSR3 V3'],
        'Black Myth: Wukong': [*fsr_31_dlss_mods],
        'Bright Memory' : [*fsr_31_dlss_mods],
        'Brothers: A Tale of Two Sons Remake' : [*fsr_31_dlss_mods ],
        'Cities: Skylines 2' : [*fsr_31_dlss_mods],
        'Chernobylite' : [*fsr_31_dlss_mods ],
        'Chernobylite 2: Exclusion Zone' : [*fsr_31_dlss_mods],
        'Choo-Choo Charles' : [*fsr_31_dlss_mods],
        'Chorus' : [*fsr_31_dlss_mods],
        'Clair Obscur Expedition 33' : [*fsr_31_dlss_mods],
        'Crysis Remastered' : [*fsr_31_dlss_mods],
        'Lost Records Bloom And Rage' : [*fsr_31_dlss_mods],
        'COD MW3': ['COD MW3 FSR3'],
        'Control': [*fsr_31_dlss_mods],
        'Cyberpunk 2077': [*fsr_31_dlss_mods,'RTX DLSS FG'],
        'Dead Rising Remaster': ['Dinput8 DRR','DDR FG'],
        'Dragon Age: Veilguard' : ['FSR4/DLSS DG Veil',*fsr_31_dlss_mods],
        'Dragons Dogma 2': ['Dinput8 DD2', 'DD2 FG'],
        'Deliver Us Mars' : [*fsr_31_dlss_mods],
        'Deliver Us The Moon' : [*fsr_31_dlss_mods],
        'Dying Light 2': [*fsr_31_dlss_mods],
        'Elden Ring': ['Disable_Anti-Cheat', 'Elden_Ring_FSR3', 'Elden_Ring_FSR3 V2', 'FSR4/DLSS FG Custom Elden', 'Unlock FPS Elden'],
        'Elden Ring Nightreign': ['FSR4/DLSS Nightreign RTX'],
        'Elder Scrolls IV Oblivion Remaster': [*fsr_31_dlss_mods],
        'Evil West': [*fsr_31_dlss_mods],
        'Final Fantasy VII Rebirth': [*fsr_31_dlss_mods],
        'Final Fantasy XVI': ['FFXVI DLSS RTX',*fsr_31_dlss_mods],
        'Flintlock: The Siege of Dawn': [*fsr_31_dlss_mods],
        'FIST: Forged In Shadow Torch': [*fsr_31_dlss_mods],
        'Five Nights at Freddy’s: Security Breach' : [*fsr_31_dlss_mods],
        'Fobia – St. Dinfna Hotel': [*fsr_31_dlss_mods],
        'Forza Horizon 5': ['Forza Horizon 5 FSR3'],
        'Frostpunk 2': [*fsr_31_dlss_mods],
        'Ghost of Tsushima': ['Ghost of Tsushima FG DLSS', *fsr_31_dlss_mods],
        'Ghostrunner 2' : [*fsr_31_dlss_mods],
        'Gotham Knights': [*fsr_31_dlss_mods],
        'GreedFall II: The Dying World' : [*fsr_31_dlss_mods],
        'GTA Trilogy' : [*fsr_31_dlss_mods],
        'GTA V': ['FSR4/DLSS FG (Only Optiscaler)'],
        'God Of War 4': ['FSR4/DLSS Gow4'],
        'God of War Ragnarök': [*fsr_31_dlss_mods ],
        'Hellblade 2': ['Others Mods HB2', 'Hellblade 2 FSR3 (Only RTX)', *fsr_31_dlss_mods],
        'Hitman 3' : [*fsr_31_dlss_mods ],
        'Hogwarts Legacy': [*fsr_31_dlss_mods],
        'Horizon Forbidden West': [*fsr_31_dlss_mods],
        'Horizon Zero Dawn/Remastered': [*fsr_31_dlss_mods],
        'Icarus': [*fsr_31_dlss_mods, 'Icarus DLSSG RTX', 'Icarus FSR3 AMD/GTX'],
        'Indiana Jones and the Great Circle' : ['FSR4/DLSS FG (Only Optiscaler Indy)','Indy FG (Only RTX)'],
        'Kingdom Come: Deliverance II' : [*fsr_31_dlss_mods],
        'Kena: Bridge of Spirits': [*fsr_31_dlss_mods],
        'Lego Horizon Adventures': [*fsr_31_dlss_mods],
        'Lies of P': [*fsr_31_dlss_mods],
        'Like a Dragon: Pirate Yakuza in Hawaii': ['DLSSG Yakuza', *fsr_31_dlss_mods],
        'Lords of the Fallen': ['DLSS FG LOTF2 (RTX)'],
        'Marvel\'s Spider-Man Miles Morales': [*fsr_31_dlss_mods],
        'Marvel\'s Spider-Man Remastered': [*fsr_31_dlss_mods],
        'Marvel\'s Spider-Man 2': [*fsr_31_dlss_mods],
        'Marvel\'s Midnight Suns' : [*fsr_31_dlss_mods],
        'Metro Exodus Enhanced Edition': [*fsr_31_dlss_mods],
        'Microsoft Flight Simulator 2024': ['FSR 3.1 Custom MSFS', *fsr_31_dlss_mods],
        'Monster Hunter Wilds' : [*fsr_31_dlss_mods, 'DLSSG Wilds (Only RTX)'],
        'Mortal Shell': [*fsr_31_dlss_mods],
        'Pacific Drive' : [*fsr_31_dlss_mods],
        'Palworld': [*fsr_31_dlss_mods,'Palworld Build03'],
        'Path of Exile II': [*fsr_31_dlss_mods],
        'Red Dead Redemption' : [*fsr_31_dlss_mods],
        'Red Dead Redemption 2': ['FSR4/DLSS FG (Only Optiscaler RDR2)', 'RDR2 Mix', 'RDR2 FG Custom', *fsr_31_dlss_mods],
        'Resident Evil 4 Remake': ['FSR4/DLSS RE4'],
        'Returnal': [*fsr_31_dlss_mods],
        'Saints Row': [*fsr_31_dlss_mods],
        'Satisfactory': [*fsr_31_dlss_mods],
        'Soulstice': [*fsr_31_dlss_mods],
        'South Of Midnight' : [*fsr_31_dlss_mods],
        'Shadow of the Tomb Raider' : [*fsr_31_dlss_mods],
        'Sifu': [*fsr_31_dlss_mods],
        'Silent Hill 2': [*fsr_31_dlss_mods, 'DLSS FG RTX'],
        'Six Days in Fallujah' : [*fsr_31_dlss_mods],
        'STAR WARS Jedi: Survivor': [*fsr_31_dlss_mods],
        'Star Wars Outlaws': ['Outlaws DLSS RTX', *fsr_31_dlss_mods],
        'S.T.A.L.K.E.R. 2': [*fsr_31_dlss_mods, 'DLSS FG (Only RTX)'],
        'Steelrising' : [*fsr_31_dlss_mods],
        'Suicide Squad: Kill the Justice League' : [*fsr_31_dlss_mods],
        'Tainted Grail Fall of Avalon': [*fsr_31_dlss_mods],
        'TEKKEN 8': ['Unlock Fps Tekken 8'],
        'The Alters': [*fsr_31_dlss_mods],
        'The Callisto Protocol': ['FSR4/DLSS FG (Only Optiscaler)'],
        'The Casting Of Frank Stone': [*fsr_31_dlss_mods],
        'The First Berserker: Khazan' : [*fsr_31_dlss_mods],
        'The Last of Us Part I': [*fsr_31_dlss_mods],
        'The Last of Us Part II': [*fsr_31_dlss_mods],
        'The Outlast Trials':[*fsr_31_dlss_mods],
        'The Witcher 3': [*fsr_31_dlss_mods],
        'Until Dawn': [*fsr_31_dlss_mods],
        'Warhammer: Space Marine 2': [*fsr_31_dlss_mods],
        'Watch Dogs Legion': [*fsr_31_dlss_mods],
        'Way Of The Hunter' : [*fsr_31_dlss_mods],
        'WILD HEARTS' : [*fsr_31_dlss_mods ],
    }