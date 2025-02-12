import tkinter as tk
from tkinter import ttk
import asyncio
from PIL import ImageTk, Image
from customtkinter import *
from tkinter import Canvas,filedialog,messagebox
import subprocess,os,shutil
import toml
import sys
import ctypes
from tkinter import font as tkFont
from configobj import ConfigObj
import json
import win32com.client
import psutil
import subprocess

def uac():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except Exception:
        return False

unlock_screen = True

def run_as_admin():
    global unlock_screen
    if uac():
        unlock_screen = True
    else:
        unlock_screen = False
        try:
            ctypes.windll.shell32.ShellExecuteW(
                None,
                "runas",
                sys.executable,
                f'"{os.path.abspath(__file__)}"',
                None,
                1
            )
            sys.exit(0)
        except Exception as e:
            sys.exit(1)

run_as_admin()

screen = tk.Tk()
screen.title("FSR3.0 Mod Setup Utility - 3.2.6v")
screen.geometry("700x580")
screen.resizable(0,0)
screen.configure(bg='black')
def exit_screen(event=None):
    sys.exit()
screen.protocol('WM_DELETE_WINDOW',exit_screen)

icon_image = tk.PhotoImage(file="images\\Hat.gif")
screen.iconphoto(True, icon_image)

change_text = False
try:
    font_select = ("Segoe UI", 11,'bold')

    var_font = tk.Label(screen,text=".", font=font_select,fg="black", bg="black")
except tk.TclError:
    font_select = tkFont.Font(family="Arial",size=10)
    change_text = True

title_page = tk.Label(screen, text="FSR3/DLSS FG Mods", font=("Arial", 11, "bold"), fg="#778899", bg="black") 
title_page.pack(anchor='w',pady=0)

select_label = tk.Label(screen, text="Game select:",font=font_select,bg='black',fg='#C0C0C0')
select_label.place(x=0,y=33)

fsr_label = tk.Label(screen,text='FSR:',font=font_select,bg='black',fg='#C0C0C0')
fsr_label.place(x=313,y=33)
game_options_canvas = Canvas(screen,width=200,height=15,bg='white')
game_options_canvas.place(x=101,y=37)

exit_label = tk.Label(screen,text='Exit',font=font_select,bg='black',fg='#E6E6FA')
exit_label.place(x=355,y=506)

install_label = tk.Label(screen,text='Install',font=font_select,bg='black',fg='#E6E6FA')
install_label.place(x=295,y=506)

def search_un():
    local_disk_names = []

    for partition in psutil.disk_partitions(all=False):
        if 'cdrom' not in partition.opts and partition.fstype != '':
            local_disk_names.append(partition.device)

    return local_disk_names

path_over = None

def epic_dis_over(event=None):
    global path_over
    user_disk_part = search_un()
    exe_name = "EOSOverlayRenderer-Win64-Shipping.exe"
    txt_name = 'EOSOverlayRenderer-Win64.txt'
    
    for disk_name in user_disk_part:
        default_path = os.path.join(disk_name, r'Program Files (x86)\\Epic Games\\Launcher\\Portal\\Extras\\Overlay')
        if os.path.exists(default_path):
            for root, dirs, files in os.walk(default_path):
                if exe_name in files or txt_name in files:
                    path_over = os.path.join(root)
                    break
            if path_over:
                break
        
        alt_path = os.path.join(disk_name, r'Epic Games\\Launcher\\Portal\\Extras\\Overlay')
        if os.path.exists(alt_path):
            for root, dirs, files in os.walk(alt_path):
                if exe_name in files or txt_name in files:
                    path_over = os.path.join(root)
                    break
            if path_over:
                break
        
    if path_over is not None:
        epic_over_canvas.delete('text')
        epic_over_canvas.create_text(2, 8, anchor='w', text=path_over, fill='black', tags='text')
    else:
        messagebox.showinfo('Not Found', 'EOSOverlayRenderer-Win64-Shipping not found, please select the path manually')
        
epic_folder = None
def epic_explorer(event=None): 
    global epic_folder,path_over
    epic_folder = filedialog.askdirectory()
    path_over = epic_folder
    epic_over_canvas.delete('text')
    epic_over_canvas.create_text(2,8, anchor='w',text=epic_folder,fill='black',tags='text') 

def enable_epic_over(event=None):
    global path_over
    name_exe = 'EOSOverlayRenderer-Win64.txt'
    name_32_exe = 'EOSOverlayRenderer-Win32.txt'
    rename_exe = 'EOSOverlayRenderer-Win64-Shipping.exe'
    rename_32_exe = 'EOSOverlayRenderer-Win32-Shipping.exe'
    
    if path_over is None:
        messagebox.showinfo('Error','Please select a folder or perform an automatic search.')
        return
        
    file_to_rename = os.path.join(path_over, name_exe)
    file_to_32_rename = os.path.join(path_over,name_32_exe)
    renamed_file = os.path.join(path_over, rename_exe)
    
    if os.path.exists(renamed_file):
        messagebox.showinfo('Enabled', 'Overlay is already enabled.')
        return
    
    elif not os.path.exists(file_to_rename):
        messagebox.showinfo('Enabled', 'EOSOverlayRenderer-Win64-Shipping not found')
        return
 
    try:
        os.rename(file_to_rename, os.path.join(path_over, rename_exe))
        os.rename(file_to_32_rename, os.path.join(path_over, rename_32_exe))
        messagebox.showinfo('Sucess','Overlay enabled successfully.')
        if epic_over_canvas is None:
            pass
    except Exception:
        messagebox.showinfo('Error','Error enabling Overlay')

def disable_epic_over(event=None):
    global path_over
    name_exe = 'EOSOverlayRenderer-Win64-Shipping.exe'
    name_32_exe = 'EOSOverlayRenderer-Win32-Shipping.exe'
    rename_exe = 'EOSOverlayRenderer-Win64.txt'
    rename_32_exe = 'EOSOverlayRenderer-Win32.txt'
    
    if path_over is None:
        messagebox.showinfo('Error','Please select a folder or perform an automatic search.')
        return
    
    file_to_rename = os.path.join(path_over, name_exe)
    file_to_32_rename = os.path.join(path_over,name_32_exe)
    renamed_file = os.path.join(path_over, rename_exe)
    
    if os.path.exists(renamed_file):
        messagebox.showinfo('Disabled', 'Overlay is already disabled.')
        return
    
    elif not os.path.exists(file_to_rename):
        messagebox.showinfo('Disabled', 'EOSOverlayRenderer-Win64 not found')
        return
 
    if os.path.exists(file_to_rename):
        try:
            os.rename(file_to_rename, os.path.join(path_over, rename_exe))
            os.rename(file_to_32_rename, os.path.join(path_over, rename_32_exe))
            messagebox.showinfo('Sucess','Overlay disabled successfully..')
        except Exception as e:
            messagebox.showinfo('Error','Error disabling overlay')
         
def guide_epic(event=None):
    epic_label_guide.config(text='Enable or disable the Epic Games Overlay, the Overlay along with the FSR3 mod can cause bugs and crashes in some games')
    epic_label_guide.place(x=0,y=470)
    epic_label_guide.lift()

def close_guide_epic(event=None):
    epic_label_guide.place_forget()

epic_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
epic_label_guide.place_forget()

epic_over_label = tk.Label(screen,text='Epic Games Overlay:',font=font_select,bg='black',fg='#C0C0C0')
epic_over_label.place(x=0,y=446)

epic_over_canvas = tk.Canvas(screen,width=162,height=19,bg='white',highlightthickness=0)
epic_over_canvas.place(x=152,y=451)

epic_over_browser_canvas = tk.Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
epic_over_browser_canvas.create_text(0,8,anchor='w',font=(font_select,9,'bold'),text='Browser',fill='black')
epic_over_browser_canvas.place(x=340,y=451)

epic_over_marc_label = tk.Label(screen,text='–',font=font_select,bg='black',fg='#C0C0C0')
epic_over_marc_label.place(x=319,y=446)

epic_over_disable_label = tk.Label(screen,text='Disable',font=font_select,bg='black',fg='#E6E6FA')
epic_over_disable_label.place(x=330,y=476)

epic_over_enable_label = tk.Label(screen,text='Enable',font=font_select,bg='black',fg='#E6E6FA')
epic_over_enable_label.place(x=270,y=476)

epic_over_auto_label = tk.Label(screen,text='Auto Search',font=font_select,bg='black',fg='#E6E6FA')
epic_over_auto_label.place(x=175,y=476)

fsr_guide_cbox = None
screen_guide = None
fsr_guide_var = None
guide_label = None
def fsr_guide(event=None):
    global fsr_guide_cbox,screen_guide,fsr_guide_var
    
    if fsr_guide_var.get() == 1:
        if screen_guide is None:
            screen_guide = tk.Toplevel()
            screen_guide.title('FSR GUIDE')
            screen_guide.geometry('520x260')
            screen_guide.configure(bg='black')
            screen_guide.resizable(0,0)
            screen_guide.protocol('WM_DELETE_WINDOW', exit_fsr_guide)
            select_guide()
        else:
            screen_guide.deiconify() 
    else:
        if screen_guide is not None:
            screen_guide.withdraw()

fsr_guide_label = tk.Label(screen,text='FSR GUIDE',font=font_select,bg='black',fg='#C0C0C0')
fsr_guide_label.place(x=200,y=356)
fsr_guide_var = tk.IntVar()
fsr_guide_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=fsr_guide_var,command=fsr_guide)
fsr_guide_cbox.place(x=282,y=358)

def select_guide():
    global select_game_listbox,select_game_canvas,s_games_op,select_game_label
    
    select_game_label = tk.Label(screen_guide,text='Select a guide',font=font_select,bg='black',fg='#C0C0C0')
    select_game_label.place(x=30,y=0)
    
    select_game_canvas = tk.Canvas(screen_guide,width=162,height=19,bg='white',highlightthickness=0)
    select_game_canvas.place(x=0,y=30)
   
    select_game_listbox = tk.Listbox(screen_guide,width=25,height=10,bg='white',highlightthickness=0)
    select_game_listbox.place(x=0,y=50)
    select_game_listbox.place_forget()
    
    scroll_s_games_listbox = tk.Scrollbar(select_game_listbox,orient=tk.VERTICAL,command=select_game_listbox.yview)
    scroll_s_games_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(144,0),pady=(6,26))
    select_game_listbox.config(yscrollcommand=scroll_s_games_listbox.set)
    scroll_s_games_listbox.config(command=select_game_listbox.yview)
    
    s_games_op = ['Initial Information','Optiscaler FSR 3.1.3/DLSS (Only Optiscaler)','Add-on Mods','Optiscaler Method','Achilles Legends Untold','Alan Wake 2','Alan Wake Remastered','Alone in the Dark','A Plague Tale Requiem', 'A Quiet Place: The Road Ahead','Assassin\'s Creed Mirage','Assassin\'s Creed Valhalla','Assetto Corsa EVO','Atomic Heart','Baldur\'s Gate 3','Black Myth: Wukong','Blacktail','Banishers Ghost of New Eden','Bright Memory: Infinite','Brothers a Tale of Two Sons','Chernobylite','Cod Black Ops Cold War','Cod MW3','Control','Crime Boss Rockay City', 'Crysis 3 Remastered','Cyberpunk 2077',
                'Dakar Desert Rally','Dead Space Remake','Dead Island 2', 'Dead Rising Remaster','Death Stranding Director\'s Cut','Deathloop','Dragon Age: Veilguard','Dragons Dogma 2','Dying Light 2','Dynasty Warriors: Origins','Elden Ring','Empire of the Ants','Eternal Strands','Everspace 2','Evil West','Fallout 4','Final Fantasy VII Rebirth','Final Fantasy XVI','Fist Forged in Shadow Torch','Flintlock: The Siege of Dawn','Fort Solis','Forza Horizon 5','F1 2022','F1 2023','Gotham Knights','GTA Trilogy','GTA V','Ghost of Tsushima','Ghostrunner 2','Ghostwire: Tokyo','God Of War 4','God of War Ragnarök','Hellblade: Senua\'s Sacrifice','Hellblade 2','High On Life','Hitman 3','Hogwarts legacy','Horizon Forbidden West','Horizon Zero Dawn/Remastered','Hot Wheels Unleashed','Icarus','Indiana Jones and the Great Circle','Judgment','Jusant',
                'Kingdom Come: Deliverance II','Kena: Bridge of Spirits','Layers of Fear','Lego Horizon Adventures','Lies of P','Loopmancer','Lords of the Fallen','Manor Lords','Martha Is Dead','Marvel\'s Avengers','Marvel\'s Guardians of the Galaxy','Marvel\'s Midnight Suns','Metro Exodus Enhanced','Microsoft Flight Simulator 2024','Monster Hunter Rise','Mortal Shell','Ninja Gaiden 2 Black','Nobody Wants To Die','Orcs Must Die! Deathtrap','Outpost Infinity Siege','Pacific Drive','Palworld','Path of Exile II','Ratchet and Clank','Remanant II','Rise of The Tomb Raider','Ready or Not','Red Dead Redemption','Red Dead Redemption 2','Resident Evil 4 Remake','Returnal','Ripout','Saints Row','Sackboy: A Big Adventure','Scorn','Sengoku Dynasty','Shadow of the Tomb Raider','Shadow Warrior 3','Silent Hill 2','Sifu','Six Days in Fallujah',
                'Smalland','Soulstice','Spider Man/2/Miles','S.T.A.L.K.E.R. 2','Star Wars: Jedi Survivor','Star Wars Outlaws','Steelrising','Suicide Squad: Kill the Justice League','TEKKEN 8','Test Drive Ultimate Solar Crown','The Ascent','The Callisto Protocol','The Casting Of Frank Stone','The Chant','The First Berserker: Khazan','The Invicible','The Last Of Us','The Medium',"The Outer Worlds: Spacer's Choice Edition",'The Talos Principle 2','The Thaumaturge','Thymesia','The Witcher 3','Uncharted','Unknown 9: Awakening','Until Dawn','Wanted Dead','Warhammer: Space Marine 2','Watch Dogs Legion','Way Of The Hunter','Wayfinder','Uniscaler','XESS/DLSS']
    
    for select_games_op in s_games_op:  
        select_game_listbox.insert(tk.END,select_games_op)
    
    select_game_listbox.bind('<<ListboxSelect>>',update_select_game)
    select_game_canvas.bind('<Button-1>',view_listbox_s_games)
    
    select_game_canvas.update()

s_games_listbox_view = False
def view_listbox_s_games(evnet=None):
    global s_games_listbox_view
    
    if s_games_listbox_view:
        select_game_listbox.place_forget()
        s_games_listbox_view = False
    else:
        select_game_listbox.place(x=0,y=50)
        s_games_listbox_view = True
        
def update_select_game(event=None):
    global select_game_canvas,select_game
    
    select_game = None
    index_select_game = select_game_listbox.curselection()
    if index_select_game:
        select_game = select_game_listbox.get(index_select_game)
        select_game_canvas.delete('text')
        select_game_canvas.create_text(2,8,anchor='w',text=select_game,fill='black',tags='text')
    text_guide()
 
def text_guide():
    global select_game, s_games_op,screen_guide,guide_label

    list_game = {
'Initial Information':(
'1 - When selecting the game folder, look for the game\'s .exe file. Some games have the full name .exe or abbreviated,\n while others have the .exe file in the game folder but within subfolders with the ending\nBinaries\\Win64, and the .exe usually ends with Win64-Shipping, for example: TheCallistoProtocol-Win64-Shipping.\n'
'2 - It is recommended to read the guide before installing the mod. Some games do not have a guide because\nyou only need to install the mod, while others, like Fallout 4 for example, have extra steps for installation.\nIf something is done incorrectly, the mod will not work.\n'
'3 - Some games may not work for certain users after installing the mod. It is recommended to select Default\nin NVGX and enable Signature Override if the mod does not work with the default files.\n'    
'4 - Games that don\'t have numbers in \'Fsr\' you don\'t need to check any option, just install the mod.'
),

'Add-on Mods':(
'OptiScaler \n'
'Is drop-in DLSS2 to XeSS/FSR2 replacement for games.\n'
'OptiScaler implements all necessary API methods of DLSS2\n& NVAPI to act as a man in the middle. So from games\nperspective it\'s using DLSS2 but actually using OptiScaler\nand calls are interpreted/redirected to XeSS & FSR2.\n\n'  
'Force add INVERTED_DEPTH: Force add INVERTED_DEPTH to\ninit flags.\n'
'CAS sharpening for XeSS: Enables CAS sharpening for XeSS.\n'
'Force ENABLE_AUTOEXPOSURE: Force add ENABLE_AUTOEXPOSURE\nto init flags.\n'
'Force HDR_INPUT_COLOR: Force add HDR_INPUT_COLOR to init flags.\n'
'Enable Output Scaling: Enable output scaling option for Dx12 and Dx11\nwith Dx12 backends.\n'
'Hook SLProxy: If sl.interposer is in memory use it\'s implementation, to create\nDXGIFactory, for frame-generation it is, usually prevent crashed when using\nmenu.\n'
'Hook SLDevice: If sl.interposer is in memory use it\'s implementation, to create\nD3D12Device, for frame-generation it is, usually prevent crashed when using\nmenu, or Unreal engine games this option is force disabled.\n'
'Override DLSS sharpness: Override DLSS sharpness paramater with fixed\nshapness value.\n'
'Sharpening Amplifier: Enable sharpening amplifier based on motion.\n'
'Sync After Dx12: Start output copy back sync after or before Dx12 execution.\n'
'Use Delay Init: Delay some operations during creation of D11-Dx12 features\nto increase compatibility.\n'
'Build Pipelines: Building pipeline for XeSS before init.\n'
'Create Heaps:  Creating heap objects for XeSS before init.\n'
'Drs MinOverride: Set this to true to enable limiting DRS min resolution to\nrendering resolution.\n'
'Drs MaxOverride: Set this to true to enable limiting DRS max resolution to\nrendering resolution.\n'
'Disable Reactive Mask: Force remove RESPONSIVE_PIXEL_MASK from init\nflags.\n'
'Fake Nvidia GPU for DXGI: Enables Nvidia GPU spoofing for DXGI.(Default is\ntrue)\n'
'Fake Nvidia GPu for Vulkan: Enables Nvidia GPU spoofing for Vulkan.(Default\nis true)\n'
'Dxgi Xess No Spoof: Skips DXGI GPU spoofing for XeSS (Only for OptiScaler\ninstances) Might have compatibility issues, if screen is black try enabling\nautoexposure.(Default is true)\n'
'Override Nvapi Dll: Override loading of nvapi64.dll\n\n'

'Tweak\n'
'Helps \'improve\' aliasing caused by FSR 3 mod, may also\nslightly reduce ghosting, doesn\'t work in all games.\n\n'

),

'Optiscaler Method':(
'Installation Method for Optiscaler\n\n'
'Method Default: Default installation method.(Recommended\nfor testing)\n'
'Method 1 (RTX/RX 6000-7000): Installation method for RTX\nand RX 6xxx/7xxx series GPUs.\n'
'Method 2 (GTX/Old AMD): Installation method for older GPUs\nsuch as GTX and RX 5000 and below.\n'
'Method 3 (If none of the others work): Modified installation\nmethod if none of the other options work.'
),

'Optiscaler FSR 3.1.3/DLSS (Only Optiscaler)':(

'Look for the .exe file ending in "Win64-Shipping.exe", for example: Hellblade2-Win64-Shipping.exe. It is usually located in the path\n"Game Name\\Binaries\\Win64". Some games, such as PlayStation games, do not have this .exe, so install it in the folder of the\nstandard .exe instead.\n\n'

'Optiscaler FSR 3.1.3/DLSS FG (Only Optiscaler)\n'  
'This mod works for most games that have DLSS; just follow the guide for the chosen game in the FSR Guide. (It is necessary to\nrun the game in DX12 for Frame Gen to work)\n\n'
 

'Optiscaler FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'  
'This version disables the mod\'s FG and uses the game\'s DLSS Frame Gen. It works only for games with this feature and is\ncompatible with all GPUs. You can use the mod\'s upscalers (e.g., FSR 3.1.3) together with the game\'s DLSS FG.\n\n'

'DLSS4 (Only RTX)\n'
'Open the Nvidia APP, go to Graphics, select the game, scroll down until you find Driver Settings. In DLSS Override, select "Latest"\nfor all available options. Some games, like Alone In The Dark 2023, are not included in the APP. Follow the steps below to enable\nDLSS 4.\n\n'
'In the mod menu, check the Render Presets Override and select Preset G for the DLSS quality you are using. For example: if you\nare using DLSS Quality in the game, select Preset G in the Quality Preset in the mod.\n'
'To update the game\'s DLSS to DLSS4, select "Others Mods" (only some games have this option).\n'
'To check if Preset K is selected (Some games, the Preset will be J.), check "Yes" in the "DLSS Overlay" box that will appear\nduring installation. When selecting the preset in the mod menu, Preset K may not appear right away in the DLSS Overlay. Restart\nthe game and select Preset G again in the mod menu.\n'
'Update DLSS before installing the mod.\n'  
'Select "Others Mods" (only some games have this option).\n'  
'If the game does not have this option, go to the game\'s folder and check if the file nvngx_dlss.dll is present.\n'  
'Check the "Nvngx.dll" box, select DLSS 4 and install it along with the mod.\n'  
'If the file is not present, follow the same procedure and copy the new nvngx_dlss.dll file to the DLSS folder.\n'  
'The DLSS folder is usually something like: Engine\\Plugins\\Runtime\\Nvidia\\DLSS\\Binaries\\ThirdParty\\Win64 (Some games have\ndifferent paths; look for the file nvngx_dlss.dll.)\n'  
'(Perform these steps only if DLSS 4 (54.2.1 version that should appear in the mod.) is not available in the mod, only RTX).\n'  
),

'Achilles Legends Untold':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Check the box for Fake Nvidia GPU (AMD/GTX only).\n'
'3 - If the mod doesn\'t work, check the Nvapi Results box and\nselect Default in NVNGX.dll.\n'
'4 - In-game, select DLSS.'    
),

'Alan Wake 2':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. In the game, select DLSS and press the "Insert" key to open the menu\n'  
'4. In the menu, select FG Enabled, Active, Hud Fix and Extended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only Optiscaler) guide to see how\nto use it.\n\n'  

'FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSSG FG (Only Optiscaler) and install\n'  
'2. Check "yes" in the "DLSS/FSR" window that will appear during installation.\n'
'3. In the game, select DLSS, Frame Gen and press the "Insert" key to open the\nmenu\n'  
'4. Check the FSR 3.1.3/DLSS (Only Optiscaler) guide to see how to use DLSS 4.\n(Only RTX)\n\n'  

'Alan Wake 2 FG RTX\n'
'1. Select Alan Wake 2 FG RTX and install it.\n'
'2. In the game, select DLSS and enable Frame Generation.\n'
'3. It is also possible to use other versions of the mod.\n\n'

'Alan Wake 2 Uniscaler Custom (AMD\\GTX)\n'
'1. Select Alan Wake 2 Uniscaler Custom and install it.\n'
'2. In the game, select DLSS and enable Frame Generation if it is not enabled by\ndefault.\n'
'3. Do not switch to FSR as the game will crash.\n'
'4. It is also possible to use other versions of the mod, except Alan Wake 2 FG RTX.\n\n'

'Preset\n'
'1. Install ReShade\n'
'2. Inside ReShade, select the game’s .exe and click next\n'
'3. Select DX 10/11/12 and click next\n'
'4. Click "Browse" and locate the file Realistic Reshade.ini that was installed in the\nfolder selected in the Utility and click Next\n'
'5. In the game, press the Home key to open the menu and select the options you\nprefer\n'
'6. Install the Preset first and then the FSR3 mod if you plan to use it'
),

'Alan Wake Remastered':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended'
),

'Alone in the Dark':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. To make the mod work, run it in DX12. To run it in DX12, right-click\nthe game\'s exe and create a shortcut, then right-click the shortcut again,\ngo to "Properties," and at the end of "Target" (outside the quotes), add\n-dx12 or go to your Steam library, select the game, go to Settings >\nProperties > Startup options, and enter -dx12.\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'3. Check the Enable Signature Over box\n'  
'4. In the game, select DLSS and press "Insert" to open the menu\n'  
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'  
'6. Select FSR 3.x to use FSR 3.1.3\n'
'7. If you want to update DLSS, do it before installing the mod; just\nselect "Others Mods AITD\n\n'

"Uniscaler/0.x\n"
"1 - Select a version of the mod of your choice (version 0.10.3 is\nrecommended).\n"
"2 - Enable the 'Enable Signature Override' checkbox.\n"
"3 - Enable Fake Nvidia GPU, if you want to use DLSS (Only for AMD\nGPUs).\n"
"4 - Set FSR in the game settings.\n"
"5 - If the mod doesn't work, elect 'Default' in Nvngx.dll."
),

'A Plague Tale Requiem':(
'Default Mods\n'
'1 - Select a mod of your choice (0.10.3 is recommended).\n'
'2 - Check the box for Fake Nvidia GPU (AMD/GTX) and\nNvapi Results (GTX). (If the mod doesn\'t work for AMD, also\ncheck Nvapi Results)\n'
'3 - To fix hub flickering, enable DLSS and Frame Generation\nand play for a few seconds, then disable DLSS and leave\nonly Frame Generation enabled.\n\n'

'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. In the game, press the "Insert" key to open the menu\n'
'3. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
),

'A Quiet Place: The Road Ahead':(
'1. Select an FSR 3.1.1/DLSS mod and install it\n'
'2. In the game, select DLSS\n'
'3. Press the Insert key to open the menu\n'
'4. Select an upscaler of your choice\n'
'5. Check the Frame Gen and Hud Fix boxes\n'
'6. If you can\'t see DLSS, enable Hardware Acceleration in\nGraphics Settings on Windows'
),

'Assassin\'s Creed Mirage':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. If you are using ReShade, select FSR 3.1.1/DLSS FG\nCustom and follow the steps above\n\n'

'Preset\n'
'1. Install ReShade\n'
'2. In ReShade, select the game’s .exe and click next\n'
'3. Select DX 10/11/12 and click next\n'
'4. Click "Browse" and locate the file ACMirage lighting\nand package.ini that was installed in the folder selected in\nthe Utility and click Next\n'
'5. In the game, press the Home key to open the menu and\nselect the options you prefer\n'
'6. Install the Preset first and then the FSR3 mod if you\nplan to use it'
),

'Assassin\'s Creed Valhalla':(
'1 - Press the "End" key to open the Frame Gen menu or the\n"Home" key to open the main menu.\n'
'2 - Select AC Valhalla DLSS3\n'
'3 - In the game, enable Motion Blur and disable FSR'   
),

'Assetto Corsa EVO':(
'FSR 3.1.3/DLSS (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. To update the DLSS, select "Others Mods ACE"; do this\nbefore installing the mod'
),

'Atomic Heart':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'  
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS\n(Only Optiscaler) guide to see how to use it.\n\n'  

'FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSSG FG (Only Optiscaler) and install\n'  
'2. Check "yes" in the "DLSS/FSR" window that will appear\nduring installation. (RTX users, only check "yes" if it\'s not\npossible to activate the game\'s FG).\n'
'3. In the game, select DLSS, Frame Gen and press the\n"Insert" key to open the menu\n'  
'4. Check the FSR 3.1.3/DLSS (Only Optiscaler) guide to see\nhow to use DLSS 4. (Only RTX)\n\n'  

'Uniscaler/0.x\n'
'1. Select a mod of your choice (0.10.3 is recommended).\n'
'2. In the game, select FSR.'   
),

'Back 4 Blood':(
'FSR 3.1.3/DLSS (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. To update the DLSS, select "Others Mods B4B"; do this\nbefore installing the mod\n'
'6. Do not use the mod in Online mode, or you may be banned.'
),

'Baldur\'s Gate 3': (
'1 - Start the game in DX11 and select Borderless.\n'
'2 - Choose DLSS or DLAA.\n'
'3 - Press the END key to enter the mod menu, check\nthe Frame Generation box to activate the mod; you can also\nadjust the Upscaler. (To activate Frame Generation, simply\npress the * key; you can also change the key in the mod\nmenu.)\n'  
),

'Banishers Ghost of New Eden':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Check the box Fake Nvidia GPU and Nvapi Results\n(AMD/GTX).\n'
'3 - In-game, select DLSS and DLSS FG'   
),

'Black Myth: Wukong':(
'RTX\n'
'1. Select \'DLSS FG (ALL GPUs) Wukong\' and install.\n'
'2. In the game, select DLSS and Frame Generation.\n'
'3. This mod fixes issues related to using the Somersault Cloud.\n\n'

'AMD/GTX DLSS FG\n'
'1 - Select Optiscaler FSR 3.1/DLSS and install it.\n'
'2 - In the game, press the \'Insert\' key to open the menu, and in the menu,\nselect the upscaler you want to use.\n'
'3 - If an error occurs with the HUD, set the game to \'Windowed Mode\', then\nafter a few seconds switch back to \'Borderless Windowed\'.\n\n'

'Graphic Preset\n'
'1 - Install the mod and the ReShade application\n'
'2 - In ReShade, select b1.exe, DirectX 10/11/12,\nclick on \'Browser\', and find the file Black Myth Wukong.ini (the path should\nlook something like BlackMythWukong\\Black Myth Wukong.ini) and select it, then click on \'Uncheck All\' and \'Next\'.\n'
'3 - In the game, press the \'Insert\' key to open\nthe menu and check the options you want.\n\n'

'Optimized Wukong\n'
'Faster Loading Times - By tweaking async-related settings:\n' 
'the mod allows assets to load in the background, reducing loading times\n' 
'and potentially eliminating loading pauses during gameplay.\n\n' 

'Optimized CPU and GPU Utilization - by tweaking multi-core rendering:\n' 
'allows the game to utilize the full potential of modern CPUs and GPUs.\n' 
'This can result in improved performance, higher frame\n' 
'rates, and more stable gameplay.\n\n' 

'Enhanced Streaming and Level Loading - By tweaking various streaming\nvariables:\n' 
'the mod improves the efficiency of streaming assets and\n' 
'level loading. This can lead to faster streaming and reduced stuttering\n' 
'when moving through different areas of the game world.\n\n' 

'Optimized Memory Management - By adjusting memory-related settings:\n' 
'the mod optimizes memory allocation and garbage collection. This\n' 
'can lead to more efficient memory usage, reduced memory-related\n' 
'stutters, and improved overall performance.'
),

'Blacktail':(
  '1 - Select a mod of your choice (0.10.3 is recommended)\n'
  '2 - "Check the Fake Nvidia GPU box.'  
),

'Bright Memory: Infinite':(
  '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n '  
  '2 - To make the mod work, run it in DX12. To run it in DX12, right-click the game\'s\nexe and create a shortcut, then right-click the shortcut again,\ngo to \\"Properties,\\" and at the end of \\"Target\\" (outside the\nquotes), add -dx12 or go to your Steam library, select the\ngame, go to Settings > Properties > Startup options, and\nenter -dx12.'
),

'Brothers a Tale of Two Sons':(
'1- Select a mod of your preference (0.10.3 is recommended).\n'
'2. Check the box Fake Nvidia GPU(AMD/GTX).\n'
'In-game, select DLSS or FSR.'
),

'Cod Black Ops Cold War':(
'1 - Select a mod of your choice. (recommended 0.10.3)\n'
'2 - Check the box Fake Nvidia GPU.\n'
'3 - If you don\'t see any differences, check the box for\nNvapi Results.'   
),

'Cod MW3':(
'1 - Select the game path: CallofDuty\\Content\\sp23\n'
'2 - Select the COD MW3 FSR3 mod and install it\n'
'3 - In the game, select DLSS Frame Generation\n'
),

'Control':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select the .exe path\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. Select FSR 3.x to use FSR 3.1.3\n'
'7. If you want to update FSR/DLSS, do this before installing\nthe mod, select "Others Mods Control" to update\n'
'8. The Utility may become unresponsive for a few seconds\nduring installation; just wait for the installation confirmation\nmessage.'
),

'Crime Boss Rockay City':(
'1 - Select a mod of your choice (0.10.4 is recommended).\n'
'2 - Check the Fake Nvidia GPU box for AMD/GTX users.\nIf you can\'t see DLSS in the game, check the Nvapi Results\nand UE Compatibility Mode boxes.\n'
'3 - In the game, turn off Anti-Aliasing and select DLSS as\nthe upscaler.'  
),

'Crysis 3 Remastered':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.'
),

'Cyberpunk 2077':(
'FSR 3.1.3/XESS FG\n'
'1. Select FSR 3.1.3/XESS FG and install\n'
'2. In the game, select DLSS and DLSS Frame Gen\n'
'3. It is recommended to install the "FG Ghost Fix" along with the\nmod, select "Others Mods 2077" to install\n\n'

'RTX DLSS FG\n'
'1. Select RTX DLSS FG and install\n'
'2. It is recommended to install the "FG Ghost Fix" along with the\nmod, select "Others Mods 2077" to install\n'
'3. In the game select DLSS and DLSS Frame Gen\n\n'

'Uniscaler FSR 3.1\n'
'1 - Select Uniscaler V3.\n'
'2 - If you have an RTX GPU and want to use the real DLSS, select\nDLSS under "Mod Operates". If you don\'t have an RTX GPU and\ncan\'t see DLSS in the game, check the Nvngx.dll box and select\n"Default". You can also use XESS instead of FSR 3.1 by selecting\nXESS under "Mod Operates".\n'
'3 - Check the box "Enable Signature Over"\n'
'4 - In the game, choose an upscaler and frame generation option.\n\n'

'1 - Select a mod of your choice (Uniscaler is recommended).\n'
'2 - Select Default in Nvngx.dll.\n'
'3 - Check the box Enable Signature Override.\n'
'4 - In-game, turn off Vsync, select DLSS (do not select auto\nas the game will crash), and turn on Frame Generation.\n\n'    

'ReShade\n'
'1 - Download and install ReShade.\n'
'2 - Select Cyberpunk2077.exe, DirectX 10/11/12, Update\nReShade and Effects and choose the V2.0 Real Life Reshade.ini\n'
'2 - Select check all effects (you can also use \'Uncheck all\' and\n\'Check all\' to select everything at once).\n' 
'3 - Install the mod using the Utility.\n\n'

'1 - After completing the steps above, open the game for the first\ntime. If a "Menu" (Ultra+) appears, select a key to open this\n"Menu."\n'
'2 - Select DLSS, Frame Gen, and restart the game.\n'
'3 - After reopening the game, press the "Insert" key to open the\nFSR 3.1 mod menu, "Home" to open the ReShade menu\n(select the options you prefer), and the key you selected to open\nthe "Menu" (Ultra+).'
),

'Dakar Desert Rally':(
'1- Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Check the box Fake Nvidia GPU and Nvapi Results\n(AMD/GTX).\n'
'In-game, select DLSS and Frame Generation.'    
),

'Dead Island 2':(
'Default Mod\n'
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - If it doesn\'t work with the default files, enable\nEnable Signature Override. If it still doesn\'t work, check the\nbox lfz.sl.dlss.\n'
'3 - It\'s not necessary to activate an upscaler for this game\nfor the mod to work, so enable it if you want.\n\n'

'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. In the game, select FSR 2 and press the "Insert" key to\nopen the menu\n'
'3. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
),

'Death Stranding Director\'s Cut':(
'Default Mod\n'
'Before installing the mod, open the game and disable\nFidelityFx Cas.\n'
'1. Select Unicaler V4.\n'
'2. Check the box for "Enable Signature Over", check the\n"Nvngx.dll" box, and select "Default".\n'
'3. In the game, enable FidelityFx Cas if you want more FPS\n(the mod is activated automatically when installed, but\nFidelityFx Cas provides a slight FPS boost).\n'
'4. If you want even more FPS, check the "Fake Nvidia GPU"\nbox and reinstall the mod (this option may not work for some\nGPUs, so test it).\n' 
'This game does not support ReShade and the mod together,\nso you will need to uninstall ReShade if you use it for the\nmod to work.\n\n'

'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install.\n'  
'2. Check the Enable Signature Over box.\n'  
'3. In the game, disable Depth of Field, Motion Blur, and TAA.\n'  
'4. Select DLSS and press the Insert key to open the menu.\n'  
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'  
),

'Chernobylite':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Check the box \'Fake Nvidia Gpu\' (only for Amd/Gtx).\n'
'3 - To fix flickering in the hub, select Dlss, play for a few\nseconds, then select Fsr3 and repeat the process, finally\nselect Dlss.' 
),

'Dead Space Remake':(
"1 - Select a version of the mod of your choice (versions\nfrom 0.9.0 onwards \nare recommended to fix UI flickering).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the\nmod doesn't work.\n"
"3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n"
"4 - If the mod doesn't work, select 'Default' in Nvngx.dll."   
),

'Dead Rising Remaster':(
'1. Select Dinput8 DRR and install\n'
'2. Open the game until the "Re Framework" menu appears,\nonce it appears, close the game and return to the Utility\n'
'3. Select FSR 3.1 FG DRR and install\n'
'4. In the game, select DLSS and Frame Gen\n'
'5. The mod already includes DLSS 4'
),

'Deathloop':(
  '1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n' 
  '2 - Activate Fake Nvidia Gpu and Nvapi Results (Only for\nAMD and GTX) ' 
),

'Dragon Age: Veilguard':(
'1. Select FSR 3.1.1/DLSS FG DG Veil and install it.\n'
'2. In the game, press the "Insert" key to open the menu.\n'
'3. In the menu, select "FSR 3x" under "Upscalers," then\nselect "FSR 3.1.3" right below.'
),

'Dragons Dogma 2':(
'1. Select Dinput8 DD2 in Mod Select and install.\n'
'2. Open the game after Dinput8 is installed, a "REFramework" menu will\nappear. Click on it, go to Settings and Menu Key, click on Menu Key,\nand select the preferred key (the key is used to open and close the menu).\n'
'3. Close the game, in Utility select FSR 3.1.3/DLSS FG Custom and\ninstall (it is recommended to select "Yes" when the message to delete the\nshader file appears).\n'
'4. In the game, select DLSS and Frame Gen.\n'
'5. It is possible that the game will crash the first 2 or 3 times after the mod\nis installed, so just close the game and open it again'
),

'Dying Light 2': (  
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Open the game and select DX12.\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over box\n'
'4. In the game, select DLSS or Xess and press the "Insert"\nkey to open the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n\n'
 
'Uniscaler/0.x\n'   
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Enable Fake Nvidia GPU (only for AMD and GTX).\n'
'3 - In the game, select any upscaler and activate Frame\nGeneration.\n'
'4 - If you experience any flickering or ghosting, go to Video >\nAdvanced Settings and decrease the Lod Range Multiplier.'
),

'Dynasty Warriors: Origins':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. In the game, select XESS or DLSS if available and press\n"Insert" to open the menu\n'  
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'  
'5. Select FSR 3.x to use FSR 3.1.3'
),

'Elden Ring': (
'FSR 3.1.3/DLSS FG Custom Elden\n'
'1. Select FSR 3.1.3/DLSS FG Custom Elden and install\n'
'2. For Steam users, select Disable Anti-Cheat and install, go to the installation folder and run\n"start_protected_game.exe", open the game through eldenring.exe, not through Steam.\n'
'3. In the game, press the "Home" key to open the menu\n'
'4. In the menu, select Frame Gen and an Upscaler\n'
'5. DLSS 4, select DLSS in the menu and Default in the Render Preset. If you selected \"Yes\" in\nthe \"DLSS Overlay\" window during installation, you will be able to see if Preset K is active. The\noverlay appears in the bottom-left corner of the screen.(Only RTX)\n\n'

'Others Mods\n'
'1. Select "Disable AntiCheat" in the Select Mod and choose "Yes" in the anticheat deactivation\nconfirmation window. Select the folder where the game exe is located, otherwise, it will not be\npossible to deactivate the anticheat. (Steam Only)\n'
'2. Select "Elden Ring FSR3" in Select Mod and install it.\n'
'3. In the game, press the "Home" key to open the mod menu. In "Upscale Type," select the\nUpscaler according to your GPU (DLSS Rtx or FSR3 non-Rtx), then check the box "Enable\nFrame Generation" below.\n'
'• To remove Full Screen borders, select "Full Screen" in the game before installing the mod. If\nthere is screen overflow after mod installation, select full screen -> window -> full screen.\n'
'• Enable AntiAliasing and Motion Blur; this mod will skip the actual rendering of motion blur, so\ndon\'t worry if you don\'t like motion blur. The game only needs it to render motion vectors.'
),

'Empire of the Ants':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.'
),

'Eternal Strands':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n\n'

'FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSSG FG (Only Optiscaler) and install\n'  
'2. Check "yes" in the "DLSS/FSR" window that will appear\nduring installation.\n'
'3. In the game, select DLSS, Frame Gen and press the\n"Insert" key to open the menu\n'  
'4. Check the FSR 3.1.3/DLSS (Only Optiscaler) guide to see\nhow to use DLSS 4. (Only RTX)'
),

'Everspace 2':(
'1 - Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Check Fake Nvidia Gpu and Nvapi Results.\n'
'3 - Inside the game, select FSR or DLSS'   
),

'Evil West':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. If you want to update DLSS, do it before installing the\nmod; just select "Others Mods EW"' 
),

'Fallout 4':(
  'Usage of the Sym Link:\n'
'1 - In SymLink, click on add file and navigate to the root folder of the game. In the root folder, look\nfor Data\\F4SE\\Plugins, within this folder select Fallout4Upscaler.dll.\n'
'2 - In "Destination Path" in the Sym Link, paste the path of the "mods" folder. Simply navigate to\nthe mods folder and copy the path from the address bar of the file explorer, or you can navigate to\nthe folder through the Sym Link itself.\n'
'3 - Click on Create symlinks.\n'
'4 - Go back to the mods folder, go to View (w10) or Options (w11), and uncheck the box "File\nname extensions.\n'
'5 - Rename the file Fallout4Upscaler.dll in the mods folder to RDR2Upscaler.org.\n'
'6 - Run the game launcher located in the root folder of the game, in the launcher set "depth of\nfield" to Low.\n'
'7 - Run the game using the file f4se_loader.exe, also located in the root folder of the game.\n'
'8 - In the game, press the "END" key to open the mod menu, select DLSS for RTX and FSR3 for\nnon-RTX.' 
),

'Final Fantasy VII Rebirth':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.'
),

'Final Fantasy XVI':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'   
'1. If you want to update the DLSS, select "Others Mods FFVXI", do\nthis before installing the mod.\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'3. Check Enable Signature Over box\n'
'4. In the game, select HDR in the menu, it is required for the mod to\nwork and  select DLSS and press the "Insert" key to open the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n\n'

'Anti Stutter\n'
'Prevents possible crashes during the game and optimizes CPU/GPU\nusage\n\n'

'FFXVI FIX\n'
'General\n'
'Adjust gameplay FOV, camera distance and camera horizontal\nposition.\n'
'JXL screenshot quality option and fixes hitching while taking\nscreenshots.\n'
'Allow the use of motion blur + frame generation.\n'
'Disable depth of field.\n'
'Enable background audio.\n'
'Lock cursor to game window.\n\n'

'Performance\n'
'Disable 30FPS cap in cutscenes/photo mode or set your own\nframerate limit.\n'
'Allow frame generation in cutscenes.\n'
'Disable graphics debugger checks.\n\n'

'Ultrawide/narrower\n'
'Remove pillarboxing/letterboxing.\n'
'Fixed HUD scaling with configurable HUD size.\n'
'Fixed FOV scaling at <16:9.\n\n'

'ReShade\n'
'1. Download and install ReShade.\n'
'2. Select ffxvi.exe, DirectX 10/11/12, Update ReShade and\nEffects and choose the FINAL FANTASY XVI.ini.(The .ini is in\nthe selected folder in the Utility\n'
'3. Select check all effects (you can also use \'Uncheck all\' and\n\'Check all\' to select everything at once).\n' 
'4. In the game, press the \'Home\' key to open the ReShade menu.'
),

'Fist Forged in Shadow Torch':(
'FSR 3.1.3/DLSS (Only Optiscaler)\n'
'1. Open the game and select DX12\n'
'2. Select FSR 3.1.3/DLSS (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over box\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. If you want to update DLSS, do it before installing the\nmod; just select "Others Mods First."'
 
),

'Flintlock: The Siege of Dawn':(
'1 - Select the FSR 3.1.1/DLSS Optiscaler mod and install it.\n'
'2 - In the game, select DLSS, press the Insert key to open\nthe Optiscaler menu, in Upscalers select an upscaler of your\npreference. If you cannot see the menu, after installing the\nmod, select Optiscaler in the Utility and choose an upscaler\nin Upscaler Optiscaler and install.'
),

'Fort Solis':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n\n'

'FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSSG FG (Only Optiscaler) and install\n'  
'2. Check "yes" in the "DLSS/FSR" window that will appear\nduring installation.\n'
'3. In the game, select DLSS, Frame Gen and press the\n"Insert" key to open the menu\n'  
'4. Check the FSR 3.1.3/DLSS (Only Optiscaler) guide to\nsee how to use DLSS 4. (Only RTX)' 
),

'Forza Horizon 5':(
'1 - Choose Horizon Forza 5 FSR3 and install it. In the \nconfirmation window, select \'Yes\' for RTX or \'No\' for non-RTX.\n'
'2 - For RTX, in-game, select DLSS and enable Frame \nGeneration.\n'
'3 - For other GPUs, select FSR and activate Frame \nGeneration. You can use DLSS, but you will experience\nghosting.\n'  
),

'F1 2022' : (
'1 - Choose a version of the mod you prefer (version 0.10.3 is\nrecommended).\n'
'2 - Select "Default" in Nvngx and check the box "Enable\nSignature Override.\n'
'3 - Check the box "Fake Nvidia GPU" (AMD Only).\n'
'4 - Within the game, under AntiAliasing, select DLSS or FSR.\n'
'• To fix the HUD flickering, select DLSS in AntiAliasing before\nstarting the game. While playing, switch to TAA+FSR or TAA\nonly.'     
),

'F1 2023':(
'1 - Choose a version of the mod you prefer (version 0.10.3 is\nrecommended).\n'
'2 - Select "Default" in Nvngx and check the box "Enable\nSignature Override.\n'
'3 - Check the box "Fake Nvidia GPU" (AMD Only).\n'
'4 - Inside the game, under AntiAliasing, select DLSS or FSR.'
),

'Gotham Knights':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the "Enable Signature Over" box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. If you want to update DLSS, select "Others Mods GK" and\ninstall it. Select the .exe folder (Mercury\\Binaries\\Win64);\notherwise, it will not be possible to update DLSS.'
),

'GTA Trilogy':(
'FSR 3.1.3/DLSS (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS (Only Optiscaler) and install.\n'
'2. Check the Enable Signature Over box.\n'
'3. In the game, select DLSS and press the Insert key to\nopen the menu.\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. The installation method is the same for the three GTA\nversions.'
),

'GTA V':(
"Single Player and Multiplayer\n"
'1. Select Dinput 8 and install. (only single player)\n'
'2. Open the game and disable MSAA and TXAA and select\nborderless window. If the mod doesn\'t work, disable FXAA.\n'
'3. Close the game and select GTA V FSR3/DLSS4 and install\n'
'4. Press "Home" to open the menu. If the mod is disabled,\ncheck "Enable Frame Generation".\n'
'5. DLSS4, in the menu, select Default in the DLSS Preset\nand Auto Exposure in the Advanced Settings. If you enabled\nthe DLSS Overlay during installation, check if Preset K is\nactivated in the overlay. (The overlay is located in the bottom\nleft corner of the screen). (Only RTX)\n'
'6. All mods have DLSS4.'  
),

'Ghost of Tsushima':(
'1 - Select Ghost of Tsushima FG DLSS and install\n'
'2 - In the game, select DLSS Frame Generation\n'   
'3 - If you encounter any issues related to DX12, select "YES"\nin the "DX12" window that will appear during the installation.\nFirst, test the mod without confirming this window.\n'
'4 - If you are experiencing any issues with crashes, select\n"Yes" in the "Crash Issues" window that will appear during\nthe mod installation.\n\n' 
'FSR 3.1\n'
'1 - Select Uniscaler FSR 3.1\n'
'2 - For AMD/GTX users: Check the boxes: Fake Nvidia GPU, Nvapi\nResults, and Disable Signature Over.\n'
'3 - Check the Nvngx box and select Default.\n'
'4 - In the game, select DLSS; do not change to FSR as the\ngame will crash.'
),

'Ghostrunner 2': (
'1 - Select a version of the mod of your choice (version 0.10.3\nis recommended)\n' 
'2 - To make the mod work, run it in DX12. To run it in DX12, right-click\nthe game exe and create a shortcut, then right-click the shortcut\nagain, go to \\"Properties,\\" and at the end of \\"Target\\" (outside the\nquotes), add -dx12 or go to your Steam library, select the game, go to\nSettings > Properties > Startup options, and enter -dx12.\n'
'3 - Activate Fake Nvidia Gpu (AMD only)\n'
'4 - Inside the game, set the frame limit to unlimited, activate DLSS first\n(disable other upscalers before) and then activate frame generation\n'
'• To fix the flickering of the HUD, activate and deactivate frame\ngeneration again (no need to apply settings).'
),

'Ghostwire: Tokyo':(
'Default Mod\n'
'1- Select Uniscaler V3\n'  
'2 - Check the Fake Nvidia GPU box (AMD/GTX). If you can\'t\nsee DLSS in the game, also check the Nvapi Results box.\n'
'3 - Check the Nvngx.dll box and select Default, then check\nthe Enable Signature Override box.\n'
'4 - In the game, select DLSS to enable Frame Generation.\n'  
'5 - To fix the HUD glitch, switch between the upscalers (FSR,\nDLSS, etc.) until the HUD stops flickering.\n\n'

'FSR 3.1.2/DLSS FG Custom\n'
'1. Select FSR 3.1.2/DLSS FG Custom and install.\n'
'2. Check the Enable Signature box.\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu.\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. Disable all FPS Overlay. If your game is from Epic Games,\nselect "Auto Search" in "Epic Games Overlay" and click\n"Disable."'
),

'God Of War 4':(
'FSR 3.1.3/DLSS (Only Optiscaler) + AMD Anti Lag 2\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FSR 3x to use FSR 3.1.3 or DLSS if\nyou have an RTX\n'
'5. Select Nvidia Reflex in the game to use AMD Anti Lag 2'

),
'God of War Ragnarök':(
'DLSS FG ALL GPU\n'
'1. Select Uniscaler FSR 3.1.\n'
'2. Select FSR3 in "Mod Operates" (if you can\'t see DLSS in the game,\nselect FSR3 in "Frame Gen Method" as well)\n'
'3. Check the "Enable Signature Over" box.\n'
'4. If you still can\'t see DLSS in the game, check the Nvngx.dll box,\nselect "Default," and reinstall the mod.\n'
'5. The game may freeze for a few seconds when selecting DLSS FG.\n\n'

'FSR 3.1.3/DLSS FG + AMD Anti Lag 2 GowR\n'
'1. Select FSR 3.1.3/DLSS FG (only Optiscaler) and install.\n'
'2. Check the Enable Signature Over box.\n'
'3. If you want to update the game\'s upscalers, it is recommended to do so\nbefore installing the mod. Simply select "Others Mods Gow Rag" to update.\n'
'4. Check the "AMD Anti Lag 2" option that appears during installation.\n'
'5. In the game, select "Reflex" under "Latency Reduction".\n'
'6. Press the Insert key to open the menu.\n'
'7. In the menu, select FSR 3x to use FSR 3.1.3. If you want to use\nFrame Generation (FG), check the Frame Gen and Hud Fix boxes.\n\n'

'Unlock VRAM\n'
'Removes the error for GPUs with less than 6GB of VRAM\n\n'
'Anti Stutter\n'
'Prevents possible game stuttering and optimizes CPU/GPU\nusage\n\n'
'ReShade\n'
'1. Download and install ReShade.\n'
'2. Select GoWR.exe, DirectX 10/11/12, Update ReShade and\nEffects and choose the God of War Ragnarök.ini.(The .ini is in\nthe selected folder in the Utility\n'
'3. Select check all effects (you can also use \'Uncheck all\' and\n\'Check all\' to select everything at once).\n' 
),

'Hellblade: Senua\'s Sacrifice':(
'1. Open the game and select DX12 in the menu\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.'
),

'Hellblade 2':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select the path Senua\'s Saga Hellblade II\\Hellblade2\\Binaries\\Win64\n'
'2. If you want to update the DLSS, select "Others Mods HB2", do this before installing the mod\n'
'3. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'4. Check the Enable Signature Over box\n'
'5. In the game, select DLSS and press the "Insert" key to open the menu\n'
'6. In the menu, select FG Enabled, Active, Hud Fix and Extended. In Hud Fix, click on the input\nbox and type 7\n'
'7. It is recommended to select the Upscaler before activating Frame Gen, as FG is disabled every\ntime the upscaler is switched. To activate it again, type 1 and then 7 in the Hud Fix input box.\n\n'

'Only RTX\n'
'1 - Select Hellblade 2 FSR3 and install it.\n'
'2 - In the game, select Frame Generation.\n'
'3 - This mod only works for RTX.\n\n'
'All GPUs\n'
'1 - Select Uniscaler V2 (you can also test with the other mods)\n'
'2 - Check the box for Fake Nvidia GPU (AMD) and check the box for UE compatibility mode (AMD\nand Nvidia)\n'
'3 - In-game, select Frame Generation\n'
'• The black bars are removed automatically if the Engine.ini file is found. If it is not found, check if\nit is in the path C:\\Users\\YourName\\AppData\\Local\\Hellblade2\\Saved\\Config\\Windows or WinGDK.\nIf it\'s not there, open the game to have the file created.\n\n' 
'• If the bars are not removed, select \'Remove Black Bars Alt\', the removal of the black bars will be\nautomatically performed if the Engine.ini file is found. \n\n' 
'• To remove only the main effects, such as Lens Distortion, Black Bars, and Chromatic Aberration,\n\n'
'• To remove all effects,(includes film grain).\n\n'
'• To restore the Post Processing effects, simply select\'Restore Post Processing\', and the\nEngine.ini file will be replaced\nwith the default file.\n\n'
'• If the Frame Generation is not visible, remove the black bars.'
),

'High On Life':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Enable Fake Nvidia Gpu.(only Amd and Gtx)'
),

'Hogwarts legacy':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select the path Phoenix\\Binaries\\Win64\n'
'2. If you want to update the DLSS, select "Others Mods HL",\ndo this before installing the mod.\n'
'3. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'4. Check Enable Signature Over box\n'
'5. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'6. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'7. Select Nvidia Reflex to use AMD Anti Lag 2\n\n'

'FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSSG FG (Only Optiscaler) and install\n'  
'2. Check "yes" in the "DLSS/FSR" window that will appear during\ninstallation.\n'
'3. In the game, select DLSS, Frame Gen and press the "Insert" key\nto open the menu\n'  
'4. Check the FSR 3.1.3/DLSS (Only Optiscaler) guide to see how\nto use DLSS 4. (Only RTX)\n\n'  

'Uniscaler/0.x\n'
"1 - Select a version of the mod of your choice (versions from 0.9.0\nonwards are recommended to fix UI flickering).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the mod\ndoesn't work.\n"
"3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n"
"4 - Select 'Default' in Nvngx.dll.\n\n"

'Reshade\n'
'1. Install ReShade\n'
'2. Inside ReShade, select the game’s .exe and click next\n'
'3. Select DX 10/11/12 and click next\n'
'4. Click "Browse" and locate the file Hogwarts Legacy Real Life\nDARKER HOGWARTS Reshade.txt that was installed in the folder\nselected in the Utility and click Next\n'
'5. In the game, press the Home key to open the menu and select\nthe options you prefer\n'
'6. Install the Preset first and then the FSR3 mod if you plan\nto use it'
),

'Hitman 3':(
'FSR 3.1.3/DLSS FG (Only Optiscaler) \n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. To use AMD Anti Lag 2, select Reflex\n\n'
),

'Horizon Forbidden West':(
'1 - Select Horizon Forbidden West FSR3 and install\n'
'2 - Choose Xess or FSR on the initial setup screen, turn on Frame\nGeneration, and do not select DLSS, otherwise the game will crash\n'
'3 - In-game, select the Low quality preset, then adjust the settings as\ndesired, but do not modify options below Hair Quality\n'
'4 - Select Xess or FSR.'
),

'Horizon Zero Dawn/Remastered':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. If you want to update DLSS/FSR, select "Others Mods HZD"\nand install, do this before installing the main mod.'
),

'Hot Wheels Unleashed':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'  
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended'
),

'Icarus':(
'1 - Select Icarus FSR3 in mod version.\n'
'2 - If the option selected is RTX, confirm the window that appears.\n'
'3 - If the option is AMD/GTX and you notice that the mod is not generating FPS, open\nthe file fsr2fsr3.config and replace "mode = default" on the first line with "replace_dlss_fg",\nkeep it inside the quotation marks, it will look like this: mode = "replace_dlss_fg".\n'
'4 - Start the game in DX12, if the game exe is in the destination folder where the mod was\ninstalled, a DX12 shortcut will be created on your Desktop. If the exe is not found, you\nneed to create a shortcut and in the properties, at the end of Target, add -dx12 outside the\nquotes if there are any, don\'t forget to put a space between -dx12 and the path.\n'  
'5 - Run the game through the executable.'
),

'Indiana Jones and the Great Circle':( 
'Indy FG (Only RTX)\n' 
'1. Select "Indy FG (Only RTX)" and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. In the game, select DLSS FG\n\n'

'Reshade\n'
'1. Install ReShade.\n'
'2. In the ReShade, select the game’s .exe and click next.\n'
'3. Select DX 10/11/12 and click next.\n'
'4. Click "Browse" and locate the file TheGreatCircle.ini that\nwas installed in the folder selected in the Utility and click\nNext.\n'
'5. In the game, press the Home key to open the menu and\nselect the options you prefer.\n'
),

'Judgment':(
'1 - Select a mod of your preference. (0.10.3 is recommended)\n'
'2 - In the game, select FSR 2.1'    
),

'Jusant':(
'1 - Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Check the box for Fake Nvidia GPU. If the mod doesn\'t\nwork, also check Nvapi Results (only for AMD and GTX)\nand select Default for Nvngx.dll\n'
'3 - In-game, select DLSS and check the Frame Generation\nbox.'    
),

'Kingdom Come: Deliverance II':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Install in the Bin\\Win64MasterMasterSteamPGO folder.\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'3. Check the Enable Signature Over box\n'  
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'  
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. DLSS4, see the Optiscaler FSR 3.1.3/DLSS\n(Only Optiscaler) guide to see how to use it.'  
),

'Kena: Bridge of Spirits': (
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Open the game and select DX12 in the Settings\n'  
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'3. Check the Enable Signature Over box\n'  
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'  
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'  

'Others\n'
'1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n'  
'2 - Activate Fake Nvidia Gpu and Nvapi Results (AMD\\GTX\\\nIntel only).\n\n'
),

'Layers of Fear':(
 '1 - Select a mod of your preference (0.10.3 is recommended)\n'   
 '2 - Check the box Fake Nvidia GPU.(AMD/GTX)\n'
 '3 - If you don\'t notice Frame Generation, select Replace\nDLSS FG in \'Mod Operates\'.\n'
 '4 - In the game, select Frame Generation and DLSS or FSR'
),

'Lies of P':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install.\n' 
'2. Check the "Enable Signature Over" box.\n' 
'3. In the game, select DLSS.\n' 
'4. Press the Insert key to open the menu.\n' 
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n' 
'6. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it. (Only RTX)\n\n'

'Uniscaler/0.x\n'
'1. Select a version of the mod of your choice (version 0.10.4\nis recommended).\n'
'2. Activate Fake Nvidia Gpu and UE Compatibility Mode\n(AMD only).\n'
'3. To fix the flickering of the Hud, first select DLSS Quality,\nthen select FSR Quality (without disabling DLSS), then\nselect DLSS again.\n\n'
),

'Lego Horizon Adventures':(
'1. Select the FSR 3.1.3/DLSS FG Custom and install\n'  
'2. In the game, select DLSS and Frame Gen\n'  
'3. If you want to use FSR 3.1.3, press the "Insert"\nkey and select FSR 3x'
),

'Loopmancer':(
'1 - Select a mod of your preference (0.10.3 is recommended)\n' 
'2 - Check the box Fake Nvidia GPU.(AMD/GTX)\n'   
'3 - In the game, select DLSS or FSR'
),

'Lords of the Fallen':(
'1 - Run the game through the launch.bat file. During the mod\ninstallation, you will be asked if you want to create a shortcut\nfor the .bat file on the desktop. If you don\'t want to, run the\n.bat file directly from the folder where the mod was installed.\n'
'2 - In-game, enable Frame Generation and select FSR or\nDLSS.'  
),

'Manor Lords':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Check the Fake Nvidia GPU box. (Only for AMD/GTX).\n'
'3 - In-game, select DLSS.'  
),

'Martha Is Dead': (
  '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n'  
  '2 - Select Default in Nvngx\n'
  '3 - Execute Enable Signature Override\n'
  '4 - In Mod Operates, select "Replace DLSS FG"\n'
  '5 - Activate Fake Nvidia Gpu (AMD only)\n'
  '• To fix the flickering on the Hud, set the screen mode to fullscreen\n(windowed), select FSR 1.0, turn off motion blur and depth of field, check\nMotion Blur and Depth of Field again after saving the settings. If they don\'t\nturn off, turn them off again.'
),

'Marvel\'s Avengers':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and start the campaign\n'
'4. Press the "Insert" key to open the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
),

'Marvel\'s Guardians of the Galaxy':(
 '1 - Select a version of the mod of your choice (it is recommended 0.10.3\nonwards or Uniscaler)\n'
'2 - Select the folder where the game\'s exe is located (something like\ngotg.exe)\n'
'3 - Activate Fake Nvidia GPU (if you don\'t have Rtx 3xxx/4xxx series)\n'
'4 - Inside the game, select DLSS or FSR\n'
'• If you want to use Uniscaler with the DLSS upscaler, select DLSS in\nMod Operates (the default option of Uniscaler uses the FSR upscaler)\n'
'• If the game is on Epic Games, it is necessary to disable the Overlay,\nsimply go to \'Epic Games Overlay\'.'  
),

'Marvel\'s Midnight Suns':(
'FSR 3.1.3/DLSS (Only Optiscaler) + AMD Anti Lag 2\n'
'1. Open the game and select DX12\n'
'2. Select FSR 3.1.3/DLSS (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over box\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. To use AMD Anti Lag 2, select Nvidia Reflex\n'
'7. If you are a non-RTX user and DLSS is not available in the\ngame, select "Yes" in the Anti Lag 2 window that appears\nduring installation\n'
),

'Metro Exodus Enhanced':(
'Uniscaler\n'
'1 - Select Uniscaler.\n'
'2 - Check the boxes for Fake Nvidia GPU (AMD/GTX) and\nNvapi Results (GTX). If the DLSS option is not available for\nAMD GPU, check the Nvapi Results box.\n'
'3 - In Nvngx.dll, select Default and check the box Enable\nSignature Override.\n'
'4 - In the game, select DLSS.\n\n'   

'FSR 3.1.1/DLSS\n'
'1. Select an FSR 3.1.1/DLSS mod and install it.\n' 
'2. Check the "Enable Signature Over" box.\n' 
'3. In the game, select DLSS.\n' 
'4. Press the Insert key to open the menu.\n' 
'5. Select an Upscaler of your choice, check the \'Frame Gen\'\nand "Hud Fix" boxes.\n' 
'6. If you cannot see DLSS in the game, go back to the Utility\nand check the "Disable Signature Over" box.\n\n'

'1. Install ReShade\n'
'2. Inside ReShade, select the game’s .exe and click next\n'
'3. Select DX 10/11/12 and click next\n'
'4. Click "Browse" and locate the file DefinitiveEdition.ini\nthat was installed in the folder selected in the Utility and\nclick Next\n'
'5. In the game, press the Home key to open the menu and\nselect the options you prefer\n'
'6. Install the Preset first and then the FSR3 mod if you plan\nto use it'
),

'Microsoft Flight Simulator 2024':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, press the "Insert" key to open the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
),

'Monster Hunter Rise':(
'1 - Select a mod of your choice. (recommended 0.10.3)\n'
'2 - Check the box Fake Nvidia GPU.\n'
'3 - If you don\'t see any differences, check the box\nNvapi Results.\n'
'4 - To fix flickering in the hud, activate DLSS and play for a\nfew seconds, then return to the menu and deactivate DLSS.'
),

'Mortal Shell':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Open the game and select DX12\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler), select the\npath MortalShell\\Dungeonhaven\\Binaries\\Win64 and install\n'
'3. Check the Enable Signature Over box\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. Select FSR 3.x to use FSR 3.1.3'
),

'Ninja Gaiden 2 Black':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over\n'  
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'  
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'  
'5. DLSS4, check the FSR 3.1.3/DLSS (Only Optiscaler)\nguide to see how to use it.\n'  
),

'Nobody Wants To Die':(
'1 - Select Uniscaler FSR 3.1\n'
'2 - For AMD/GTX users: Check the boxes for Fake Nvidia\nGPU, Ue compatibility Mode, Nvapi Results and Disable\nSignature Over.'
),

'Orcs Must Die! Deathtrap':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.'
),

'Outpost Infinity Siege':(
'1. Select a mod of your preference; (0.10.3 is recommended)\n'
'2. Check the box Fake Nvidia GPU (AMD/GTX).\n'
'3. In the game, select DLSS and Frame Generation.\n'
'4. If you have any issues, in Nvngx.dll, select Default.'   
),

'Pacific Drive':(
'1 - Select a mod of your preference, (0.10.3 is recommended)\n'
'2 - Check the box Fake Nvidia GPU (AMD/GTX).\n'
'3 - If you have any issues, in Nvngx.dll, select Default.'  
),

'Palworld':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Install in the Palworld\\Content\\Pal\\Binaries\\WinGDK or 64\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'3. Check the Enable Signature Over box\n'  
'4. In the game, select DLSS and press the "Insert" key to open\nthe menu\n'  
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n' 
'6. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.\n\n'

'Others Mods\n'
'(0.10+ and Uniscaler), simply enable the fake Nvidia GPU\n(for AMD and GTX) and UE Compatibility mode (for AMD)\n\n'
'Palworld Build03\n'
'1. Select Palworld Build03 and locate the game folder with the\nending binaries/win64 and see if the executable with the ending\nWin64-shipping.exe is present.\n'
'• Currently, the mod only works on Steam versions and \nalternative versions with Steam files.\n\n' 

'Steam: Library > Game > Gear icon to the right of\nAchievements > Properties > Launch Options, add -dx12.\n' 
'For Xbox Game Pass/Microsoft Store, DX12 does not need to\nbe enabled during installation.\n'

'It is not recommended to use mods in online mode.'
),

'Path of Exile II':(
'The consequences of using this mod in online games are\nunknown, use at your own risk.\n\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. Select Nvidia Reflex to use AMD Anti Lag 2.\n'
'5. In the menu, check the Frame Gen and Hud Fix boxes'
),

'Ratchet and Clank':(
'1 - Select a mod of your preference (0.10.3 is recommended,\nbut you can also try with Uniscaler).\n'
'2 - If you encounter any issues, select Replace DLSS FG in\n\'Mod Operates\'.\n'
'3 - In the initial configuration screen, select Frame\nGeneration and FSR.\n'
'4 - In the game, turn off Frame Generation and then turn it\nback on again.'    
),

'Ready or Not': (
'1 - Select a version of the mod of your choice (version\n0.10.3 is recommended).\n'
'2 - Select the game folder that has the ending\n"\\ReadyOrNot\\Binaries\\Win64".\n'
'3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n'
'4 - Set Anti-Aliasing to High or Epic + FSR2 Quality\n(DLSS won\'t work with UI flickering fix).\n'
'5 - UI flickering fix: Change Anti-Aliasing from Epic or High\nto Medium.\n'
'After launching the game again, you need to set\nAnti-Aliasing back to High or Epic to activate the mod before\nplaying the character.'
),

'Red Dead Redemption':(
'Frame Generation\n'
'1. Select an FSR3.1.1/DLSS mod (FSR 3.1.1/DLSS Custom\nis recommended) and install it.\n'
'2. In the game, disable Vsync, triple buffering, and enable\nNvidia Reflex and Frame Generation.\n'
'3. During the installation, a window labeled "Enable"\nwill appear. Only check "Yes" if the mod does not work.\n'
'4. If you are using Frame Generation with ReShade,\npress the Home key and uncheck the "MXAO" and "SSR"\noptions, This will remove the game glitches.\n\n'

'Preset\n'
'1. Install ReShade\n'
'2. In ReShade, select RDR.exe\n'
'3. Select DirectX 10/11/12\n'
'4. Click "Browse" and locate the file\nRed Dead Redemption.ini that was installed in the\ndestination folder selected in the Utility\n'
'5. Finish the installation and open the game\n'
'6. In the game, press the "Home" key to open the menu and\nselect the graphic options you prefer.\n'
'7. It is recommended to use version 6.3.1 as the newer\nversions cause significant FPS loss.'

),

'Red Dead Redemption 2':(
'FSR 3.1.3/DLSS FG Custom RDR2\n'
'1. Disable Vsync, Triple Buffering, select Borderless Windowed, and run in DirectX 12.\n'
'2. Select FSR 3.1.3/DLSS FG Custom RDR2 and install.\n'
'3. Check the Enable Signature Over box.\n'
'4. In the game, select DLSS and press the "Insert" key to open the menu.\n'
'5. In the menu, check the Frame Gen and HUD Fix boxes.(The game may crash. If the crashes\ncontinue, use the RDR2 Mix to use the FG.)\n'
'6. If you want to use FSR 3.1.3, select FSR 3x in "Upscalers."\n'
'7. Close MSI Afterburner, or the game may crash\n\n'

'Red Dead Redemption 2 MIX\n'
'1 - Set the game to DX12 in advanced options.\n'
'2 - Turn off Triple Buffering and Vsync, and set the game to Full Screen.\n'
'3 - Select the RDR2 Mix mod and install it.\n'
'4 - You don\'t need to use any upscaler, as Frame Generation is automatically activated.\nHowever, if you want to use an upscaler, when installing, check the Addon Mods box,\nselect Optiscaler, and below in DX11 select FSR 2.1 DX11, and in DX12 select FSR 2.1\nDX12.\n\n'

'RDR2 FG Custom\n'
'1. Select an upscaler, disable Triple Buffering, Vsync, and set the game to DX12 before\ninstalling the mod\n'
'2. Select RDR2 Custom FG and install\n'
'3. In the game, press the "END" key to open the menu.\n'
'4. In the menu, select Frame Gen'
),

'Remanant II':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, check the Frame Gen, Hud Fix and FG\nExtended boxes.\n'
'5. Select FSR 3x to use FSR 3.1.3\n'
'6. If you want to update DLSS, select "Others Mods\nRemnant II", do this before installing the mod.\n'
'7. It is not recommended to enable the game\'s Frame Gen\nalong with the mod\'s FG, the game may crash'
),

'Resident Evil 4 Remake':(
'1. Select the game root folder (RESIDENT EVIL 4 BIOHAZARD RE4)\n'
'2. Disable FSR in the game.\n'
'3. Select FSR 3.1.3/DLSS RE4 Remake and install.\n'
'4. In the game, select DLSS in the Reframework menu, close the window\n(press the Home key), and press the "Insert" key to open the menu.\n'
'5. In the menu, check the Render Presets Override box and select Preset K\nfor the DLSS quality mode you are using. For example, if you are using DLSS\nin Quality mode, select Preset K in the Quality Preset menu. If you selected\n"Yes" in the "DLSS Overlay" window during installation, you will be able to see\nif Preset K is selected. The overlay appears in the bottom-left corner. (Only RTX)\n'
'6. For non-RTX GPUs, select FSR or XESS in the menu.\n' 
'7. Do not select the game\'s native FSR, or the game may crash.\n'
'8. The game HUD might experience slight flickering.'
),

'Returnal':(
'Default Mod\n'
'1 - Choose a version of the mod you prefer (version 0.10.3\nis recommended).\n'
'2 - Enable the \'Enable Signature Override\' checkbox if the\nmod doesn\'t work.\n'
'3 - Select \'Default\' in Nvngx.dll.\n\n'

'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press "Insert" key\nto open the menu\n'
'4. In the menu, check the Frame Gen and Hud Fix boxes.'
),

'Rise of The Tomb Raider':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'2. Check the "Enable Signature Over" box\n'
'3. To update DLSS in the game, check the "Nvngx.dll" box and select DLSS 4\n'
'4. Open the game, in the configuration menu that appears when the game starts,\nselect DX12 and DLSS if available (if DLSS does not appear in this menu, select it\nwithin the game)\n'
'5. In the game, press the "Insert" key to open the menu\n'
'6. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'

'Others Mods\n'
'1 - Select a version of the mod of your choice (it is recommended 0.10.3\nonwards or Uniscaler)\n'
'2 - Select the folder where the game\'s exe is located (something like\nROTTR.exe)\n'
'3 - Activate Fake Nvidia GPU (if you don\'t have Rtx 3xxx/4xxx series)\n'
'4 - Inside the game, select DLSS as desired, to remove the flickering\nfrom the HUD, select SMAA as Anti Aliasing (this will slightly decrease\nfps)\n'
'• To use Uniscaler, it is necessary to select the \'DLSS\' option in\nMod Operates\n'
'• If the game is on Epic Games, it is necessary to disable the Overlay,\nsimply go to \'Epic Games Overlay\'.'
),

'Ripout':(
'1 - Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Check the box Fake Nvidia GPU (AMD/GTX).\n'  
'3 - In the game, select DLSS and Frame Generation'  
),

'Saints Row':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select FSR 2 and press "Insert" key\nto open the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'

'Default Mods\n'
'1 - Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Choose the path for the overlay, under Epic Games\nOverlay, and select "Disable".\n'
'3 - Start the game in DX12.\n'
'4 - Inside the game, select FSR.\n\n'
),

'Scorn':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select FSR and press "Insert" key to open\nthe menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. If the game crashes when installing the mod, remove the\nmod, open the game, disable FSR, and install the mod\nagain.'
),

'Sengoku Dynasty':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended'
),

'Shadow Warrior 3':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. In the game, select DLSS and press the insert key to open\nthe menu\n'  
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'Steam: Library > Game > Gear icon to the right of Achievements\n> Properties > Launch Options, add -dx12.\n'  
'Others: Go to the game\'s .exe > Properties and add -dx12 after\nthe .exe.\n\n'  

'Others Mods\n'
'1 - Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Inside the game, select FSR. (You can use it with DLSS\nbut there might be flickering).\n'
'3 - Set Ambient Occlusion and Post Processing to Low.' 
),

'Sifu':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install.\n'
'2. Check the Enable Signature Over box.\n'
'3. In the game, select DLSS and press the Insert key to open\nthe menu.\n'
'4. In the menu, select FSR 3x and apply. Select FG Enabled,\nActive, Hud Fix and Extended. If you are an RTX user, you can\nselect DLSS again if desired.\n'
'5. The step above is required for the FG + Hud Fix to work.\nYou can try enabling Hud Fix directly, but the game will likely\ncrash.\n'
'6. If you want to update the game\'s upscalers, it is\nrecommended to do so before installing the mod. Simply\nselect "Others Mods Sifu" to update.'
),

'Silent Hill 2':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over\n'
'3. In the game, select DLSS and press the "Insert" key to open the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and Extended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only Optiscaler) guide to see how to use it.\n\n'

'FSR3 Native \n'
'1. Select FSR3 FG Native SH2 and install it.\n'
'2. In-game, select FSR 3.0 before starting the campaign.\n'
'3. Select "Yes" in the "GPU" window that will appear. (Only RX 500/5000 and GTX\n\n'

'DLSS FG RTX\n'
'1. Select DLSS FG RTX and install\n'
'2. In the game, select DLSS and press the Home key to open the menu\n'
'3. Press "*" to enable FG or enable it through the menu\n\n'

'Ultra Plus\n'
'1. Install the mod and open the game\n'
'2. In the game, select a graphic preset from the game itself: low/medium/high/epic\n'
'3. Select FSR3 to use the native Frame Gen. If you don\'t see a change in FPS, go back to\nthe Utility and install "FSR3 FG Native SH2."\n'
'4. To get the full performance from the mod, select Xess Ultra Quality. (This option is\nvery demanding, and you may experience a significant FPS drop.)\n'
'5. Lock the game\'s FPS to half of your monitor\'s Hz minus 2, for example (60Hz, lock\nat 28), or lock it to the average FPS you get in the game.\n'
'6. This mod works with FSR 3.1.1/DLSS (Optiscaler or Custom); just install and follow the\nFSR 3.1.1/DLSS guide above.\n\n'

'Ultra Plus Optimized\n'
'It is recommended for RX 500/5000 and GTX users\n'
'Includes some graphical optimizations\n\n'

'Ultra Plus Complete\n'
'This is the standard version of the mod with all available modifications\n\n'

'Some of the modifications\n'
'Reduces black spots, Improves Ray Tracing quality, Enhances anisotropic filtering,\nReduces hair pixelation caused by MSAA\n\n'

'Others Mods Sh2 \n'
'Run the game in DirectX 12 for the mods to work\n'
'Unlock FPS Cutscenes\n'
'Removes the 30fps lock from cutscenes.\n\n'

'Post-Processing\n'
'Remove: Scene Color Fringe, Motion blur and Distortion'
),

'Six Days in Fallujah':(
'1. Select SixDays\\Binaries\\Win64\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over box\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. If you want to update DLSS, select "Others Mods 6Days"\nand install, do this before installing the main mod.'
),

'Smalland':(
'1 - Select a mod of your choice. (0.10.3 is recommended)\n'
'2 - Check the Fake Nvidia GPU box. (AMD/GTX)\n'
'3 - In the game, select DLSS'    
),

'Soulslinger Envoy of Death':(
'FSR 3.1.3/DLSS (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
),

'Soulstice':(
'FSR 3.1.3/DLSS (Only Optiscaler)\n'
'1. Run it in DX12. Right-click the game\'s exe and create a\nshortcut, then right-click the shortcut again, go to Properties,\nand at the end of Target (outside the quotes), add -dx12 or\ngo to your Steam library, select the game, go to Settings >\nProperties > Startup options, and enter -dx12.\n'
'2. Select FSR 3.1.3/DLSS (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over box\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. To update the DLSS, select "Others Mods STC"; do this\nbefore installing the mod'
),

'Spider Man/2/Miles':(
'FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSSG FG (Only Optiscaler) and install\n'  
'2. In the game, select DLSS, Frame Gen and press the "Insert" key\nto open the menu\n'  
'3. Check the FSR 3.1.3/DLSS (Only Optiscaler) guide to see how to\nuse DLSS 4. (Only RTX)\n'  
'4. If you have a non-RTX GPU, select FSR or Xess in the mod menu.\n' 
'5. Select FSR 3x to use FSR 3.1.3\n'
'6. Select the game\'s DLSS Frame Gen before starting the campaign.\nIf you start the campaign without selecting it, only the FSR3 Frame\nGen will be available (Only RTX).\n\n'

'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. When launching the game, select DLSS in the initial settings\nmenu. If that\'s not possible, select it in-game.\n'  
'4. In the game, press the "Insert" key to open the menu\n' 
'5. In the menu, select FG Enabled, Active, Hud Fix and Extended\n' 
'6. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only Optiscaler)\nguide to see how to use it.(Spider 2 is not necessary, only RTX)\n'
'7. You can also use the game\'s native FG along with the mod\'s\nupscalers. Simply select an upscaler in the mod and enable FG in\nthe game. (Uncheck any box you have enabled).\n\n'

'It is recommended to use FSR 3.1.3/DLSSG (Only Optiscaler).\nFSR 3.1.3/DLSSG (Only Optiscaler) works well but may cause\ncrashes when using the mod\'s FG.'
),

'S.T.A.L.K.E.R. 2':(
'Disable any upscaler/FG in the game before installing the\nmod.\n'
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. If you want to update the DLSS, select "Others Mods\nStalker 2", do this before installing the mod.\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'3. Check Enable Signature Over box\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n\n'

'FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSSG FG (Only Optiscaler) and install\n'  
'2. Check "yes" in the "DLSS/FSR" window that will appear\nduring installation.\n'
'3. In the game, select DLSS, Frame Gen and press the\n"Insert" key to open the menu\n'  
'4. Check the FSR 3.1.3/DLSS (Only Optiscaler) guide to see\nhow to use DLSS 4. (Only RTX)\n\n'

'Preset\n'
'1. Install ReShade\n'
'2. Inside ReShade, select the game’s .exe and click next\n'
'3. Select DX 10/11/12 and click next\n'
'4. Click "Browse" and locate the file Stalker2 REAL LIFE.ini\nthat was installed in the folder selected in the Utility and\nclick Next\n'
'5. In the game, press the Home key to open the menu and\nselect the options you prefer\n'
),

'Star Wars: Jedi Survivor':(
'DLSS Jedi (if you have RTX, use this mod if you want to use\nnative DLSS)\n'
'1 - Check the box Fake Nvidia GPU (GTX and AMD), Nvapi\nResults (GTX and AMD), and UE Compatibility (AMD)\n'
'2 - If you can\'t see DLSS in-game, select "DLSS" under\n"Mod Operates"\n'
'3 - In-game, select DLSS 3 and Frame Gen\n\n'

'ALL GPUs\n'
'1. Select Uniscaler FSR 3.1.\n'
'2. Check the "Enable Signature Over" box.\n'
'3. If you cannot see DLSS in the game, check the Nvngx.dll\nbox, select Default, and reinstall the mod.\n'
'4. If you have an RTX GPU and want to use native DLSS,\nselect DLSS in "Mod Operates." Other GPUs can use\nFSR 3.1/XESS.\n'
'5. In the game, select DLSS FG.\n\n'

'Others Mods\n'
'Intro Skip\n'
'Removes the initial intro when opening the game.\n\n'

'Anti Stutter\n'
'1. Faster Loading Times\n'
'2. Enhanced Streaming and Level Loading\n'
'3. Optimized CPU and GPU Utilization\n\n'

'Fix RT\n'
'Fixes any crashes you experience with ray tracing\nenabled and also fixes occlusion culling. When you turn the\ncamera and see white flashing at the corners of the screen,\nthis resolves it and any crashes.\n\n'

'Graphic Preset\n'
'1. Install ReShade\n'
'2. In ReShade, select Star Wars Jedi: Survivor\n'
'3. Select DirectX 10/11/12\n'
'4. Click "Browse" and locate the file\nSTARWAR-ULTRA-REALISTA.ini that was installed in the\ndestination folder selected in the Utility\n'
'5. Finish the installation and open the game\n'
'6. In the game, press the "Home" key to open the menu and\nselect the graphic options you prefer.'
),

'Star Wars Outlaws':(
'RTX\n'
'1 - Select Star Wars DLSS RTX and install\n'
'2 - Inside the game, select DLSS and Frame Gen\n\n'

'All GPUs\n'
'1 - Select FSR 3.1.1/DLSS Optiscaler\n'
'2 - Inside the game, select an upscaler of your choice.\n'
'3 - Press the Insert key to open the menu and select an\nupscaler of your choice.\n\n'

'Graphic Preset\n'
'1 - Install the mod and the ReShade application\n'
'2 - In ReShade, select b1.exe, DirectX 10/11/12,\nclick on \'Browser\', and find the file Outlaws2.ini (the path\nshould look something like Star Wars Outlaws\\Outlaws2.ini)\nand select it, then click on \'Uncheck All\' and \'Next\'.\n'
'3 - In the game, press the \'Insert\' key to open\nthe menu and check the options you want.\n\n'
),

'Sackboy: A Big Adventure':(
'1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n'
'2 - Select the game folder that has the ending\n"\\GingerBread\\Binaries\\Win64".\n'
'3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n'
'4 - In "Mod Operates", select "Replace Dlss FG".\n'
'5 - Select \'Default\' in Nvngx.dll\n'
'6 - Enable the "Enable Signature Override" checkbox if the\nmod doesn\'t work.\n'
),

'Shadow of the Tomb Raider':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install.\n'
'2. Check the Enable Signature Over box.\n'
'3. In the game, Select DLSS and press the Insert key to open the menu.\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n\n'

'Uniscaler V3\n'
'1 - Select Uniscaler V3\n'
'2 - In Mod Operates, select XESS, and in Frame Gen Method, select FSR3\n'
'3 - If you don\'t have an RTX GPU, check the Nvngx.dll box and select Default\n'  
'4 - In the game, turn off Anti-Aliasing and set XESS to Quality\n'  
'5 - To fix the HUD error, go to settings after completing the step above, turn off XESS, and select\nSMAA in Anti-Aliasing.'

),

'Steelrising':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and enter the campaign\n'
'4. In the campaign, press the "Insert" key to open the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. Select FSR 3.x to use FSR 3.1.3\n\n'

'Default Mods\n'
'1 - Choose a version of the mod you prefer (version 0.10.3 is\nrecommended).\n'
'2 - Enable Fake Nvidia GPU (only for AMD and GTX).\n'
'3 - Enable NVAPI Results (only for GTX).\n'
'4 - In Mod Operates, select Enable Upscaling Only.\n\n'
'● To fix the Hub Flickering, do not select any option in Mod\nOperates, open the game, and choose FSR 1.0.'
),

'Suicide Squad: Kill the Justice League':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select the .exe path. (Stones\\Binaries\\Win64)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'3. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'4. The game may crash the first time the mod is installed.'
),

'TEKKEN 8':(
'1 - Select Uniscaler V3\n'
'2 - If you want to use DLSS, check the Fake Nvidia GPU box\n'
'3 - Check the Nvngx.dll box and select Default\n'
'4 - To fix the HUD error, test all the Upscalers in-game and\nsee which one works best for you.\n\n'

'Unlock FPS\n'
'1 - Unlock FPS cannot be used alongside FSR3 mod.\n'
'2 - Select Unlock FPS under Mod Version and install it.\n'
'3 - Open the game and select an upscaler.\n'
'4 - Go to the selected folder in Select Folder and run\nTekkenOverlay.exe (with the game open).'
),

'Test Drive Ultimate Solar Crown':(
'1. Select Uniscaler FSR 3.1\n'
'2. Check the box "Enable Signature Over"\n'
'3. In-game, select DLSS FG\n'
'4. If you can\'t see DLSS in the game, check the "Nvngx.dll"\nbox, select "Default," and install again.'
),

'The Ascent':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. In the game, select DLSS and press the insert key to\nopen the menu\n'  
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'  
),

'The Callisto Protocol':(
'FSR 3.1.3/DLSS Custom Callisto and Optiscaler\n'
'1. Select FSR 3.1.3/DLSS Custom Callisto or Optiscaler and Install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select FSR 2 and press the "Insert" key to open the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. Disable MSI Afterburner\n\n'

'The Callisto Protocol Fsr3\n'
'1. Select The Callisto Protocol Fsr3\n' 
'2. Check the Fake Nvidia GPU box and install.\n\n'

'Uniscaler V3\n'
'1 - Select Uniscaler V3\n'
'2 - Check the Nvngx box and select Default\n'
'3 - Check the Enable Signature Over box\n\n'

'0.10.4\n'
'1 - Select 0.10.4 and install it.\n'
'2- Inside the game, select FSR 2 and start the campaign.\n'
'3 -If Frame Gen doesn\'t work, check the "Nvngx.dll" box and select "Default," then check the "Enable Signature\nOverride"\nbox. For Epic Games users: if the mod doesn\'t work or some\nbugs appear, check the "Disable Overlay" box.\n\n'

'HUD Correction (FSR 3.1.3/DLSS is not necessary.)\n'
'Select FSR2 and start the campaign, play for a few seconds, and return to the menu. In the menu, select Temporal\nand return to the campaign.\n\n'

'Real Life\n'
'Adds more detail to the world making them wood effects stand out more as well as the ground, lighting, walls and\ndirt marks, and skin.\n\n'

'TCP\n'
'A ReShade config that implements duller colours, nearby sharpness and distant depth of field blur to give a grittier\nand more cinematic style to emphasise the sci-fi horror atmosphere.\n\n'

'1 - Install the ReShade application\n'
'2 - Select DirectX 10/11/12, click \'Browse\' and select the TCP.ini file that was installed in the destination folder\nchosen in the Utility.\n'
'3 - Click \'Uncheck All\' and then click \'Next\'.\n' 
'4 - Do the same for the Real Life mod.'
),

'The Casting Of Frank Stone':(
'FSR 3.1.2/DLSS FG Custom\n'
'1. Select \'FSR 3.1.2/DLSS FG Custom\' install it, and check\nthe GPU window that appears.\n'
'2. In the game, select DLSS and Frame Generation.\n'
'3. If you want to use FSR 3.1, press the "Insert" key to open\nthe menu and select FSR 3.1.\n\n'

'0.10.4\n'
'1. Select 0.10.4 and install it.\n'
'2. In the game, select DLSS and Frame Generation.\n'
'3. If you can\'t see DLSS in the game, check the Nvngx.dll\nbox and select "Default."\n\n'

'Optiscaler FSR 3.1/DLSS\n'
'1. Select \'Optiscaler FSR 3.1/DLSS\' and install it.\n'
'2. In the game, select DLSS and Frame Generation.\n'
'3. If you want to use FSR 3.1, press the "Insert" key to open\nthe menu and select FSR 3.1.'
),

'The Chant':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Enable Fake Nvidia Gpu, if Frame Generation is not\ndetected, enable Nvapi Results. (only Amd and Gtx)'  
),

'The First Berserker: Khazan':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Open the game and select DX12 in the menu\n'  
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'3. Check the Enable Signature Over box\n'  
'4. In the game, select DLSS and press the "Insert" key to open\nthe menu\n'  
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'  
'6. Select Nvidia Reflex to use AMD Anti Lag 2.\n(Option available only if you selected "Yes" in the "Anti Lag 2"\nwindow that appears during installation.)\n'  
'7. To update the DLSS, select "Others Mods TFBK"; do this\nbefore installing the mod\n'
'8. If you are unable to enable the game\'s DLSS Frame Gen,\nselect "Yes" in the "Anti Lag 2" window that appears during\ninstallation. (Only for the FSR 3.1.3/DLSSG mod)'
),

'The Invicible':(
'1 - Select a mod of your preference (0.10.3 is recommended,\nbut if it doesn\'t work, try older versions such as 0.7.6 and\ncheck the lfz.sl.dlss box)\n'
'2 - In the game, select FSR or DLSS if the mod is not active.'    
),

'The Last Of Us':(
'FSR 3.1.3/DLSSG FG (Only Optiscaler)\n'   
'1. This mod uses the game\'s native FG.\n'  
'2. Select FSR 3.1.3/DLSSG FG (Only Optiscaler) and install\n'  
'3. Check Enable Signature Over box\n'  
'3. In the game, select FSR3, Frame Gen, and press the\n"Insert" key to open the menu\n'  
'4. It’s possible that the game may crash when selecting\nFSR FG; just open it again.\n'
'5. In the menu, select FSR 3.x to use FSR 3.1.3; if you have\nan RTX, select DLSS to use DLSS 4.\n'  
'6. To update DLSS, select "Others Mods Tlou"; do this\nbefore installing the mod.\n'
'7. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it. (Game version 1.1.4.)'
),

'The Medium':(
'1- Select a mod of your choice (0.10.3 is recommended)\n'
'2- Check the Fake Nvidia GPU (AMD/GTX) and Nvapi Results\n(GTX) boxes. If the mod doesn\'t work on an AMD GPU, also\ncheck Nvapi Results.'
'3- Run the game in DX12. During\ninstallation, a window will appear to create a DX12 shortcut,\nyou can accept this or do it manually.'    
),

"The Outer Worlds: Spacer's Choice Edition":(
'1 - Select a mod of your preference (0.10.3 or Uniscaler is\nrecommended).\n'
'2 - Within the game, select Fsr.\n'
'3 - To fix the HUD flickering, play for a few seconds, return to the\nmenu, and deactivate Fsr. (This will slightly decrease FPS).'  
),

'The Talos Principle 2':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.'
),

'The Thaumaturge':(
'1 - Select a version of the mod of your choice (it is recommended 0.10.3\nonwards or Uniscaler)\n'
'2 - Select the folder where the game\'s exe is located.\n'
'3 - Activate Fake Nvidia GPU (if you don\'t have Rtx 3xxx/4xxx series)\n'
'4 - Inside the game, select DLSS.\n'
'• To use Uniscaler, it is necessary to select the \'DLSS\' option in\nMod Operates\n'
'• If the game is on Epic Games, it is necessary to disable the Overlay,\nsimply go to \'Epic Games Overlay\'.'
),

'Thymesia':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.'
),

'The Witcher 3':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Install the mod in the "x64_dx12" folder\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over box\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. DLSS4, see the Optiscaler FSR 3.1.3/DLSS (Only\nOptiscaler) guide to see how to use it.\n\n'

'Uniscaler V4\n'
'1 - Select Uniscaler V4 and install\n'
'2 - For AMD/GTX users: Check the boxes: Fake Nvidia GPU,\nand Enable Signature Over.\n'
'3 - In the game, select DLSS and Frame Gen boxes.'    
),

'Unknown 9: Awakening':(
'1. Select Uniscaler V4 and install it.\n'
'2. In the game, select an option under Upscaling Quality.\n'
'3. Check the box Enable Signature Override\n'
'4. You can also select XESS in "Mod Operates", it has\nbetter quality, but it\'s optional.\n'
'5. This game does not yet have a fix for the HUD.\n'
),

'Uncharted':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'  
'2. Check the Enable Signature Over box\n'  
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'  
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'  
'5. Close Afterburner, or the game will crash\n\n'

'Others Mods\n'
'1 - Select a mod of your preference (0.10.3 is recommended).\n' 
'2 - Run the game using the u4-l.exe executable. The game\nmay crash the first time, so just run it again.\n'
'3 - Inside the game, select FSR.'
),

'Until Dawn':(
'FSR 3.1.2/DLSS FG Custom / Optiscaler\n'
'1. Select FSR 3.1.2/DLSS FG Custom or Opsticaler and\ninstall it\n'
'2. In the game, select DLSS and press the "Insert" key\nto open the menu\n'
'3. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'4. You can also use the game\'s Frame Generation after\nselecting an upscaler in the menu'
),

'Wanted Dead':(
'1 - Select a mod of your choice. (0.10.3 is recommended)\n'
'2 - In the game, select FSR.'    
),

'Warhammer: Space Marine 2':(
'FSR 3.1.3/DLSS FG Marine\n'
'1. Select FSR 3.1.3/DLSS FG Marine and install\n'
'2. In the game, select DLSS, Frame Gen, and press the\n"Insert" key to open the menu\n'
'3. In the menu, select FSR 3x to use the FSR 3.1.3\n\n'

'FSR 3.1.2/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'3. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'

'Uniscaler FSR 3.1\n'
'1 - Check the "Fake NVIDIA GPU" box if you want to use\nDLSS.\n'
'2-  Check the \'Enable Signature Over\' box.\n'
'3 - This mod does not have a HUD fix, as frame generation\nis activated along with the mod.\n\n'

'Graphic Preset\n'
'1. Install ReShade\n'
'2. In ReShade, select Warhammer: Space Marine 2\n'
'3. Select DirectX 10/11/12\n'
'4. Click "Browse" and locate the file Warhammer 40000\nSpace Marine 2.ini that was installed in the destination\nfolder selected in the Utility\n'
'5. Finish the installation and open the game\n'
'6. In the game, press the "Home" key to open the menu and\nselect the graphic options you prefer.'
),

'Watch Dogs Legion':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Open the game and select DX12 in the menu\n'
'2. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'3. Check the Enable Signature Over box\n'
'4. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'5. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'6. To update DLSS, select "Others Mods Legion"; do this\nbefore installing the mod.'
),

'Way Of The Hunter':(
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended\n'
'5. The consequences of using the mod in multiplayer are\nunknown; use at your own risk'
),

'Wayfinder':(
'FSR 3.1.3/DLSS FG (Only Optiscaler)\n'
'1. Select FSR 3.1.3/DLSS FG (Only Optiscaler) and install\n'
'2. Check the Enable Signature Over box\n'
'3. In the game, select DLSS and press the "Insert" key to\nopen the menu\n'
'4. In the menu, select FG Enabled, Active, Hud Fix and\nExtended'
),

'Uniscaler':(
'Enable frame generation in any upscaler the game has, choose\nbetween the 3 options FSR3, DLSS, and XESS. If the game\nsupports one of these 3 upscalers, simply select one of these\noptions in "Mod Operates".\n\n'
'Even if the game does not have support for one of the 3\nupscalers, it is possible to activate them by selecting the\nupscaler in "Mod Operates".\n\n'
'AMD GPU users may need to select the \'Nvngx: Default\'\noption and activate \'Enable Signature Override\'.\nPlease perform these steps if the mod does not work on your\ndefault version.'
),

'XESS/DLSS':(
'1 - Select Uniscaler in Mod Version (you can try using it with other mod versions\nbut you will likely encounter an error)\n'
'2 - Check the NVNGX box and select XESS 1.3 or DLSS 3.8.10. For some games\nlike The Callisto Protocol, for example, it will '
'be necessary to select \'Default\' in\nNVNGX. Then, you can select \'Default\' in NVNGX and choose any option in Mod\nOperates and install. '
'After pressing install, a window will appear to confirm the\ninstallation of XESS/DLSS. This way, you can install the default Nvngx from\nUniscaler and XESS/DLSS together without needing to perform 2 installations.\n'
'3 - If the game has a default Xess/Dlss file, this file is modified to serve as a\nbackup. If you want to remove the installed Xess/Dlss and revert to the old\nversion, just check the \'Cleanup Mod\' checkbox and confirm the deletion window\nthat appears.'  
)
}   
    game_dimensions = {
    '685x430': ['Red Dead Redemption 2'],
    '530x260': ['Dead Space Remake', 'Uniscaler', 'F1 2022', 'F1 2023'],
    '550x260': ['Hozizon Zero Dawn'],
    '560x680': ['Hogwarts legacy'],
    '740x270': ['Shadow of the Tomb Raider'],
    '573x260': ['Horizon Forbidden West'],
    '650x420': ['Rise of The Tomb Raider'],
    '590x260': ['The Thaumaturge', 'Marvel\'s Guardians of the Galaxy'],
    '600x260': ['Dragons Dogma 2', 'Ghostrunner 2', 'Martha Is Dead'],
    '730x400': ['Elden Ring'],
    '730x280': ['Fallout 4'],
    '850x260': ['Initial Information'],
    '533x465': ['Palworld'],
    '520x305': ['TEKKEN 8'],
    '690x260': ['Icarus'],
    '735x660': ['Hellblade 2'],
    '620x790': ['Add-on Mods', 'Black Myth: Wukong'],
    '565x490': ['Spider Man/2/Miles'],
    '520x320': ['Ghost of Tsushima', 'The Witcher 3'],
    '550x750': ['Cyberpunk 2077'],
    '830x720': ['The Callisto Protocol'],
    '520x330': ['Star Wars Outlaws'],
    '520x720': ['Star Wars: Jedi Survivor'],
    '520x350': ['The Casting Of Frank Stone', 'Lies of P'],
    '540x420': ['Death Stranding Director\'s Cut'],
    '520x400': ['Red Dead Redemption', 'Assassin\'s Creed Mirage'],
    '520x310': ['Dying Light 2'],
    '520x300': ['A Plague Tale Requiem'],
    '520x360': ['Ghostwire: Tokyo'],
    '540x320': ['Shadow Warrior 3', 'The First Berserker: Khazan'],
    '700x800': ['Silent Hill 2'],
    '520x520': ['Metro Exodus Enhanced'],
    '520x420': ['Atomic Heart'],
    '650x650': ['Alan Wake 2'],
    '570x720': ['Final Fantasy XVI'],
    '600x300': ['Kena: Bridge of Spirits'],
    '630x270': ['Resident Evil 4 Remake'],
    '520x520': ['Warhammer: Space Marine 2', 'S.T.A.L.K.E.R. 2'],
    '605x610': ['God of War Ragnarök'],
    '530x290': ['Sifu', 'Fort Solis'],
    '520x330': ['Steelrising', 'Eternal Strands'],
    '590x400' : ['Alone in the Dark'],
    '925x540' : ['Optiscaler FSR 3.1.3/DLSS (Only Optiscaler)'],
    '650x260': ['XESS/DLSS']
    }

    guide_text = list_game.get(select_game, "")
    for dimension, games in game_dimensions.items():
        if select_game in games:
            screen_guide.geometry(dimension)
            break
    else:
        screen_guide.geometry('520x260')
    
    if guide_label is None:
        guide_label = tk.Label(screen_guide, text="", font=('Helvetica', 10), bg='black', fg='#F0FFF0', justify='left')
        guide_label.place(x=165, y=28) 
    
    guide_label.config(text=guide_text)
    
def exit_fsr_guide():
    global screen_guide,guide_label
    
    if screen_guide:
        screen_guide.destroy()
        fsr_guide_cbox.deselect()
        screen_guide = None
        guide_label = None

def guide_fsr_guide(event=None):
    guide_fsr_label.config(text='Installation guide for specific games. To open the guide, simply click on the checkbox')
    guide_fsr_label.place(x=200,y=379)
    guide_fsr_label.tkraise()

def close_guide_fsr(event=None):
    guide_fsr_label.place_forget()
    
guide_fsr_label = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
guide_fsr_label.place_forget()

var_ignore_fg = False

new_uniscaler_path = {'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.tom',
                      'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
                  'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'}

def cbox_ignore_fg():
    global var_ignore_fg
    if select_mod in new_uniscaler_path:
        path_ini = new_uniscaler_path[select_mod]
        var_ignore_fg = bool(ignore_ingame_fg_var.get())
        key_v3 = 'general'
        
        with open(path_ini,'r') as file:
            toml_v3 = toml.load(file)
            
        toml_v3.setdefault(key_v3,{})
        toml_v3[key_v3]['ignore_ingame_frame_generation_toggle'] = var_ignore_fg
        
        with open(path_ini,'w') as file:
            toml.dump(toml_v3,file)
    else:
        ignore_ingame_fg_cbox.deselect()
        messagebox.showinfo('Uniscaler','Select Uniscaler V3 or Uniscaler FSR 3.1 to use this option.')
        return

var_ignore_fg_resources = False
def cbox_ignore_fg_resources():
    global var_ignore_fg_resources
    if select_mod in new_uniscaler_path:
        var_ignore_fg_resources = bool(ignore_ingame_fg_resources_var.get())
        path_ignore_fg = new_uniscaler_path[select_mod]
        key_v3 = 'general'
        
        with open(path_ignore_fg,'r') as file:
            toml_v3 = toml.load(file)
            
        toml_v3.setdefault(key_v3,{})
        toml_v3[key_v3]['ignore_ingame_frame_generation_resources'] = var_ignore_fg_resources
        
        with open(path_ignore_fg,'w') as file:
            toml.dump(toml_v3,file)
    else:
        ignore_ingame_fg_resources_cbox.deselect()
        messagebox.showinfo('Uniscaler','Select Uniscaler V3 or Uniscaler FSR 3.1 to use this option.')
        return

ignore_ingame_fg_label = tk.Label(screen,text='Ignore Ingame FG',font=font_select,bg='black',fg='#C0C0C0')
ignore_ingame_fg_label.place(x=0,y=326)
ignore_ingame_fg_var = IntVar()
ignore_ingame_fg_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=ignore_ingame_fg_var,command=cbox_ignore_fg)
ignore_ingame_fg_cbox.place(x=130,y=329)

ignore_ingame_fg_resources_label = tk.Label(screen,text='Ignore Fg Resources',font=font_select,bg='black',fg='#C0C0C0')
ignore_ingame_fg_resources_label.place(x=0,y=356)
ignore_ingame_fg_resources_var = IntVar()
ignore_ingame_fg_resources_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=ignore_ingame_fg_resources_var,command=cbox_ignore_fg_resources)
ignore_ingame_fg_resources_cbox.place(x=147,y=359)

path_remove_overlay_uni = {'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
              'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
              'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
              'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'}
#Disable the overlay of some launchers, such as Epic Games for example. Overlays can cause conflicts with the mod. Change the disable_overlay_blocker option in the .toml file to True or False
var_remove_over = False
def cbox_remove_overlay():
    global var_remove_over
    var_remove_over = bool(remove_overlay_var.get())
    if select_mod in path_remove_overlay_uni:
        remove_overlay()
    else:
        messagebox.showinfo('Uniscaler','Please select Uniscaler V2/V3/V4 or Uniscaler FSR 3.1 to choose this option')
        remove_overlay_cbox.deselect()
        
def remove_overlay():
    global var_remove_over
    
    if select_mod in path_remove_overlay_uni:
        path_uni = path_remove_overlay_uni[select_mod]
    
    key_1 = "general"
    
    with open (path_uni ,'r') as file:
        toml_d = toml.load(file)
        
    toml_d.setdefault(key_1,{})
    toml_d[key_1]['disable_overlay_blocker'] = var_remove_over
    
    with open(path_uni,'w') as file:
        toml.dump(toml_d,file)
          
remove_overlay_label = tk.Label(screen,text='Disable Overlay',font=font_select,bg='black',fg='#C0C0C0')
remove_overlay_label.place(x=0,y=266)
remove_overlay_var = IntVar()
remove_overlay_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=remove_overlay_var,command=cbox_remove_overlay)
remove_overlay_cbox.place(x=117,y=269)

#Creates a Backup folder if there are files identical to those of the mod  
var_copy_backup = False
def comp_files(origins_path):
    global nvngx_contr,var_copy_backup
    
    if select_mod in origins_path:
        paths_backup = origins_path[select_mod]

        try:
            files_to_copy = []
            file_path = ""

            if isinstance(paths_backup, list):
                for path_backup in paths_backup:
                    origins_backup = os.path.join(path_backup)

                    for file_backup in os.listdir(select_folder):
                        file_path = os.path.join(origins_backup, file_backup)
                        
                    if os.path.isfile(file_path):
                        files_to_copy.append(file_path)
                        var_copy_backup = True
            else:
                path_backup = paths_backup
                origins_backup = os.path.join(path_backup)

                for file_backup in os.listdir(select_folder):
                    file_path = os.path.join(origins_backup, file_backup)

                    if os.path.isfile(file_path):
                        var_copy_backup = True
                        files_to_copy.append(file_path)

            if var_copy_backup:
                backup_folder = os.path.join(select_folder, 'Backup')
                if not os.path.exists(backup_folder):
                    create_backup_folder = messagebox.askyesno('Create Backup', 'Do you want to create a backup folder and perform a backup of the original game files?')

                    if create_backup_folder:
                        os.mkdir(backup_folder)
                    else:
                        return

                if files_to_copy:  
                    for file_path in files_to_copy:
                        file_name = os.path.basename(file_path)
                        folder_backup = os.path.join(backup_folder, file_name)
                        shutil.copy(file_path, folder_backup)
        except Exception as e:
            print(e)

        create_backup_folder = None
        if var_copy_backup:
            if not os.path.exists(backup_folder):
                create_backup_folder = messagebox.askyesno('Create Backup','Do you want to create a backup folder and perform a backup of the original game files?')

                if create_backup_folder:
                    os.mkdir(backup_folder)
                elif not create_backup_folder:
                    return
            
            elif os.path.exists(backup_folder) and files_to_copy:
                copy_files = messagebox.askyesno('Copy files','Do you want to copy the files to the Backup folder?')
            elif os.path.exists(backup_folder) and not files_to_copy:
                messagebox.showinfo('Without files','No files were found to perform the backup.')
                return
            
            if create_backup_folder or copy_files:
                for path_backup in paths_backup:
                    origins_backup = os.path.join(path_backup)
                    
                    for file_backup in os.listdir(select_folder):
                        file_path = os.path.join(origins_backup, file_backup)
                        
                        if os.path.isfile(file_path):
                            folder_backup = os.path.join(backup_folder, file_backup) 
                            shutil.copy(file_path, folder_backup) 
                            
                messagebox.showinfo('Success', 'Backup completed successfully.')
                backup_cbox.deselect()
            else:
                return  

#This def also creates a Backup folder, but for specific files or games where paths are not being passed through a dictionary and it's also the execution def
def backup_files():
    global origins_2_2_folder,nvngx_folders,var_copy_backup
    unlock_view_message = False
    
    if select_mod in origins_2_2_folder:
        comp_files(origins_2_2_folder)
        unlock_view_message = False
    else:
        unlock_view_message = True
        
    if select_option == 'The Callisto Protocol':
        comp_files(callisto_origins)
        unlock_view_message = False
        
    if select_option == 'Elden Ring':
        comp_files(er_origins)
        unlock_view_message = False
    
    origins_gtav = {'GTA V FSR3/DLSS4':'mods\\FSR3_GTAV\\GtaV_B02_FSR3',
                    'GTA V FiveM':'mods\\FSR3_GTAV\\GtaV_B02_FSR3',
                    'GTA Online':'mods\\FSR3_GTAV\\GtaV_B02_FSR3',
                    'GTA V Epic':'mods\\FSR3_GTAV\\GtaV_B02_FSR3'}
    if select_option == 'GTA V':
        comp_files(origins_gtav)
        unlock_view_message = False
        
    select_nvngx_v1 = 'NVNGX Version 1'
    name_nvngx_v1 = 'nvngx.ini'
    search_nvngx = select_nvngx
    
    select_nvngx_default = 'Default'
    name_nvngx = 'nvngx.dll'
    
    select_optiscaler_file = ['nvngx.dll','libxess.dll','nvngx.ini']
    search_optiscaler = select_addon_mods
    select_optiscaler_name = 'OptiScaler'
    
    select_pw_file = ['ReShade.ini','PalworldUpscalerPreset.ini','d3d12.dll',
                     'd3dcompiler_47.dll','nvngx.dll']
    search_pw = select_mod
    select_pw_name = 'Palworld Build03'
    
    select_fl4_file = ['f4se_whatsnew.txt','f4se_steam_loader.dll','f4se_readme.txt','f4se_loader.exe','f4se_1_10_163.dll',
                    'CustomControlMap.txt']
    search_fl4 = select_mod
    select_fl4_name = 'Fallout 4 FSR3'
    
    search_spider = select_mod
     
    select_jedi_file = ['winmm.dll','winmm.ini']
    
    select_jedi_name = "Dlss Jedi"
    
    select_lotf_file = ['version.dll','RestoreNvidiaSignatureChecks.reg','nvngx.dll','launch.bat','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg',
                        'DisableEasyAntiCheat.bat','winmm.dll','winmm.ini']
    select_lotf_name = 'Lords of The Fallen FSR3'
    
    select_hfw_file = ['version.dll','nvngx.dll','dlssg_to_fsr3_amd_is_better.dll','lfz.sl.dlss.dll','winmm.dll','winmm.ini','libxess.dll']
    select_hfw_name = 'Horizon Forbidden West FSR3'
    
    select_valhalla_file = ['ReShade.ini','dxgi.dll','ACVUpscalerPreset.ini']
    select_valhalla_name = 'Ac Valhalla DLSS3 (Only RTX)'
    
    select_got_file = ['version.dll','RestoreNvidiaSignatureChecks.reg','dxgi.dll','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg','d3d12core.dll','d3d12.dll','GhostOfTsushima.exe']
    select_got_name = 'Ghost of Tsushima FG DLSS'
    
    select_hb2_file = ['version.dll','RestoreNvidiaSignatureChecks.reg','dxgi.dll','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg']
    select_hb2_name = 'Hellblade 2 FSR3 (Only RTX)'
    
    select_cb2077_file = ['nvngx.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll']
    select_cb2077_name = "RTX DLSS FG"

    select_dd2_file =  ['amd_fidelityfx_dx12.dll', 'amd_fidelityfx_vk.dll','dinput8.dll','dxgi.dll' 'libxess.dll', 'nvapi64-proxy.dll', 'nvngx-wrapper.dll', 'nvngx.dll', 
    'nvngx.ini', 'openvr_api.dll', 'openxr_loader.dll','_nvngx.dll']
    select_dd2_name = "FSR 3.1/DLSS DD2 ALL GPU"

    select_dd2_nv_file = ['amd_fidelityfx_dx12.dll', 'amd_fidelityfx_vk.dll','dinput8.dll', 'dxgi.dll', 
    'libxess.dll', 'nvngx-wrapper.dll', 'nvngx.dll', 'nvngx.ini', 'openvr_api.dll', 'openxr_loader.dll', 
    'unins000.dat', 'unins000.exe']

    select_dd2_nv_name = 'FSR 3.1/DLSS DD2 NVIDIA' 

    def search_dll_files(name_file_select,name_file,select_option_search):
        backup_folder = os.path.join(select_folder, 'Backup')

        try:               
            if select_option_search == name_file_select:
                file_nvngx = os.listdir(select_folder)
                files_copied = 0
                
                for nvngx_file in file_nvngx:
                    if nvngx_file == name_file:
                        source_path = os.path.join(select_folder, name_file)
                        destination_path = os.path.join(backup_folder, name_file)

                        if not os.path.exists(backup_folder):
                            os.makedirs(backup_folder)
                        
                        shutil.copy(source_path, destination_path)
                        files_copied += 1
                        
                if files_copied > 0:
                    return True   
        except Exception:
            messagebox.showinfo('Error','Failed to create the backup, please try again.')

    view_message = False
    sucess_message = None
    if unlock_view_message:
        view_message = messagebox.askyesno('Copy files', 'Would you like to copy the files to the Backup folder? If it doesn\'t exist, one will be created at the root of the game.')
    
    if view_message:    
        if nvngx_contr:
            if select_nvngx == 'Default':
                sucess_message = search_dll_files(select_nvngx_default,name_nvngx,search_nvngx)
            elif select_nvngx == 'NVNGX Version 1':
                sucess_message = search_dll_files(select_nvngx_v1,name_nvngx_v1,search_nvngx)
        
        if addon_contr:
            if select_addon_mods == 'OptiScaler':
                for name_file_optiscaler in select_optiscaler_file:
                    sucess_message = search_dll_files(select_optiscaler_name,name_file_optiscaler,search_optiscaler)

        if select_mod == 'Palworld Build03':
            for file_select in select_pw_file:
                sucess_message = search_dll_files(select_pw_name, file_select, search_pw)    
        
        if select_mod == 'Fallout 4 FSR3':
            for fl4_file in select_fl4_file:
                sucess_message = search_dll_files(select_fl4_name,fl4_file,search_fl4)    
        
        if select_mod == 'Lords of The Fallen FSR3':
            for lotf_file in select_lotf_file:
                sucess_message = search_dll_files (select_lotf_name,lotf_file,search_spider)
        
        if select_mod == 'Horizon Forbidden West FSR3':
            for hfw_file in select_hfw_file:
                sucess_message = search_dll_files (select_hfw_name,hfw_file,search_spider)
        
        if select_mod == 'Ac Valhalla DLSS3 (Only RTX)':
            for valhalla_file in select_valhalla_file:
                sucess_message = search_dll_files(select_valhalla_name,valhalla_file,search_spider)

        if select_mod == 'Ghost of Tsushima FG DLSS':
            for got_file in select_got_file:
                sucess_message = search_dll_files(select_got_name,got_file,search_spider)
        
        if select_mod == 'Hellblade 2 FSR3 (Only RTX)':
            for hb2_file in select_hb2_file:
                sucess_message = search_dll_files(select_hb2_name,hb2_file,search_spider)  
        
        if select_mod == "Dlss Jedi":
            for jedi_files in  select_jedi_file:
                sucess_message = search_dll_files(select_jedi_name,jedi_files,search_spider) 
        
        if select_option == "Cyberpunk 2077" and select_mod == "RTX DLSS FG":
            for cb2077_files in select_cb2077_file:
                sucess_message = search_dll_files(select_cb2077_name,cb2077_files,search_spider)

    else:
        return 
    
    if sucess_message and unlock_view_message:
        messagebox.showinfo('Success', 'Backup completed successfully.')
    elif not sucess_message and not unlock_view_message:
        messagebox.showinfo('Not found', 'No matching files, backup was not completed.')
        return               
        
def cbox_backup():
    if backup_var.get() == 1:
        if select_folder is not None and select_mod is not None:
            backup_files()
        else:
            messagebox.showinfo('Error','Please select the three initial options: Select Game, Game Folder, and Mod Version.')
            backup_cbox.deselect()

def Backup_Dxgi(rename_file_name,path_dxgi): # Make a backup of the dxgi.dll file'
    if os.path.exists(path_dxgi):
        backup_folder_dxgi = os.path.join(select_folder, 'Backup_DXGI')
        os.makedirs(backup_folder_dxgi, exist_ok=True)

        shutil.copy(path_dxgi, backup_folder_dxgi)  

        os.rename(path_dxgi, os.path.join(select_folder, rename_file_name))
                  
backup_label = tk.Label(screen,text='Backup',font=font_select,bg='black',fg='#C0C0C0')
backup_label.place(x=200,y=326)
backup_var = IntVar()
backup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=backup_var,command=cbox_backup)
backup_cbox.place(x=255,y=329)

uni_custom_contr = False
select_uni_custom = ""
unlock_uni_custom_res = False

list_uni = ['Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2', 'Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1']
def cbox_uni_custom():
    global uni_custom_contr
    
    if uni_custom_var.get() == 1 and (select_mod in list_uni):
        uni_custom_canvas.config(bg='white')
        uni_custom_contr = True
    else:
        uni_custom_canvas.config(bg='#C0C0C0')
        uni_custom_contr = False
        uni_custom_listbox.place_forget()
        if not unlock_uni_custom_res:     
            messagebox.showinfo('Select Uniscaler','Select an option Uniscaler')
            uni_custom_cbox.deselect()

uni_custom_view = False
def uni_custom_res_view(event=None):
    global uni_custom_view
    
    if uni_custom_contr and (select_mod in list_uni):
        if uni_custom_view:
            uni_custom_view = False
            uni_custom_listbox.place_forget()
        else:
            uni_custom_listbox.place(x=609,y=389)
            uni_custom_view = True

def unlock_uni_custom():
    global unlock_uni_custom_res
    if select_mod in list_uni:
        unlock_uni_custom_res = True
    else:
        uni_custom_canvas.config(bg='#C0C0C0')
        uni_custom_listbox.place_forget()
        uni_custom_cbox.deselect()
        unlock_uni_custom_res = False
        return
  
uni_custom_preset_label = tk.Label(screen,text='Uni Resolution Custom',font=font_select,bg='black',fg='#C0C0C0')
uni_custom_preset_label.place(x=420,y=363)
uni_custom_var = IntVar()
uni_custom_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=uni_custom_var,command=cbox_uni_custom)
uni_custom_cbox.place(x=585,y=365)
uni_custom_canvas = tk.Canvas(width=53,height=19,bg='#C0C0C0',highlightthickness=0)
uni_custom_canvas.place(x=609,y=367)
uni_custom_listbox = tk.Listbox(screen,width=9,height=0,bg='white',highlightthickness=0)
uni_custom_listbox.place(x=565,y=389)
uni_custom_listbox.place_forget()

#Custom resolutions are passed to the TOML file of the Uniscaler mods, and the parameters are specific to each passed resolution
def uni_custom_preset():
    custom_op = {
    '1080p' : {
        'balanced':'0.666667',
        'quality':'0.886'
    },
    '1440p':{
        'performance':'0.50',
        'balanced':'0.666667',
        'quality':'0.75'
    },
    '2160p':{
        'ultra_performance':'0.33',
        'performance':'0.44',
        'balanced':'0.50',
        'quality':'0.666667'
    }
    }
    
    path_custom_preset = {'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
                           'Uniscaler + Xess + Dlss':'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
                           'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
                           'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
                           'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
                           'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'}
    
    path_uni_config = path_uni_config[select_mod]

    try:
        key_1 = 'resolution_override'
        
        if select_uni_custom in custom_op:
            custom_selected = custom_op[select_uni_custom]
       
            with open(path_uni_config, 'r') as file:
                toml_uni = toml.load(file)
        
            if key_1 in toml_uni and custom_selected:

                for key, value in custom_selected.items():
                    if key in toml_uni[key_1]:
                        toml_uni[key_1][key] = float(value)
                        
        with open(path_uni_config, 'w') as file:
            toml.dump(toml_uni, file)
                
    except Exception as e:
        messagebox.showinfo('Error','Error while modifying the Toml file.')
        return

#Additional mods to assist in the functioning of the frs3 mods
addon_origins = {'OptiScaler':'mods\\Addons_mods\\OptiScaler',
                 'Tweak':'mods\\Addons_mods\\tweak'}
select_addon_dx12 = 'auto'
select_options_optiscaler = None
select_addon_mods = None

def addon_mods():
    path_ini_optiscaler = 'mods\\Temp\\OptiScaler'
    if select_addon_mods in addon_origins:
        path_addon = addon_origins[select_addon_mods]
    
    try:
        if select_addon_mods == 'OptiScaler' and select_mod != 'FSR 3.1.1/DLSS Optiscaler':
            shutil.copytree(path_addon,select_folder,dirs_exist_ok=True)
            shutil.copytree(path_ini_optiscaler,select_folder,dirs_exist_ok=True)
        elif select_addon_mods == 'Tweak':
            shutil.copytree(path_addon,select_folder,dirs_exist_ok=True)
           
    except Exception:
        messagebox.showinfo('Error','Error in installation, please check if you have correctly filled out Select Game, Select Folder, and Mod Version.')
        return
    
addon_contr = False
def cbox_addon_mods():
    global addon_contr,select_addon_mods,var_method
    if addon_mods_var.get() == 1:
        addon_mods_canvas.config(bg='white')
        addon_contr = True
        if var_method != None:
            var_method = None #Display the Optiscaler Method screen again
    else:
        addon_mods_canvas.config(bg='#C0C0C0')
        addon_ups_dx12_canvas.config(bg='#C0C0C0')
        options_optiscaler_canvas.config(bg='#C0C0C0')
        addon_mods_canvas.delete('text')
        addon_ups_dx12_scroll.place_forget()
        select_addon_mods = None
        addon_contr = False
        var_method = None #Display the Optiscaler Method screen again
        addon_listbox_contr()
        
addon_view = False
def addon_mods_view(event=None):
    global addon_view,addon_contr
    if addon_contr:
        if addon_view:
            addon_view = False
            addon_mods_listbox.place_forget()
        else:
            addon_mods_listbox.place(x=548,y=418)
            addon_view = True
            
def addon_listbox_contr():
    global addon_view,addon_contr
    if not addon_contr and addon_view:
        addon_mods_listbox.place_forget()
        addon_ups_dx12_listbox.place_forget()
        options_optiscaler_listbox.place_forget()
        addon_view = False

def addon_dx11_view(event=None):
    global addon_view,addon_contr
    if addon_contr and select_addon_mods == 'OptiScaler':
        if addon_view:
            addon_view = False
        else:
            addon_view = True

def addon_dx12_view(event=None):
    global addon_view,addon_contr
    if addon_contr and select_addon_mods == 'OptiScaler':
        if addon_view:
            addon_ups_dx12_listbox.place_forget()
            addon_ups_dx12_scroll.place_forget()
            addon_view = False
        else:
            addon_view = True
            addon_ups_dx12_listbox.place(x=563,y=476)
            addon_ups_dx12_scroll.place(x=649,y=476, height=66)

def options_optiscaler_view(event=None):
    global addon_view,addon_contr
    
    if addon_contr and select_addon_mods == 'OptiScaler':
        if addon_view:
            options_optiscaler_listbox.place_forget()
            options_optiscaler_scroll.place_forget()
            addon_view = False
        else:
            addon_view = True
            options_optiscaler_listbox.place(x=537,y=448)
            options_optiscaler_scroll.place(x=680, y=448, height=98)

screen_method_open = False
var_method = None
def install_method(event=None):
    global screen_method_open,addon_contr,addon_view

    if screen_method_open or var_method != None:
        return

    def on_closing():
        global screen_method_open,var_method
        screen_method_open = False
        screen_method.destroy()
        addon_mods_cbox.deselect()
        addon_mods_canvas.delete('text')
        addon_mods_listbox.place_forget()
        var_method = 'Method Default'
        messagebox.showinfo('Optiscaler Installation Method', 'You did not select any installation method, so it has been set to: Method Default (For test). If you want to select another method, check the Add-on Mods box and select Optiscaler".')
    
    screen_method = tk.Toplevel(screen)
    screen_method.title('Optiscaler Installation Method')
    screen_method_width = screen_method.winfo_screenwidth()
    screen_method_height = screen_method.winfo_screenheight()
    x_screen_method = (screen_method_width - 550) // 2 
    y_screen_method = (screen_method_height - 120) // 2 
    screen_method.geometry(f"220x160+{x_screen_method}+{y_screen_method }")
    screen_method.protocol("WM_DELETE_WINDOW", on_closing)

    screen_method_open = True

    def method_selected(method):
        global screen_method_open,var_method
        
        if method == 'Method Default':
            var_method = 'Method Default'
        elif method == 'Method 1 (RTX/RX 6000-7000)':
            var_method = 'Method 1 (RTX/RX 6000-7000)'
        elif method == 'Method 2 (GTX/Old AMD)':
            var_method = 'Method 2 (GTX/Old AMD)'
        elif method == 'Method 3 (If none of the others work)':
            var_method = 'Method 3 (If none of the others work)'
        
        screen_method_open = False
        screen_method.destroy()
    
    method0 = ttk.Button(screen_method, text='Method Default', command=lambda: method_selected('Method Default'))
    method0.pack(pady=5)

    method1 = ttk.Button(screen_method, text='Method 1 (RTX/RX 6000-7000)', command=lambda: method_selected('Method 1 (RTX/RX 6000-7000)'))
    method1.pack(pady=5)

    method2 = ttk.Button(screen_method, text='Method 2 (GTX/Old AMD)', command=lambda: method_selected('Method 2 (GTX/Old AMD)'))
    method2.pack(pady=5)

    method3 = ttk.Button(screen_method, text='Method 3 (If none of the others work)', command=lambda: method_selected('Method 3 (If none of the others work)'))
    method3.pack(pady=5)
    screen_method.focus_set()      
    screen_method.transient(screen)

def update_install_method():

    backup_dir = os.path.join(select_folder, "Backup Dll")
    files_optis = ['libxess.dll','amd_fidelityfx_vk.dll','nvngx.dll','amd_fidelityfx_dx12.dll']
    optiscaler_reg = "mods\\Addons_mods\\OptiScaler\\EnableSignatureOverride.reg"
    os.makedirs(backup_dir, exist_ok=True) 

    if var_method == 'Method Default': #Default installation 
        pass

    if var_method == 'Method 1 (RTX/RX 6000-7000)': #Default installation 
       pass
    
    elif var_method == 'Method 2 (GTX/Old AMD)':
        shutil.copy2("mods\\Addons_mods\\Optiscaler dxgi\\dxgi.dll", select_folder)

    elif var_method == 'Method 3 (If none of the others work)':
        rename_nvngx_dlss = "nvngx.dll"
        rename_nvngx = "dxgi.dll"

        if os.path.exists(os.path.join(select_folder, "nvngx.dll")):

            if os.path.exists(os.path.join(select_folder, "dxgi.dll")):
                shutil.copy2(os.path.join(select_folder, "dxgi.dll"), backup_dir)
                os.remove(select_folder + "dxgi.dll")

            if os.path.exists(os.path.join(select_folder, "nvngx.dll")):
                shutil.copy2(os.path.join(select_folder, "nvngx.dll"), backup_dir)

            if os.path.exists(os.path.join(select_folder, "nvngx_dlss.dll")):
                shutil.copy2(os.path.join(select_folder, "nvngx_dlss.dll"), backup_dir)

            os.rename(os.path.join(select_folder, "nvngx.dll"), os.path.join(select_folder, rename_nvngx))
            if os.path.exists(os.path.join(select_folder, "nvngx_dlss.dll")):
                os.rename(os.path.join(select_folder, "nvngx_dlss.dll"), os.path.join(select_folder, rename_nvngx_dlss))

    for optis_bk_files in os.listdir(select_folder):
        for optis_bk_files in files_optis:
            shutil.copy2(os.path.join(select_folder,optis_bk_files),backup_dir)
    runReg(optiscaler_reg)
            
#Changes the operation of the Optiscaler mod through the .ini file
def update_ini(path_ini,key,value_ini): 
    try:
        with open(path_ini, 'r') as file:
            lines_ini = file.readlines()

        with open(path_ini, 'w') as file:
            for line in lines_ini:
                if line.strip().startswith(key):
                    file.write(f"{key}={value_ini}\n")
                else:
                    file.write(line)
    except Exception as e:
        messagebox.showinfo('Error','Error while modifying the INI file.')
        return

addon_dx11_origins = {'fsr2.2 DX11':'fsr22',
                      'fsr2.1 DX11':'fsr21_12',
                      'fsr2.2 DX11 - DX12':'fsr22_12',
                      'fsr3.1 DX11':'fsr31_12',
                      'xess DX11':'xess',
                      'dlss DX11':'dlss'}

addon_dx12_origins= {
                    'xess DX12':'xess',
                    'fsr2.1 DX12':'fsr21',
                    'fsr2.2 DX12':'fsr22',
                    'fsr3.1 DX12': 'fsr31',
                    'dlss DX12':'dlss'}

addon_vulkan_origins = {
                    'fsr2.1 DX12':'fsr21',
                    'fsr2.2 DX12':'fsr22',
                    'fsr3.1 DX12': 'fsr31',
                    'dlss Vulkan':'dlss'}

def update_optiscaler_dx11_dx12():
    if select_mod == 'FSR 3.1.1/DLSS Optiscaler':
        path_ini_dx11 = 'mods\\Temp\\Optiscaler FG 3.1\\nvngx.ini'

    elif select_mod != 'FSR 3.1.1/DLSS Optiscaler':
        path_ini_dx11 = 'mods\\Temp\\OptiScaler\\nvngx.ini'
    
    if select_addon_dx12 in addon_dx12_origins:
        option_addon = addon_dx12_origins[select_addon_dx12]
        key_dx12 = 'Dx12Upscaler'
        value_ini_dx12 = option_addon
    
        update_ini(path_ini_dx11,key_dx12,value_ini_dx12)

    elif select_addon_dx12 in addon_dx11_origins:
        option_addon = addon_dx11_origins[select_addon_dx12]
        key_dx11 = 'Dx11Upscaler'
        value_ini_dx11 = option_addon

        update_ini(path_ini_dx11,key_dx11,value_ini_dx11)
    
    elif select_addon_dx12 in addon_vulkan_origins:
        option_addon = addon_vulkan_origins[select_addon_dx12]
        key_vulkan = 'VulkanUpscaler'
        value_ini_vulkan = option_addon

        update_ini(path_ini_dx11,key_vulkan,value_ini_vulkan)

def update_optiscaler_ini():
    global select_options_optiscaler
    
    path_ini_dx11 = 'mods\\Temp\\OptiScaler\\nvngx.ini'
    value_ini_true = 'true'

    if select_mod == 'FSR 3.1.1/DLSS Optiscaler':
        path_ini_dx11 = 'mods\\Temp\\Optiscaler FG 3.1\\nvngx.ini'

    elif select_mod != 'FSR 3.1.1/DLSS Optiscaler':
        path_ini_dx11 = 'mods\\Temp\\OptiScaler\\nvngx.ini'
    
    if select_options_optiscaler == 'Enable overlay menu':
        key_overlay_menu = 'OverlayMenu'
        update_ini(path_ini_dx11,key_overlay_menu,value_ini_true)
    
    if select_options_optiscaler == 'CAS sharpening for XeSS':
        key_cas = 'Enabled'
        update_ini(path_ini_dx11,key_cas,value_ini_true)
    
    if select_options_optiscaler == 'Override DLSS sharpness':
        key_dlss_sharp = 'OverrideSharpness'
        update_ini(path_ini_dx11,key_dlss_sharp,value_ini_true)
    
    if select_options_optiscaler == 'Force INVERTED_DEPTH':
        key_inverted_depth = 'DepthInverted'
        update_ini(path_ini_dx11,key_inverted_depth,value_ini_true)
        
    if select_options_optiscaler == 'Force ENABLE_AUTOEXPOSURE':
        key_autoexposure = 'AutoExposure'
        update_ini(path_ini_dx11,key_autoexposure,value_ini_true)
    
    if select_options_optiscaler == 'Force HDR_INPUT_COLOR':
        key_hdr = 'HDR'
        update_ini(path_ini_dx11,key_hdr,value_ini_true)
    
    if select_options_optiscaler == 'Enable Output Scaling':
        key_output = 'OutputScalingEnabled'
        update_ini(path_ini_dx11,key_output,value_ini_true)
    
    if select_options_optiscaler == 'Hook SLDevice':
        key_device = 'HookSLDevice'
        update_ini(path_ini_dx11,key_device,value_ini_true)
    
    if select_options_optiscaler == 'Hook SLProxy':
        key_sldevice = 'Hook SLDevice'
        update_ini(path_ini_dx11,key_sldevice,value_ini_true)
    
    if select_options_optiscaler == 'Sharpening Amplifier':
        key_motion_sharp = 'MotionSharpnessEnabled'
        update_ini(path_ini_dx11,key_motion_sharp,value_ini_true)
    
    if select_options_optiscaler == 'Sync After Dx12':
        key_sync_dx12 = 'SyncAfterDx12'
        update_ini(path_ini_dx11,key_sync_dx12,value_ini_true)
    
    if select_options_optiscaler == 'Use Delay Init':
        key_delay_dx12 = 'UseDelayedInit'
        update_ini(path_ini_dx11,key_delay_dx12,value_ini_true)
    
    if select_options_optiscaler == 'Build Pipelines':
        key_pipelines= 'BuildPipelines'
        update_ini(path_ini_dx11,key_pipelines,value_ini_true)
    
    if select_options_optiscaler == 'Create Heaps':
        key_heaps = 'CreateHeaps'
        update_ini(path_ini_dx11,key_heaps,value_ini_true)
    
    if select_options_optiscaler == 'Drs MinOverride':
        key_drs = 'DrsMinOverrideEnabled'
        update_ini(path_ini_dx11,key_drs,value_ini_true)
    
    if select_options_optiscaler == 'Drs MaxOverride':
        key_drs_max = 'DrsMaxOverrideEnabled'
        update_ini(path_ini_dx11,key_drs_max,value_ini_true)
    
    if select_options_optiscaler == 'Disable Reactive Mask':
        key_mask = 'DisableReactiveMask'
        update_ini(path_ini_dx11,key_mask,value_ini_true)
      
    if select_options_optiscaler == 'Fake Nvidia GPU for DXGI':
        key_mask = 'Dxgi'
        update_ini(path_ini_dx11,key_mask,'false')
    
    if select_options_optiscaler == 'Fake Nvidia GPU for Vulkan':
        key_mask = 'Vulkan'
        update_ini(path_ini_dx11,key_mask,value_ini_true)
        
    if select_options_optiscaler == 'Dxgi Xess No Spoof':
        key_mask = 'DxgiXessNoSpoof'
        update_ini(path_ini_dx11,key_mask,'false')
     
    if select_options_optiscaler == 'Override Nvapi Dll':
        key_mask = 'NvApi'
        update_ini(path_ini_dx11,key_mask,value_ini_true)
    
    if select_options_optiscaler == 'Restore Default':
        messagebox.showinfo("Options Restored","The options were successfully restored to the default settings.")
        replace_ini()
        options_optiscaler_canvas.delete('text')
        select_options_optiscaler = None #Prevents the .ini file from being restored more than once

#Replaces the 'used' .ini file with a new one
def replace_ini():
    path_ini = 'mods\\Temp\\OptiScaler\\nvngx.ini'
    path_ini_origin = 'mods\\Addons_mods\\OptiScaler\\nvngx.ini'
    folder_ini = 'mods\\Temp\\OptiScaler'

    if select_mod == 'FSR 3.1.1/DLSS Optiscaler':
        path_ini = 'mods\\Temp\\Optiscaler FG 3.1\\nvngx.ini'
        path_ini_origin = 'mods\\Optiscaler FSR 3.1 Custom\\nvngx.ini'
        folder_ini = 'mods\\Temp\\Optiscaler FG 3.1'

    elif select_addon_mods == 'OptiScaler':
        path_ini = 'mods\\Temp\\OptiScaler\\nvngx.ini'
        path_ini_origin = 'mods\\Addons_mods\\OptiScaler\\nvngx.ini'
        folder_ini = 'mods\\Temp\\OptiScaler'

    if select_addon_mods == 'OptiScaler' or select_mod == 'FSR 3.1.1/DLSS Optiscaler':
        os.remove(path_ini)
        shutil.copy2(path_ini_origin,folder_ini)

addon_ups_dx12_label = tk.Label(screen,text='Upscaler Optiscaler',font=font_select,bg='black',fg='#C0C0C0')
addon_ups_dx12_label.place(x=420,y=453)
addon_ups_dx12_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
addon_ups_dx12_canvas.place(x=563,y=456)
addon_ups_dx12_scroll = tk.Scrollbar(screen)
addon_ups_dx12_listbox = tk.Listbox(screen, width=14,height=4, bg='white', highlightthickness=0, yscrollcommand=addon_ups_dx12_scroll.set)
addon_ups_dx12_scroll.config(command=addon_ups_dx12_listbox.yview)

options_optiscaler_label = tk.Label(screen,text='Optiscaler Opts',font=font_select,bg='black',fg='#C0C0C0')
options_optiscaler_label.place(x=420,y=423)
options_optiscaler_canvas = tk.Canvas(width=159,height=19,bg='#C0C0C0',highlightthickness=0)
options_optiscaler_canvas.place(x=537,y=427)
options_optiscaler_scroll = tk.Scrollbar(screen)
options_optiscaler_listbox = tk.Listbox(screen, width=24, height=6, bg='white', highlightthickness=0, yscrollcommand=options_optiscaler_scroll.set)
options_optiscaler_scroll.config(command=options_optiscaler_listbox.yview)

addon_mods_label = tk.Label(screen,text='Add-on Mods',font=font_select,bg='black',fg='#C0C0C0')   
addon_mods_label.place(x=420,y=393)
addon_mods_var = tk.IntVar()
addon_mods_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=addon_mods_var,command=cbox_addon_mods)
addon_mods_cbox.place(x=522,y=396)
addon_mods_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
addon_mods_canvas.place(x=548,y=398)
addon_mods_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)

#Modifies the operation of Auto Exposure in the Uniscaler mods via the .toml file (true/false).
us_origin = {'Uniscaler':r'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
             'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
             'Uniscaler V2':r'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
             'Uniscaler V3':r'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
             'Uniscaler V4':r'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
             'Uniscaler FSR 3.1':r'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'}
def var_auto_expo_en():
    if select_mod in us_origin:
        folder_auto_expo = us_origin[select_mod]
    key_us = 'general'
    
    with open (folder_auto_expo,'r') as file:
        toml_expo = toml.load(file)
        
    toml_expo.setdefault(key_us,{})
    toml_expo[key_us]['force_auto_exposure'] = True
    
    with open(folder_auto_expo, 'w') as file:
        toml.dump(toml_expo,file)

def var_auto_expo_dis():
    if select_mod in us_origin:
        folder_auto_expo = us_origin[select_mod]
    key_us = 'general'
    
    with open (folder_auto_expo,'r') as file:
        toml_expo = toml.load(file)
        
    toml_expo.setdefault(key_us,{})
    toml_expo[key_us]['force_auto_exposure'] = False
    
    with open(folder_auto_expo, 'w') as file:
        toml.dump(toml_expo,file)
        
def cbox_var_auto_expo():
    if var_auto_expo_var.get() == 1 and select_mod in us_origin:
        var_auto_expo_en()
    elif var_auto_expo_var.get() == 0 and select_mod in us_origin:
        var_auto_expo_dis()
    elif var_auto_expo_var.get() == 1 and select_mod not in us_origin:
        messagebox.showinfo('Select Uniscaler','Please select Uniscaler or Uniscaler + Xess + Dlss to enable or disable this option')
        var_expo_cbox.deselect()
        return

var_auto = tk.Label(screen,text='Auto Exposure',font=font_select,bg='black',fg='#C0C0C0')
var_auto.place(x=200,y=206)
var_auto_expo_var = tk.IntVar()
var_expo_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=var_auto_expo_var,command=cbox_var_auto_expo)
var_expo_cbox.place(x=310,y=209)

def var_frame_gen_en():
    if select_mod in us_origin:
        folder_frame_gen = us_origin[select_mod]
    key_us = 'general'
    
    with open (folder_frame_gen,'r') as file:
        toml_gen = toml.load(file)
        
    toml_gen.setdefault(key_us,{})
    toml_gen[key_us]['disable_frame_generation'] = True
    
    with open(folder_frame_gen, 'w') as file:
        toml.dump(toml_gen,file)
        
def var_frame_gen_dis():
    if select_mod in us_origin:
        folder_frame_gen = us_origin[select_mod]
    key_us = 'general'
    
    with open (folder_frame_gen,'r') as file:
        toml_gen = toml.load(file)
        
    toml_gen.setdefault(key_us,{})
    toml_gen[key_us]['disable_frame_generation'] = False
    
    with open(folder_frame_gen, 'w') as file:
        toml.dump(toml_gen,file)

def cbox_var_frame_gen():
    if var_frame_gen_var.get() == 1 and select_mod in us_origin:
        var_frame_gen_en()
        
    elif var_frame_gen_var.get() == 0 and select_mod in us_origin:
        var_frame_gen_dis()
        
    elif var_frame_gen_var.get() == 1 and select_mod not in us_origin:
        messagebox.showinfo('Select Uniscaler','Please select Uniscaler or Uniscaler + Xess + Dlss to enable or disable this option')
        var_frame_gen_cbox.deselect()
        return
        
var_frame_gen_label = tk.Label(screen,text='Off Frame Gen',font=font_select,bg='black',fg='#C0C0C0')
var_frame_gen_label.place(x=0,y=236)
var_frame_gen_var = tk.IntVar()
var_frame_gen_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=var_frame_gen_var,command=cbox_var_frame_gen)
var_frame_gen_cbox.place(x=110,y=239)

#Limit the game's Fps to the value provided by the user through the .toml file
def fps_limit():
    global us_origin
    key_us = 'general'
    fps_value = fps_user_entry.get()
    try:
        if select_mod in us_origin:
            origins_us = us_origin[select_mod]

        with open(origins_us,'r') as file:
            toml_us = toml.load(file)
        toml_us.setdefault(key_us,{})
        toml_us[key_us]['original_frame_rate_limit'] = int(fps_value)
        
        with open(origins_us,'w') as file:
            toml.dump(toml_us,file)
    except Exception:
        pass

def fps_isdigit(event):
    fps_code = event.keycode
    
    if fps_code >= 48 and fps_code <= 57 or fps_code == 8:
        if fps_code != 8 and len(fps_user_entry.get()) < 3:
            fps_user_entry.insert(tk.END, event.char)
        else:
            fps_user_entry.delete(len(fps_user_entry.get()) - 1, tk.END)
            
    fps_limit()
    return 'break'

def unlock_fps_limit():
    if select_mod in us_origin:    
        fps_user_entry.configure(state='normal',bg='white')
    else:
        fps_user_entry.configure(state='readonly',bg='#C0C0C0')
    
fps_user_label = tk.Label(screen,text='FPS Limit:',font=font_select,bg='black',fg='#C0C0C0')
fps_user_label.place(x=0,y=206)
fps_user_entry =  tk.Entry(screen,width=5,bg='#C0C0C0',state= 'readonly',borderwidth=0)
fps_user_entry.place(x=80,y=209)
fps_user_entry.lift()

def cbox_del_dxgi():
    if del_dxgi_var.get() == 1: 
        dxgi_clean_var = messagebox.askyesno('Uninstall','Would you like to proceed with the uninstallation of the DXGI/D3D12.dll files?')
        if dxgi_clean_var:
            clean_dxgi()
            messagebox.showinfo('Success','Uninstallation completed successfully') 
            del_dxgi_label.after(400,del_dxgi_cbox.deselect)
        else:
            del_dxgi_cbox.deselect()

def clean_dxgi():
    dxgi_list = ['dxgi.dll','d3d12.dll']
    
    for item in os.listdir(select_folder):
        if item in dxgi_list:
            os.remove(os.path.join(select_folder,item))

del_dxgi_label = tk.Label(screen,text='Del Only dxgi.dll',font=font_select,bg='black',fg='#E6E6FA')
del_dxgi_label.place(x=0,y=506)
del_dxgi_var = IntVar()
del_dxgi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=del_dxgi_var,command=cbox_del_dxgi)
del_dxgi_cbox.place(x=120,y=509) 

#Remove the mod files, the files for deletion are passed in lists and are checked according to the mod version selected by the user 
def cbox_cleanup():
    if cleanup_var.get() == 1:
        try:
            if select_folder == None:
                messagebox.showinfo('Select Folder','Please select the destination folder')
                cleanup_cbox.deselect()
                return
            else:
                clean_var = messagebox.askyesno('Uninstall','Would you like to proceed with the uninstallation of the mod?')
                if clean_var:
                    clean_mod()
                    messagebox.showinfo('Success','Uninstallation completed successfully')
                    cleanup_cbox.after(400,cleanup_cbox.deselect)
                else:
                    cleanup_cbox.deselect()
        except Exception:
            pass
 
#Same function, just to avoid repeating code
def del_all_mods(mod_list,game_name,search_folder_name = None):
    global select_folder
    try:
        if select_option == game_name:
            for item in os.listdir(select_folder):
                if item in mod_list:
                    os.remove(os.path.join(select_folder,item))
                    return True            
            
            if search_folder_name != None:
                mods_path = os.path.join(select_folder, search_folder_name)        
                if os.path.exists(mods_path):
                    shutil.rmtree(mods_path)
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')    

def del_all_mods2(mod_list,mod_name,search_folder_name = None):
    global select_folder
    try:
        if select_mod == mod_name:
            for item in os.listdir(select_folder):
                if item in mod_list:
                    os.remove(os.path.join(select_folder,item))
            
            if search_folder_name != None:
                mods_path = os.path.join(select_folder, search_folder_name)        
                if os.path.exists(mods_path):
                    shutil.rmtree(mods_path)
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.') 

def del_all_mods3(mod_list,mod_name, dest_folder,search_folder_name = None):
    global select_folder
    try:
        if select_mod == mod_name:
            for item in os.listdir(dest_folder):
                if item in mod_list:
                    os.remove(os.path.join(dest_folder,item))
            
            if search_folder_name != None:
                mods_path = os.path.join(select_folder, search_folder_name)        
                if os.path.exists(mods_path):
                    shutil.rmtree(mods_path)
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.') 

def del_all_mods_optiscaler(mod_list,mod_name, remove_dxgi = False,search_folder_name = None):
    global select_folder
    try:
        if select_mod == mod_name:

            if os.path.exists(os.path.join(select_folder, 'nvngx.dll')):
                os.replace(os.path.join(select_folder, 'nvngx.dll'), os.path.join(select_folder, 'nvngx_dlss.dll')) # Reverts the original nvngx_dlss.dll file
            
            if remove_dxgi:
                if os.path.exists(os.path.join(select_folder, 'dxgi.dll')):
                    os.remove(os.path.join(select_folder, 'dxgi.dll'))

            for item in os.listdir(select_folder):
                if item in mod_list:
                    os.remove(os.path.join(select_folder,item))
            
            if search_folder_name != None:
                mods_path = os.path.join(select_folder, search_folder_name)        
                if os.path.exists(mods_path):
                    shutil.rmtree(mods_path)
            return True

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.') 

def del_others_mods(mod_path,message,path_reg = None):
    try:
        if os.path.exists(mod_path) and messagebox.askyesno('Cleanup', message):
                os.remove(mod_path)

                if path_reg != None:
                    runReg(path_reg)
                
                return True
        return False

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')  

def del_others_mods2(mod_path, message, files_to_remove, path_reg=None):
    try:
        if os.path.exists(mod_path):
            files_found = [file for file in files_to_remove if os.path.exists(os.path.join(mod_path, file))]
            
            if files_found and messagebox.askyesno('Cleanup', message):
                for file in files_found:
                    os.remove(os.path.join(mod_path, file))
                
                if path_reg is not None:
                    runReg(path_reg)
                
                return True
        
        return False

    except Exception as e:
        messagebox.showinfo('Error', 'Please close the game or any other folders related to the game.')

def del_fsr_dlss_mods(list_amd, list_rtx, mod_name,path_reg=None):
    gpu_name = get_active_gpu()

    if 'nvidia' in gpu_name:
        del_all_mods2(list_rtx, mod_name)
    elif 'amd' in gpu_name or 'intel' in gpu_name:
        del_all_mods2(list_amd,mod_name)
    elif gpu_name is None:
        del_all_mods2(list_rtx, mod_name) if messagebox.askyesno('GPU', 'Do you have an Nvidia GPU?') else del_all_mods2(list_amd,mod_name)
    
    if os.path.exists(os.path.join(select_folder, 'reshade-shaders')) and os.path.exists(os.path.join(select_folder, 'd3d12.dll')):
        os.remove(os.path.join(select_folder, 'd3d12.dll'))

    if path_reg != None:
        runReg(path_reg)
        
#Execution def 
def clean_mod():
    global select_folder
    mod_clean_list = ['fsr2fsr3.config.toml','winmm.ini','winmm.dll',
                      'lfz.sl.dlss.dll','FSR2FSR3.asi','EnableSignatureOverride.reg',
                      'DisableSignatureOverride.reg','nvngx.dll','_nvngx.dll','fsr2fsr3.log',
                      'd3d12.dll','nvngx.ini','fsr2fsr3.log','Uniscaler.asi','uniscaler.config.toml','uniscaler.log','dinput8.dll']
   
    del_uni = ['winmm.ini','winmm.dll','uniscaler.config.toml','Uniscaler.asi','nvngx.dll']
   
    del_winmm = 'winmm.dll'
    
    del_elden_fsr3 =['_steam_appid.txt','_winhttp.dll','anti_cheat_toggler_config.ini','anti_cheat_toggler_mod_list.txt',
                     'start_game_in_offline_mode.exe','toggle_anti_cheat.exe','ReShade.ini','EldenRingUpscalerPreset.ini',
                     'dxgi.dll','d3dcompiler_47.dll','']
    
    del_elden_fsr3_v3 = ['ERSS2.dll','dxgi.dll','ERSS-FG.dll']
    
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

    del_fsr3_tlou3 = ['winmm.ini','winmm.dll','nvngx_dlssg.dll','nvngx_dlss.dll','nvngx.dll','libxess.dll','uniscaler.asi','uniscaler.config.toml','uniscaler.log']
    
    del_gtav_fsr3 = ['GTAVUpscaler.org.asi','GTAVUpscaler.asi','d3d12.dll','dxgi.asi','GTAVUpscaler.dll','GTAVUpscaler.org.dll','dinput8.dll']
    
    del_lotf_fsr3 = ['version.dll','RestoreNvidiaSignatureChecks.reg','nvngx.dll','launch.bat','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg',
                        'Uniscaler.asi','DisableEasyAntiCheat.bat','winmm.dll','winmm.ini']
    
    del_cb2077 = ['nvngx.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll']
    
    del_got = ['version.dll','RestoreNvidiaSignatureChecks.reg','dxgi.dll','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg','d3d12core.dll','d3d12.dll','no-filmgrain.reg']
    
    del_hfw_fsr = ['version.dll','nvngx.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','fsr2fsr3.config.toml','FSR2FSR3.asi','','lfz.sl.dlss.dll','winmm.dll','winmm.ini','libxess.dll']
    
    del_valhalla_fsr3 = ['ReShade.ini','dxgi.dll','ACVUpscalerPreset.ini']
    
    del_hb2 = ['version.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll']
    
    del_aw2_rtx = ['nvngx.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','amd_fidelityfx_vk.dll','amd_fidelityfx_dx12.dll']

    del_dd2_all_gpu = [
    'amd_fidelityfx_dx12.dll', 'amd_fidelityfx_vk.dll', 'DELETE_OPENVR_API_DLL_IF_YOU_WANT_TO_USE_OPENXR', 
    'dinput8.dll', 'DisableNvidiaSignatureChecks.reg', 'DisableSignatureOverride.reg', 'dlss-enabler-upscaler.dll',
    'dlss-enabler.dll', 'dlssg_to_fsr3_amd_is_better.dll', 'dxgi.dll', 'EnableSignatureOverride.reg', 
    'libxess.dll', 'nvapi64-proxy.dll', 'nvngx-wrapper.dll', 'nvngx.dll', 'nvngx.ini', 'openvr_api.dll', 
    'openxr_loader.dll', 'reframework_revision.txt', 'RestoreNvidiaSignatureChecks.reg', 'unins000.dat', '_nvngx.dll'
    ]

    del_dd2_nv = [
    'amd_fidelityfx_dx12.dll', 'amd_fidelityfx_vk.dll', 'DELETE_OPENVR_API_DLL_IF_YOU_WANT_TO_USE_OPENXR', 
    'dinput8.dll', 'DisableSignatureOverride.reg', 'dlss-enabler-upscaler.dll', 'dlss-enabler.dll',
    'dlss-enabler.log', 'dlssg_to_fsr3.log', 'dlssg_to_fsr3_amd_is_better.dll', 'dxgi.dll', 
    'EnableSignatureOverride.reg', 'libxess.dll', 'nvngx-wrapper.dll', 'nvngx.dll', 
    'nvngx.ini', 'openvr_api.dll', 'openxr_loader.dll', 'reframework_revision.txt', 
    'unins000.dat', 'unins000.exe']

    del_callisto_optiscaler_custom = [
    "amd_fidelityfx_dx12.dll", "amd_fidelityfx_vk.dll", "dlsstweaks.ini", "DLSSTweaksConfig.exe", "dxgi.dll",
    "FSRBridge.asi", "libxess.dll", "nvngx.dll", "nvngx.ini","winmm.dll", "winmm.ini"
    ]

    del_drr_dlss_to_fg_custom = ['dlssg_to_fsr3_amd_is_better.dll', 'version.dll']

    del_tcp_sr = ['dlsstweaks.ini','DLSSTweaksConfig.exe','FSRBridge.asi','winmm.dll','winmm.ini','nvngx.dll','EnableNvidiaSigOverride.reg','DisableNvidiaSigOverride.reg','winmm.ini','winmm.dll']

    del_optiscaler = ['nvngx.ini','nvngx.dll','libxess.dll','winmm.dll', 'nvapi64.dll','fakenvapi.ini','dlssg_to_fsr3_amd_is_better.dll']

    del_optiscaler_custom = [
    'amd_fidelityfx_dx12.dll', 'amd_fidelityfx_vk.dll', 'DisableNvidiaSignatureChecks.reg', 'dlss-enabler-upscaler.dll', 'dlss-enabler.dll', 'dlss-enabler.log', 'dlss-finder.exe', 'dlssg_to_fsr3.ini', 'dlssg_to_fsr3.log', 
    'dlssg_to_fsr3_amd_is_better-3.0.dll', 'dlssg_to_fsr3_amd_is_better.dll', 'dxgi.dll', 'libxess.dll', 'nvapi64-proxy.dll', 'nvngx-wrapper.dll', 'nvngx.dll', 'nvngx.ini', 'nvngx_dlss.dll', 'nvngx_dlssg.dll', 'RestoreNvidiaSignatureChecks.reg', 
    'unins000.dat','fakenvapi.ini','fakenvapi.log','nvapi64.dll'
    ]

    del_dlss_rtx = [ 
    'dlss-enabler-upscaler.dll', 'dlss-enabler.dll', 'dlss-enabler.log', 'dlssg_to_fsr3.log',
    'dlssg_to_fsr3_amd_is_better-3.0.dll', 'dlssg_to_fsr3_amd_is_better.dll', 'dxgi.dll', 'fakenvapi.log', 'nvngx-wrapper.dll',
    'nvngx.ini', 'unins000.dat','nvapi64-proxy.dll'
    ]

    del_dlss_amd = [
    'nvapi64-proxy.dll','dlss-enabler-upscaler.dll', 'dlss-enabler.dll', 'dlss-enabler.log', 'dlssg_to_fsr3.log',
    'dlssg_to_fsr3_amd_is_better-3.0.dll', 'dlssg_to_fsr3_amd_is_better.dll', 'dxgi.dll', 'fakenvapi.ini', 'fakenvapi.log',
    'nvapi64.dll', 'nvngx-wrapper.dll', 'nvngx.dll', 'nvngx.ini', 'unins000.dat'
    ]

    del_dlss_rtx_custom = ['amd_fidelityfx_dx12.dll','amd_fidelityfx_vk.dll','dlss-enabler.dll','dxgi.dll','libxess.dll','nvngx.ini']

    del_dlss_to_fg = ['dlssg_to_fsr3_amd_is_better.dll','version.dll']


    def ask_and_remove(file_path,message):
        if os.path.exists(file_path):
            if messagebox.askyesno('Remove',message):
                os.remove(file_path)

    try:
        if select_option == 'Dragons Dogma 2':
            remove_dinput8_dd2 = ['openvr_api.dll','openxr_loader.dll','DELETE_OPENVR_API_DLL_IF_YOU_WANT_TO_USE_OPENXR','dinput8.dll','reframework_revision.txt']
            
            if del_others_mods2(select_folder, 'Do you want to remove the Dinput8?', remove_dinput8_dd2):

                if os.path.exists(os.path.join(select_folder,'reframework')) : shutil.rmtree(os.path.join(select_folder,'reframework'))
            
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Dragons Dogma 2 mods files, please try again or do it manually')
     
    try:
        if select_option == 'Elden Ring' and select_mod != 'FSR 3.1.3/DLSS FG Custom Elden' and select_mod != 'Unlock FPS Elden':
            for item in os.listdir(select_folder):
                if item in mod_clean_list or item in del_elden_fsr3:
                    os.remove(os.path.join(select_folder,item))
                    
                er_mods = os.path.join(select_folder, 'mods')
                er_reshade = os.path.join(select_folder, 'reshade-shaders')
                if os.path.exists(er_mods or er_reshade):
                    shutil.rmtree(er_reshade)
                    shutil.rmtree(er_mods)   
            if os.path.exists(os.path.join(select_folder,'mods')):
                if os.path.exists(os.path.join(select_folder,'UnlockFps.txt')):
                    os.remove(os.path.join(select_folder,'mods\\UnlockTheFps.dll'))
                    os.remove(os.path.join(select_folder,'UnlockFps.txt'))
                    shutil.rmtree(os.path.join(select_folder,'mods\\UnlockTheFps'))


        elif select_option == 'Elden Ring' and select_mod == 'FSR 3.1.3/DLSS FG Custom Elden':
            for itemv3 in os.listdir(select_folder):
                if itemv3 in del_elden_fsr3_v3:
                    os.remove(os.path.join(select_folder,itemv3))      
            if os.path.exists(os.path.join(select_folder,'mods')):
                if os.path.exists(os.path.join(select_folder,'UnlockFps.txt')):
                    os.remove(os.path.join(select_folder,'mods\\UnlockTheFps.dll'))
                    os.remove(os.path.join(select_folder,'UnlockFps.txt'))
                    shutil.rmtree(os.path.join(select_folder,'mods\\UnlockTheFps'))

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.') 
    
    if select_option == 'Baldur\'s Gate 3':
        del_all_mods(del_bdg_fsr3,'Baldur\'s Gate 3','mods') 
    
    name_xess = os.path.join(select_folder,'libxess.txt')
    new_xess = os.path.join(select_folder,'libxess.dll')
    rename_old_xess = 'libxess.dll'
    
    try:
        if select_option == "Cyberpunk 2077":
            root_path_cb2077 = os.path.abspath(os.path.join(select_folder,'..\\..'))
            mods_files = ["#####-NovaLUT-2.archive","HD Reworked Project.archive"]
            exe_mods_files = ['V2.0 Real Life Reshade.ini','global.ini','version.dll']
            cb2077_reg = "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal\\RestoreNvidiaSignatureChecks.reg"
            reshade_path = '\\bin\\x64\\V2.0 Real Life Reshade.ini'
            gpu_name = get_active_gpu()

            if select_mod == "RTX DLSS FG":
                for file_del in os.listdir(select_folder):
                    if file_del in del_cb2077:
                        os.remove(os.path.join(select_folder,file_del)) 
                runReg(cb2077_reg)
            
            if select_mod == 'FSR 3.1.3/XESS FG 2077':
                if 'amd' in gpu_name or 'intel' in gpu_name:
                    del_all_mods(del_dlss_amd, 'Cyberpunk 2077')
                else:
                    del_all_mods(del_dlss_rtx,'Cyberpunk 2077')
            
            # Enable Vignette
            if os.path.exists(root_path_cb2077 + "\\archive\\pc\\mod\\DisableVignetteAndSharpening.archive"):
                if messagebox.askyesno('Enable Vignette', 'Do you want to enable vignette?'):
                    os.remove(root_path_cb2077 + "\\archive\\pc\\mod\\DisableVignetteAndSharpening.archive")
            
            # FG Ghost Fix
            if os.path.exists(root_path_cb2077 + "\\archive\\pc\\mod\\framegenghostingfix_16_9.archive"):
                if messagebox.askyesno('Disable Vignette', 'Do you want to remove the FG Ghost Fix?'):
                    os.remove(root_path_cb2077 + "\\archive\\pc\\mod\\framegenghostingfix_16_9.archive")
            
            if os.path.exists(root_path_cb2077 + "\\archive\\pc\\mod\\#####-NovaLUT-2.archive"):

                if messagebox.askyesno("Mods","Would you like to remove the mods? Nova Lut and Cyberpunk 2077 HD Reworked"):
            
                    for files_mods_cb_2077 in mods_files:
                        full_path_mods_cb2077 = os.path.join(root_path_cb2077 + '\\archive\\pc\\mod\\',files_mods_cb_2077)
                        os.remove(full_path_mods_cb2077)
            
                    if os.path.exists(root_path_cb2077 + reshade_path):

                        for files_exe_mods_cb2077 in exe_mods_files:
                            full_path_exe_mods_cb2077 = os.path.join(root_path_cb2077 + '\\bin\\x64',files_exe_mods_cb2077)
                            os.remove(full_path_exe_mods_cb2077)
                    
                    if os.path.exists(root_path_cb2077 + '\\bin\\x64\\plugins'):
                        shutil.rmtree(root_path_cb2077 + '\\bin\\x64\\plugins')

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
            
    try:
        if select_mod == 'Uniscaler' or select_mod == 'Uniscaler V2' or select_mod == 'Uniscaler V3' or select_mod == 'Uniscaler V4' or select_mod == 'Uniscaler FSR 3.1':
            if os.path.exists(name_xess):
                old_xess_rename = messagebox.askyesno('Old Xess','Do you want to remove Xess 1.3 and revert to the old version?')
                if old_xess_rename:
                    os.remove(new_xess)
                    os.rename(name_xess,os.path.join(select_folder,rename_old_xess))
            elif not os.path.exists(name_xess):
                if os.path.exists(new_xess):
                    os.remove(new_xess)
    except Exception as e:
        messagebox.showinfo('Xess does not exist','Xess 1.3 does not exist or has already been removed previously.')

    try:
        if select_option == 'Fallout 4':
            for item_fl4 in os.listdir(select_folder):
                if item_fl4 in del_fl4_fsr3:
                    os.remove(os.path.join(select_folder,item_fl4))
        
            fl4_ups_org = os.path.join(select_folder,'mods\\RDR2Upscaler.org.dll')
            fl4_symlink = os.path.join(select_folder,'mods\\SymlinkCreator.exe')
            fl4_all = [
                os.path.join(select_folder,'src'),
                os.path.join(select_folder,'Data\\F4SE'),
                os.path.join(select_folder,'Data\\Plugins'),
                os.path.join(select_folder,'Data\\Scripts'),
                os.path.join(select_folder,'Data\\UpscalerBasePlugin'),
                os.path.join(select_folder,'Data\\Data\\F4SE'),
            ]
            
            if os.path.exists(os.path.join(select_folder,'mods')):
                for path_fl4 in fl4_all:
                    shutil.rmtree(path_fl4)
            if os.path.exists(fl4_ups_org):
                os.remove(fl4_ups_org)
            if os.path.exists(fl4_symlink):
                os.remove(fl4_symlink)
                os.remove(fl4_ups_org)    
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
    
    try: #clear the mods for rdr2 and palworld
        if select_mod == 'RDR2 Mix' or select_mod == 'RDR2 FG Custom' or select_option == 'Palworld':
            appdata_pw = os.getenv("LOCALAPPDATA")
            path_ini_pw = os.path.join(appdata_pw, 'Pal\\Saved\\Config\\WinGDK')

            if select_option == 'Palworld':
                if os.path.exists(os.path.abspath(os.path.join(path_ini_pw, '..', 'Engine.ini'))):
                    shutil.copy(os.path.abspath(os.path.join(path_ini_pw, '..', 'Engine.ini')), path_ini_pw)

                    os.remove(os.path.abspath(os.path.join(path_ini_pw, '..', 'Engine.ini')))  

            for item_rdr2 in os.listdir(select_folder):
                if item_rdr2 in del_rdr2_fsr3:
                    os.remove(os.path.join(select_folder,item_rdr2))
                    
            path_rdr2_mod = os.path.join(select_folder,'mods')
            path_rdr2_shader = os.path.join(select_folder,'reshade-shaders')
            if os.path.exists(path_rdr2_mod):
                shutil.rmtree(path_rdr2_mod)
                shutil.rmtree(path_rdr2_shader)  
                if os.path.exists(os.path.join(select_folder,'PalworldUpscalerPreset.ini')):
                    os.remove(os.path.join(select_folder,'PalworldUpscalerPreset.ini'))     

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
        print(e)
    
    name_dlss = os.path.join(select_folder,'nvngx_dlss.txt')
    new_dlss = os.path.join(select_folder,'nvngx_dlss.dll')
    rename_old_dlss = 'nvngx_dlss.dll'
    
    try:
        if select_mod == 'Uniscaler' or select_mod == 'Uniscaler V2' or select_mod == 'Uniscaler V3' or select_mod == 'Uniscaler V4' or select_mod == 'Uniscaler FSR 3.1':
            if os.path.exists(name_dlss):
                old_dlss_rename = messagebox.askyesno('Old DLSS','Do you want to remove DLSS 3.8.10 and revert to the old version?')
                
                if old_dlss_rename:
                    os.remove(new_dlss)
                    os.rename(name_dlss,os.path.join(select_folder,rename_old_dlss))
                
            elif not os.path.exists(name_dlss):
                if os.path.exists(new_dlss):
                    os.remove(new_dlss)

    except Exception as e:
        messagebox.showinfo('DLSS does not exist','DLSS 3.8.10 does not exist or has already been removed previously.')
       
    try:
        if select_option == 'Forza Horizon 5':
            
            if os.path.exists(os.path.join(select_folder,'RestoreNvidiaSignatureChecks.reg')):
                return_rtx_reg = 'mods\\FSR3_FH\\RTX\\RestoreNvidiaSignatureChecks.reg'

                var_reg_rtx = messagebox.askyesno('Return reg','Do you want to restore NvidiaSignatureChecks values to default? When installing the mod, these values were changed')
                
                if var_reg_rtx:
                    runReg(return_rtx_reg)
            
            for item_fh in os.listdir(select_folder):
                if item_fh in del_fh_fsr3:
                    os.remove(os.path.join(select_folder,item_fh)) 
                      
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
    
    try:
        if select_option == 'Dragon Age: Veilguard':
            remove_anti_stutter_dg_veil = 'mods\\FSR3_Dg_Veil\\Anti Stutter\\Uninstall DATV High CPU Priority.reg'
            restore_purple_filter_dg_veil = ['ReShade.ini','Dark_Fantasy_LUT.ini','dxgi.dll']

            if select_mod == 'FSR 3.1.3/DLSS DG Veil':
                del_fsr_dlss_mods(del_dlss_amd, del_dlss_rtx,'FSR 3.1.3/DLSS DG Veil','mods\\Optiscaler FSR 3.1 Custom\\RestoreNvidiaSignatureChecks.reg')

            del_others_mods(os.path.join(select_folder, 'AntiStutter.txt'), 'Do you want to remove the Anti Sttuter?', remove_anti_stutter_dg_veil)

            if os.path.exists(os.path.join(select_folder, 'Dark_Fantasy_LUT.ini')) and messagebox.askyesno('Restore Purple Filter', 'Do you want to restore the Purple Filter?'):
                del_all_mods2(restore_purple_filter_dg_veil, 'Others Mods DG Veil', 'reshade-shaders')
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Dragon Age: Veilguard mods files, please try again or do it manually')

    try:
        if select_option == 'Warhammer: Space Marine 2':
            restore_dxgi_marine = os.path.join(select_folder, 'Backup_DXGI')
            dxgi_marine = os.path.join(restore_dxgi_marine, 'dxgi.dll')
            path_del_txt_stutter_marine = os.path.join(select_folder,'Marine_Anti_Stutter.txt')
            disable_sig_over_fsr31 = 'mods\\Temp\\disable signature override\\DisableSignatureOverride.reg'

            del_fsr_dlss_mods(del_dlss_amd, del_dlss_rtx,'FSR 3.1.3/DLSS FG Marine', disable_sig_over_fsr31)

            if select_mod == 'FSR 3.1.2/DLSS FG Custom':
                if os.path.isdir(restore_dxgi_marine):
                    if os.path.isfile(dxgi_marine):
                        shutil.copy(dxgi_marine, select_folder)  
                        shutil.rmtree(restore_dxgi_marine)
                        
            if os.path.exists(path_del_txt_stutter_marine):
                if messagebox.askyesno('Anti Stutter','Do you want to remove the Anti Stutter?'):

                    runReg('mods\\FSR3_Outlaws\\Anti_Stutter\\Uninstall Star Wars Outlaws CPU Priority.reg')
                    os.remove(select_folder + '\\Marine_Anti_Stutter.txt')

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')

    try:
        icr_en_rtx_reg =  "mods\\FSR3_ICR\\ICARUS_DLSS_3_FOR_RTX\\RestoreNvidiaSignatureChecks.reg"
        
        if select_mod == 'Icarus FSR3 AMD/GTX': 
            for i_icr in os.listdir(select_folder):
                if i_icr in del_icarus_otgpu_fsr3:
                    os.remove(os.path.join(select_folder,i_icr))
            
            en_rtx_reg = messagebox.askyesno('Enable SigOver','Do you want to re-enable NvidiaSignatureChecks? It was disabled during the mod installation.')
            if en_rtx_reg:
                runReg(icr_en_rtx_reg) 
                  
        elif select_mod == 'Icarus FSR3 RTX':
            for i_icr_rtx in os.listdir(select_folder):
                if i_icr_rtx in del_icarus_rtx_fsr3:
                    os.remove(os.path.join(select_folder,i_icr_rtx))
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')  
    
    try:
        path_assets_tekken = os.path.join(select_folder,'assets')
        if select_mod == 'Unlock Fps Tekken 8':
            for i_tekken in os.listdir(select_folder):
                if i_tekken in del_tekken_fsr3:
                    os.remove(os.path.join(select_folder,i_tekken))    
            if os.path.exists(path_assets_tekken):
                shutil.rmtree(path_assets_tekken)
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.') 
    
    try: 
        path_original_files = os.path.join(select_folder,'Backup')
        if os.path.exists(path_original_files):
            copy_original_files = messagebox.askyesno('Original Files','A Backup folder was found, do you want to restore the original game files?')
            if copy_original_files:
                shutil.copytree(path_original_files,select_folder,dirs_exist_ok=True)
            
            del_backup_folder = messagebox.askyesno('Delete Backup','Do you want to delete the Backup folder?')
            if del_backup_folder:
                shutil.rmtree(path_original_files)
             
    except Exception:
        messagebox.showinfo('Error','Error copying the original files, please select the path to the game\'s root folder, or if you prefer, perform the restoration manually; the Backup folder is located in the root of the game.')
        
    try:       
        if select_mod == 'Horizon Forbidden West FSR3':
            hfw_rtx_reg = "mods\\FSR3_HFW\\RTX FSR3\\RestoreNvidiaSignatureChecks.reg"
            hfw_ot_gpu_reg = "mods\\Temp\\disable signature override\\DisableSignatureOverride.reg"
            rtx_files = os.path.exists(os.path.join(select_folder,'RestoreNvidiaSignatureChecks.reg'))
            original_exe = os.path.join(select_folder,"HorizonForbiddenWestOriginalEXE.txt")
            
            if rtx_files:
                runReg(hfw_rtx_reg)
            else:
                runReg(hfw_ot_gpu_reg)         
                        
            for i_hfw in os.listdir(select_folder):
                if i_hfw in del_hfw_fsr:
                    os.remove(os.path.join(select_folder,i_hfw))
            
            if os.path.exists(original_exe):
                os.remove(os.path.join(select_folder,"HorizonForbiddenWest.exe"))
                os.rename(original_exe,os.path.join(select_folder,"HorizonForbiddenWest.exe"))

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
    
    try:
        if select_option == 'Indiana Jones and the Great Circle':
            indy_config_file_path = os.path.join(os.environ['USERPROFILE'], 'Saved Games\\MachineGames\\TheGreatCircle\\base')
            indy_old_config_file = os.path.join(indy_config_file_path, 'TheGreatCircleConfig.txt')

            if select_mod == 'Indy FG (Only RTX)':

                del_all_mods(del_dlss_to_fg, 'Indiana Jones and the Great Circle')
                
                if os.path.exists(indy_old_config_file):
                    os.remove(os.path.join(indy_config_file_path, 'TheGreatCircleConfig.local'))
                    os.rename(indy_old_config_file, os.path.join(indy_config_file_path, 'TheGreatCircleConfig.local'))

            if os.path.exists(os.path.join(select_folder, 'base\\video\\boot_sequence\\boot_sequence_pc.bk2')) and messagebox.askyesno('Intro Skip', 'Do you want to remove the Intro Skip?'):
                os.remove(os.path.join(select_folder, 'base\\video\\boot_sequence\\boot_sequence_pc.bk2'))
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Indiana Jones and the Great Circle files, please try again or do it manually') 
        print(e)         

    try:
        if select_option == 'Red Dead Redemption 2':
            del_all_mods_optiscaler(del_optiscaler, 'FSR 3.1.3/DLSS FG Custom RDR2', True)
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Red Dead Redemption 2 files, please try again or do it manually')

    try:
        if select_option == 'S.T.A.L.K.E.R. 2':
            root_stalker = os.path.abspath(os.path.join(select_folder, '..\\..'))

            del_others_mods(os.path.join(root_stalker, 'Content\\Paks\\~mods\\~S2optimizedTweaksBASE_v1.31_P.pak'), 'Do you want to remove the Anti Stutter?')
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Stalker 2 mods files, please try again or do it manually')
    
    try:
        if select_option == 'Assassin\'s Creed Mirage':

            if os.path.exists(os.path.join(select_folder,'Backup Ac Mirage')):
                if messagebox.askyesno('Intro Skip','Do you want to remove the Intro Skip?'):
                    shutil.copytree(os.path.join(select_folder,'Backup Ac Mirage'), os.path.join(select_folder, 'videos'), dirs_exist_ok=True)
                    shutil.rmtree(os.path.join(select_folder,'Backup Ac Mirage'))
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Assassin\'s Creed Mirage mods files, please try again or do it manually')
    
    try:
        if select_option == 'Lego Horizon Adventures':
            root_lego_hzd = os.path.abspath(os.path.join(select_folder,'..\\..\\..'))

            if os.path.exists(os.path.join(root_lego_hzd,'Backup Lego HZD')):
                if os.path.exists(os.path.join(root_lego_hzd,'Glow\\Content\\Movies')):
                    if messagebox.askyesno('Intro Skip','Do you want to remove the Intro Skip?'):
                            shutil.rmtree(os.path.join(root_lego_hzd,'Glow\\Content\\Movies')) 
                            shutil.copytree(os.path.join(root_lego_hzd,'Backup Lego HZD'), os.path.join(root_lego_hzd,'Glow\\Content'), dirs_exist_ok=True)
                            shutil.rmtree(os.path.join(root_lego_hzd,'Backup Lego HZD')) 
                else:
                    messagebox.showinfo('Exe','To remove the Intro Skip, select the folder containing the .exe file. The .exe file name is similar to "game name-Win64-Shipping.exe"')
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Lego Horizon Adventures mods files, please try again or do it manually')
    
    try:
        if select_option == 'Metro Exodus Enhanced Edition':

            if os.path.exists(os.path.join(select_folder, 'DefinitiveEdition.ini')):
                if messagebox.askyesno('Preset','Do you want to remove the Graphics Preset? To completely remove, delete the ReShade files'):
                    os.remove(os.path.join(select_folder, 'DefinitiveEdition.ini'))

    except Exception as e:
        messagebox.showinfo('Error','Error clearing Metro mods files, please try again or do it manually')
    
    try:
        if select_option == 'Dead Island 2':
            del_all_mods2(del_tcp_sr, 'FSR 3.1.3/DLSS FG (Only Optiscaler)')
            runReg('mods\\FSR3_DI2\\TCP\\DisableNvidiaSigOverride.reg')
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Saints Row mods files, please try again or do it manually')

    try:
        if select_option == 'Dead Rising Remaster':

            if os.path.exists(os.path.join(select_folder, 'reframework\\plugins\\dlssg_to_fsr3_amd_is_better.dll')):
                del_all_mods3(del_drr_dlss_to_fg_custom, 'FSR 3.1 FG DRR', os.path.join(select_folder, 'reframework\\plugins'))

                if os.path.exists(os.path.join(select_folder, 'dinput8.dll')):
                    os.remove(os.path.join(select_folder, 'dinput8.dll'))
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Dead Rising mods files, please try again or do it manually')

    try:
        if select_option == 'GTA V':
            path_dxgi = os.path.join(select_folder,'dxgi.dll')
            disable_dlss_overlay = 'mods\\Addons_mods\\DLSS Preset Overlay\\Disable Overlay.reg'

            del_all_mods2(del_gtav_fsr3,select_mod,'mods\\UpscalerBasePlugin')
            if os.path.exists(os.path.join(select_folder, 'mods\\Shaders')):
                shutil.rmtree(os.path.join(select_folder, 'mods\\Shaders'))

            if os.path.exists(path_dxgi):
                os.rename(path_dxgi,os.path.join(select_folder,'dxgi.asi'))
            
            if os.path.exists(os.path.join(select_folder, 'Enable Overlay.reg')):
                handle_prompt(
                'DLSS Overlay',
                'Do you want to disable the DLSS Overlay?',
                lambda _: (
                    runReg(disable_dlss_overlay),
                    os.remove(os.path.join(select_folder, 'Enable Overlay.reg'))
                    )
                )
    except Exception as e:
        messagebox.showinfo('Error','Error clearing GTA V mods files, please try again or do it manually')
    
    if select_option == 'Lords of the Fallen':
        del_all_mods(del_lotf_fsr3,'Lords of the Fallen','uniscaler')
    
    if select_option == 'The Callisto Protocol':
        if select_mod == 'The Callisto Protocol FSR3':
            del_all_mods(del_uni,'The Callisto Protocol','uniscaler')
            
        del_all_mods2(del_optiscaler,'FSR 3.1.3/DLSS Custom Callisto')
        
        if os.path.exists(os.path.join(select_folder + '\\The Real Life The Callisto Protocol Reshade BETTER TEXTURES and Realism 2022.ini')):
            del_real_life = messagebox.askyesno('Del Real Life','Do you want to remove the Real Life mod?')

            if del_real_life:
                os.remove(select_folder + '\\The Real Life The Callisto Protocol Reshade BETTER TEXTURES and Realism 2022.ini')
        
        if os.path.exists(os.path.join(select_folder + '\\TCP.ini')):
            del_tcp = messagebox.askyesno('Del TCP','Do you want to remove the TCP mod?')

            if del_tcp:
                os.remove(select_folder + '\\TCP.ini')
    
    try:
        if select_option == 'Resident Evil 4 Remake':
            if os.path.exists(os.path.join(select_folder,'reframework')):
                shutil.rmtree(os.path.join(select_folder,'reframework'))
                os.remove(os.path.join(select_folder,'dinput8.dll'))
    except Exception as e:
        messagebox.showinfo("RE4","Error clearing Resident Evil 4 Remake mods files, please try again or do it manually")

    try:
        if select_option == 'Silent Hill 2':
            folder_engine_sh2 = os.path.join(os.getenv('LOCALAPPDATA'),'SilentHill2\\Saved\\Config\\Windows')
            default_engine_ini_sh2 = 'mods\\FSR3_SH2\\Engine_ini\\Default\\Engine.ini'
            remove_fsr3_sh2_value = {'r.FidelityFX.FI.Enabled': '0'}
            remove_anti_stutter_sh2 = 'mods\\FSR3_SH2\\Anti_Stutter\\Uninstall Silent Hill 2 Remake High Priority Processes.reg'
            path_sh2 = os.path.abspath(os.path.join(select_folder,'..\\..\\..'))

            # FSR 3.1.1/DLSS FG RTX Custom
            if select_mod == 'FSR 3.1.1/DLSS FG RTX Custom':
                del_all_mods(del_dlss_rtx_custom,'Silent Hill 2')
            
            # DLSS FG RTX
            if select_mod == 'DLSS FG RTX':
                del_all_mods(del_sh2_dlss,'Silent Hill 2','reshade-shaders')
                if os.path.exists(os.path.join(select_folder,'mods')):
                    shutil.rmtree(os.path.join(select_folder,'mods'))

            # Ultra Plus
            if select_mod in ['Ultra Plus Complete','Ultra Plus Optimized']:
                del_others_mods(os.path.join(path_sh2,'SHProto\\Content\\Paks\\~UltraPlus_v0.8.0_P.pak'),'Do you want to remove the Ultra Plus?')
                del_others_mods(os.path.join(path_sh2,'SHProto\\Content\\Paks\\~UltraPlus_v1.0.4_P.pak'),'Do you want to remove the Ultra Plus?')
                shutil.copy(default_engine_ini_sh2,folder_engine_sh2)

            # Anti Stutter
            del_others_mods(select_folder + '\\AntiStutter.txt','Do you want to remove the Anti Stutter?',remove_anti_stutter_sh2)
            
            # Dll of RX 500/5000 and GTX gpus
            del_others_mods(os.path.join(select_folder,'D3D12.DLL'),'Do you want to remove the D3D12.dll file? It is necessary for the mod to work on RX 500/5000 series GPUs and GTX')

            # Unlock Cutscene FPS
            if del_others_mods(select_folder + '\\SilentHill2RemakeFPSRose.asi','Do you want to remove the Unlock Cutscene FPS'):
                os.remove(os.path.join(select_folder,'dsound.dll'))
            
            # intro Skip
            path_movies_sh2 = os.path.join(path_sh2,'SHProto\\Content\\Movies\\LoadingScreen.bk2')
            del_others_mods(path_movies_sh2,'Do you want to remove the Intro Skip?')
            
            # Ray Reconstruction
            path_dlss_dll_sh2 = os.path.join(path_sh2,'SHProto\\Plugins\\DLSS\\Binaries\\ThirdParty\\Win64\\nvngx_dlssd.dll')       
            if del_others_mods(path_dlss_dll_sh2,'Do you want to remove the Ray Reconstruction?'):
                if os.path.exists(os.path.join(folder_engine_sh2,'Engine.ini')):
                    os.remove(os.path.join(folder_engine_sh2,'Engine.ini'))
                    shutil.copy(default_engine_ini_sh2,folder_engine_sh2)

            # FSR3 FG Native SH2 and FSR3 FG Native SH2 + Optimization
            if os.path.exists(os.path.join(folder_engine_sh2,'NativeFSR3Opt.txt')) and messagebox.askyesno('Native FSR3 FG','Do you want to remove the Native FSR3 FG + Optimization?'):
                shutil.copy(default_engine_ini_sh2,folder_engine_sh2)
                os.remove(os.path.join(folder_engine_sh2,'NativeFSR3Opt.txt'))

            if os.path.exists(os.path.join(folder_engine_sh2,'NativeFSR3.txt')) and messagebox.askyesno('Native FSR3 FG','Do you want to remove the Native FSR3 FG?'):
                Remove_ini_effect('SystemSettings', remove_fsr3_sh2_value, folder_engine_sh2 + "\\Engine.ini",'Path not found, please select manually. The path to the Engine.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\SilentHill2\\Saved\\Config\\Windows.')      
                os.remove(os.path.join(folder_engine_sh2,'NativeFSR3.txt'))
            
            # Post Processing
            if os.path.exists(os.path.join(folder_engine_sh2,'PostProcessing.txt')):
                if del_others_mods(folder_engine_sh2 + '\\Engine.ini','Do you want to restore Post Processing Effetcs?'):
                    os.remove(os.path.join(folder_engine_sh2,'PostProcessing.txt'))
                    shutil.copy(default_engine_ini_sh2,folder_engine_sh2)
            
            # Graphics Preset
            if os.path.exists(os.path.join(select_folder, 'Silent hill dark.ini')):
                del_others_mods(os.path.join(select_folder, 'Silent hill dark.ini'), "Do you want to remove the Graphics Preset?It is necessary to uninstall the mod through ReShade to completely remove it",)
            
    except Exception as e:
        messagebox.showinfo("Silent Hill 2","Error clearing Silent Hill 2 mods files, please try again or do it manually")

    try:
        if select_option == 'Until Dawn':
            remove_anti_stutter_ud = 'mods\\FSR3_UD\\Anti Stutter\\Uninstall UD High CPU Priority.reg'
            ud_not_found_message = 'Path not found. The path to the Engine.ini file is something like this: Documents\\My Games\\Bates\\Saved\\Config\\Windows.'
            CSIDL_PERSONAL = 5
            ud_path_buffer = ctypes.create_unicode_buffer(260)
            ud_result = ctypes.windll.shell32.SHGetFolderPathW(0, CSIDL_PERSONAL, 0, 0, ud_path_buffer)
            enable_depth_field_ud = {'r.DepthOfFieldQuality':'1'}

            del_others_mods(os.path.join(select_folder + '\\AntiStutter.txt'),'Do you want to remove the Anti Stutter?',remove_anti_stutter_ud)

            if os.path.exists(os.path.join(select_folder,'PostProcessing.txt')):
                if ud_result == 0: 
                    ud_path_documents = ud_path_buffer.value
                    ud_path_folder_engine_ini = os.path.join(ud_path_documents, 'My Games', 'Bates', 'Saved', 'Config', 'Windows', 'Engine.ini')
                    
                    if os.path.exists(ud_path_folder_engine_ini):
                        Remove_ini_effect('SystemSettings', enable_depth_field_ud, ud_path_folder_engine_ini, ud_not_found_message,'Depth of field activated successfully')
                    else:
                        messagebox.showinfo('Not Found',ud_not_found_message)
            else:
                messagebox('Documents','Documents folder not found, please check if there are permissions for the Utility to access the folder')

    except Exception as e:
            messagebox.showinfo("Until Dawn","Error clearing Until Dawn mods files, please try again or do it manually")

    try: 
        if select_option == 'A Quiet Place: The Road Ahead':
            if select_mod == 'FSR 3.1.1/DLSS Quiet Place':
                del_all_mods2(del_optiscaler,'FSR 3.1.1/DLSS Quiet Place')
                runReg('mods\\Temp\\disable signature override\\DisableSignatureOverride.reg')
    except Exception:
           messagebox.showinfo("A Quiet Place","Error clearing A Quiet Place mods files, please try again or do it manually")  

    try:
        if select_option == 'Suicide Squad: Kill the Justice League':
            sskjl_root_path = os.path.abspath(os.path.join(select_folder, '..\\..\\..'))

            if os.path.exists(os.path.join(sskjl_root_path, 'Backup EAC')):
                if messagebox.askyesno('EAC', 'Do you want to enable EAC (Easy Anti-Cheat)?'):
                    shutil.rmtree(os.path.join(sskjl_root_path, 'EasyAntiCheat'))
                    shutil.copytree(os.path.join(sskjl_root_path, 'Backup EAC'), sskjl_root_path, dirs_exist_ok=True)
                shutil.rmtree(os.path.join(sskjl_root_path, 'Backup EAC'))

    except Exception:
           messagebox.showinfo("SSKJL","Error clearing Suicide Squad: Kill the Justice League mods files, please try again or do it manually")  

    try:
        if select_option == 'Hogwarts Legacy':
            hl_remove_anti_stutter = 'mods\\FSR3_HL\\Anti Stutter\\Uninstall Hogwarts Legacy CPU Priority.reg'

            # Anti Stutter
            del_others_mods(os.path.join(select_folder,'AntiStutter.txt'), 'Do you want to remove the Anti Stutter?',hl_remove_anti_stutter)
    
    except Exception:
        messagebox.showinfo("Hogwarts Legacy","Error clearing Hogwarts Legacy mods files, please try again or do it manually")

    try:
        if select_option == 'God Of War 4':
            path_backup_dll = os.path.join(select_folder,'Backup Dll')
            path_var_go4 = os.path.join(select_folder,'optiscaler.txt')
            gow4_reg = "mods\\Temp\\disable signature override\\DisableSignatureOverride.reg"

            del_all_mods(del_optiscaler,'God Of War 4')

            if os.path.exists(path_backup_dll):
                shutil.rmtree(path_backup_dll)
            if os.path.exists(path_var_go4):
                os.remove(path_var_go4)
            
            runReg(gow4_reg)                    
    except Exception:
        messagebox.showinfo("Optiscaler","Error clearing Optiscaler files, please try again or do it manually")
    
    try:
        if select_option == 'God of War Ragnarök':
            gow_rag_disable_anti_stutter = 'mods\\FSR3_GOW_RAG\\God of War Ragnarök\\Anti-Stutter GoW Ragnarok\\Uninstall GoWR High CPU Priority.reg'
            gow_rag_intro_files = ['pss_studios.bk2','pss_studios_30.bk2','pss_studios_4k_30.bk2']
            gow_rag_path_intro = select_folder + '\\exec\\cinematics'

            if os.path.exists(os.path.join(select_folder,'exec')):
                
                if os.path.exists(os.path.join(select_folder,'Vram.txt')):
                    if messagebox.askyesno('Vram','Do you want to remove the Unlock Vram?'):
                        os.remove(select_folder + '\\Vram.txt')
                        os.remove(select_folder + '\\dxgi.dll')

                if os.path.exists(os.path.join(select_folder,'Anti_Stutter.txt')):
                    if messagebox.askyesno('Anti Stutter','Do you want to remove the Anti Stutter'):
                        runReg(gow_rag_disable_anti_stutter)
                        os.remove(select_folder + '\\Anti_Stutter.txt')
                
                if os.path.exists(os.path.join(gow_rag_path_intro, 'pss_studios.bk2')):
                    if messagebox.askyesno('Intro Skip', 'Do you want to remove the Intro Skip?'):
                        for intro_file in gow_rag_intro_files:
                            files_intro = os.path.join(gow_rag_path_intro, intro_file)
                            if os.path.exists(files_intro):
                                os.remove(files_intro)
    except Exception:
        messagebox.showinfo('Error','Could not remove the mod. Please close all folders related to the game and try again')
    
    if select_option == 'Ghost of Tsushima':
        reg_folder = 'mods\\FSR3_GOT\\Remove_Post_Processing\\restore'
        got_reg = "mods\\FSR3_GOT\\DLSS FG\\RestoreNvidiaSignatureChecks.reg"
        
        try:
            if os.path.exists(os.path.join(select_folder,'no-filmgrain.reg')):
                restore_post_processing = messagebox.askyesno('Restore Post Processing','Would you like to restore the post-processing effects?')
                
                if restore_post_processing:
                    for file_reg in os.listdir(reg_folder):
                        if file_reg.endswith('.reg'):
                            reg_path = os.path.join(reg_folder,file_reg)
                            
                            subprocess.run(['reg','import',reg_path],check=True)
        except Exception as e:
            messagebox.showerror('Error','It was not possible to remove the post-processing effects. Please try again.')
             
        runReg(got_reg)
        del_all_mods(del_got,'Ghost of Tsushima')

    try:         
        if select_option == 'Hellblade 2':
            cpu_reg = "mods\\FSR3_HB2\\Cpu_Hb2\\Uninstall Hellblade 2 CPU Priority.reg"
            hb2_reg = "mods\\FSR3_GOT\\DLSS FG\\RestoreNvidiaSignatureChecks.reg"
            
            if select_mod == 'Hellblade 2 FSR3 (Only RTX)':               
                del_all_mods3(del_hb2,'Hellblade 2')       
                runReg(hb2_reg)
            
            if os.path.exists(os.path.join(select_folder,"Install Hellblade 2 CPU Priority.reg")):
            
                # Remove Anti Stutter
                handle_prompt(
                'Anti Stutter',
                'Would you like to remove the Anti Stutter?',
                lambda _: (
                    runReg(cpu_reg),
                    os.remove(os.path.join(select_folder,"Install Hellblade 2 CPU Priority.reg"))
                    )
                )
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Hellblade 2 files, please try again or do it manually')
            
    if select_option == 'Assassin\'s Creed Valhalla':
        folder_ac = os.path.join(select_folder,'reshade-shaders')
        del_all_mods(del_valhalla_fsr3,'Assassin\'s Creed Valhalla','mods')
        shutil.rmtree(folder_ac)

    try:
        if select_option == 'Control':
            bak_control_hdr = os.path.join(select_folder, 'HDR Control')
            # Remove the files from the HDR Path.
            if os.path.exists(bak_control_hdr):
                shutil.copytree(bak_control_hdr, select_folder, dirs_exist_ok=True)
                shutil.rmtree(bak_control_hdr)
    except Exception as e:
        messagebox.showinfo('Error','Error clearing Controlfiles, please try again or do it manually')

    try:
        if select_option == 'Alan Wake 2':
            aw2_appdata = os.getenv("LOCALAPPDATA")
            folder_ini_aw2 = aw2_appdata + '\\Remedy\\AlanWake2'
            path_old_iniaw2 = folder_ini_aw2 + '\\renderer.ini'
            path_new_iniaw2 = os.path.abspath(os.path.join(folder_ini_aw2,'..')) #Look for the backup file renderer.ini in the path C:\\Users\\YourName\\AppData\\Local\\Remedy
            remove_anti_stutter_aw2 =  'mods\\FSR3_AW2\\Anti Stutter\\Uninstall Alan Wake 2 CPU Priority.reg' 

            if select_mod == 'Alan Wake 2 FG RTX':
                del_all_mods2(del_aw2_rtx, 'Alan Wake 2 FG RTX')

            # Anti Stutter
            if os.path.exists(os.path.join(select_folder, 'AntiStutter.txt')):      
                if messagebox.askyesno('Anti Stutter','Do you want to remove the Anti Stutter?'):
                    runReg(remove_anti_stutter_aw2)
                    os.remove(os.path.join(select_folder, 'AntiStutter.txt'))
            
            #Control RT
            if os.path.exists(path_new_iniaw2 + '\\renderer.ini') and os.path.exists(os.path.join(select_folder, 'VarRT.txt')):
                
                if messagebox.askyesno('RT','Do you want to remove the Control RT?'):
                    shutil.copy(path_new_iniaw2 +'\\renderer.ini', folder_ini_aw2)
                    os.remove(path_new_iniaw2 + '\\renderer.ini')
                    os.remove(os.path.join(select_folder, 'VarRT.txt'))

            # Realistic Preset
            if os.path.exists(os.path.join(select_folder, 'Realistic Reshade.ini')):
                if messagebox.askyesno('Preset', 'Do you want to remove the Realistic Preset?To completely uninstall, it is necessary to remove the ReShade files'):
                    os.remove(os.path.join(select_folder, 'Realistic Reshade.ini'))

                    if os.path.exists(os.path.join(select_folder,'D3D12.dll')):
                        if os.path.exists(os.path.join(select_folder, 'dxgi.dll')):
                            os.remove(os.path.join(select_folder, 'dxgi.dll'))
                        os.rename(os.path.join(select_folder, 'D3D12.dll'), os.path.join(select_folder, 'dxgi.dll'))

            # Post Processing
            if os.path.exists(path_new_iniaw2 + '\\renderer.ini') and os.path.exists(os.path.join(select_folder, 'VarPost.txt')): 
                if messagebox.askyesno('Post-processing','Do you want to restore the post-processing effects?'):
                    shutil.copy(path_new_iniaw2 + '\\renderer.ini',folder_ini_aw2)
                    os.remove(path_new_iniaw2 + '\\renderer.ini')

    except Exception as e:
        messagebox.showinfo('Error','Error clearing Alan Wake 2 files, please try again or do it manually')

    try: 
        if select_addon_mods == "OptiScaler":
            if os.path.exists(os.path.join(select_folder,'amd_fidelityfx_vk.dll')):
                for optis_files in os.listdir(select_folder):
                    if optis_files in del_optiscaler:
                        os.remove(os.path.join(select_folder,optis_files))
            
            if os.path.exists(os.path.join(select_folder,'Backup Dll')):
                shutil.copytree(os.path.join(select_folder,'Backup Dll'),select_folder,dirs_exist_ok=True)
                shutil.rmtree(os.path.join(select_folder,'Backup Dll'))
        optiscaler_reg = "mods\\Addons_mods\\OptiScaler\\EnableSignatureOverride.reg"
            
        runReg(optiscaler_reg)
    except Exception:
        messagebox.showinfo("Optiscaler","Error clearing Optiscaler files, please try again or do it manually")
    
    try:
        if select_mod == 'FSR 3.1.2/DLSS FG Custom':
            disable_sig_over_fsr31 = 'mods\\Temp\\disable signature override\\DisableSignatureOverride.reg'
            
            del_fsr_dlss_mods(del_dlss_amd, del_dlss_rtx,'FSR 3.1.2/DLSS FG Custom',disable_sig_over_fsr31)
    except Exception as e:
        messagebox.showinfo("Error","Error clearing FSR 3.1.2/DLSS FG Custom files, please try again or do it manually")
    
    try:
        if select_mod in mods_to_install_optiscaler_fsr_dlss:
            disable_sig_over_fsr32 = 'mods\\Optiscaler FSR 3.1 Custom\\RestoreNvidiaSignatureChecks.reg'
            disable_dlss_overlay = 'mods\\Addons_mods\\DLSS Preset Overlay\\Disable Overlay.reg'

            del_all_mods_optiscaler(del_optiscaler, select_mod, True)
            runReg(disable_sig_over_fsr32)

            if os.path.exists(os.path.join(select_folder, 'Enable Overlay.reg')):
                handle_prompt(
                'DLSS Overlay',
                'Do you want to disable the DLSS Overlay?',
                lambda _: (
                    runReg(disable_dlss_overlay),
                    os.remove(os.path.join(select_folder, 'Enable Overlay.reg'))
                    )
                )

    except Exception as e:
        messagebox.showinfo("Error",f"Error clearing {select_mod} files, please try again or do it manually")
        print(e)

    try: 
        if select_mod == 'FSR 3.1.1/DLSS Optiscaler':
            if os.path.exists(os.path.join(select_folder,'amd_fidelityfx_vk.dll')):
                for optis_custom_files in os.listdir(select_folder):
                    if optis_custom_files in del_optiscaler_custom:
                        os.remove(os.path.join(select_folder,optis_custom_files))
            
        optiscaler_custom_reg = "mods\\Addons_mods\\OptiScaler\\EnableSignatureOverride.reg"
            
        runReg(optiscaler_custom_reg)
    except Exception:
        messagebox.showinfo("Optiscaler Custom","Error clearing Optiscaler Custom files, please try again or do it manually")
    
    try:
        if os.path.exists(os.path.join(select_folder,'dlss_amd.txt')):
            for cod_amd in os.listdir(select_folder):
                if cod_amd in del_dlss_amd:
                    os.remove(os.path.join(select_folder,cod_amd))
        
        elif os.path.exists(os.path.join(select_folder,'dlss_rtx.txt')):
            for cod_rtx in os.listdir(select_folder):
                if cod_rtx in del_dlss_rtx:
                    os.remove(os.path.join(select_folder,cod_rtx))  

        cod_reg = "mods\\Addons_mods\\OptiScaler\\DisableSignatureOverride.reg"
            
        runReg(cod_reg)
    except Exception:
        messagebox.showinfo("COD MW3 FSR3","Error clearing COD MW3 FSR3 files, please try again or do it manually")

    try:    
        path_uni = os.path.join(select_folder,'uniscaler')
        path_uni_asi = os.path.join(select_folder,'Uniscaler.asi')
        
        if any (select_option in opt for opt in (fsr_2_0_opt, fsr_2_1_opt, fsr_2_2_opt,fsr_sdk_opt)):
            for item in os.listdir(select_folder):
                if item in mod_clean_list:
                    os.remove(os.path.join(select_folder,item))
        
        if os.path.exists(path_uni) or os.path.exists(path_uni_asi):
            for i_uni in os.listdir(select_folder):
                if i_uni in del_uni:
                    os.remove(os.path.join(select_folder,i_uni))
            
            if os.path.exists(path_uni):
                shutil.rmtree(path_uni)
                        
    except Exception as e:
        messagebox.showinfo('Error','Unable to delete the Uniscaler folder, please close the game or any other folders related to the game.')
    
    try:
        if select_option == 'Black Myth: Wukong':
            if os.path.exists(os.path.join(select_folder,'dlssg_to_fsr3_amd_is_better.dll')):
                for wukong_files_rtx in os.listdir(select_folder):
                    if wukong_files_rtx in del_dlss_to_fg:
                        os.remove(os.path.join(select_folder,wukong_files_rtx))

                wukong_reg = "mods\\Addons_mods\\OptiScaler\\EnableSignatureOverride.reg"

                runReg(wukong_reg)

            if select_mod == "FSR 3.1 Custom Wukong":
                files_fsr31_wukong = ['amd_fidelityfx_dx12.dll','amd_fidelityfx_vk.dll','libxess.dll']

                for files_31_wukong in os.listdir(select_folder):
                    if files_31_wukong in files_fsr31_wukong:
                        os.remove(os.path.join(select_folder,files_31_wukong))

            fullpath_optimize_wukong_del = os.path.abspath(os.path.join(select_folder, '..\\..\\Content\\Paks'))

            files_to_check = {
                '\\~mods\\pakchunk99-Mods_CustomMod_P.pak': 'Do you want to remove the optimization mod?',
                '\\~mods\\Force_HDR_Mode_P.pak': 'Do you want to remove the HDR correction?',
            }
            
            for path_wukong_mods, message in files_to_check.items():
                ask_and_remove(fullpath_optimize_wukong_del + '\\' + path_wukong_mods, message)
            
            path_map_wukong = fullpath_optimize_wukong_del + '\\LogicMods'
            if os.path.exists(path_map_wukong):
                if messagebox.askyesno('Remove Map', 'Do you want to remove the mini map?'):
                    shutil.rmtree(path_map_wukong)
                    
                    if os.path.exists(select_folder + '\\dwmapi.dll'):
                        os.remove(select_folder + '\\dwmapi.dll')
                        shutil.rmtree(select_folder + '\\ue4ss')
            
            path_anti_stutter = select_folder + '\\Anti-Stutter - Utility.txt'
            if os.path.exists( path_anti_stutter):
                if messagebox.askyesno('Remove Anti Stutter','Do you want to remove the Anti Stuttering?'):
                    wukong_anti_stutter_reg = r"mods\\FSR3_WUKONG\\HIGH CPU Priority\\Uninstall Black Myth Wukong High Priority Processes.reg"

                    runReg(wukong_anti_stutter_reg)

                    os.remove(select_folder + '\\Anti-Stutter - Utility.txt')
                
    except Exception as e:
        messagebox.showinfo('Error','It was not possible to remove the mod files from \'Black Myth: Wukong Bench Tool\'. Please close the game or any other folders related to the game and try again.')

    try:
        if select_option == 'Final Fantasy XVI':
            ffxvi_reg = "mods\\Addons_mods\\OptiScaler\\EnableSignatureOverride.reg"
            ffxvi_fix_list = ['UltimateASILoader_LICENSE.md','FFXVIFix.ini','FFXVIFix.asi','EXTRACT_TO_GAME_FOLDER','dinput8.dll']

            if os.path.exists(os.path.join(select_folder,'dlssg_to_fsr3_amd_is_better.dll')):
                for ffxvi_rtx in os.listdir(select_folder):
                    if ffxvi_rtx in del_dlss_to_fg:
                        os.remove(os.path.join(select_folder,ffxvi_rtx))

            if os.path.exists(os.path.join(select_folder,'dlss_amd.txt')):
                for ffxvi_amd in os.listdir(select_folder):
                    if ffxvi_amd in del_dlss_amd:
                        os.remove(os.path.join(select_folder,ffxvi_amd))
            
            elif os.path.exists(os.path.join(select_folder,'dlss_rtx.txt')):
                for ffxvi_rtx in os.listdir(select_folder):
                    if ffxvi_rtx in del_dlss_rtx:
                        os.remove(os.path.join(select_folder,ffxvi_rtx))  

            ffxvi_reg_global = "mods\\Addons_mods\\OptiScaler\\DisableSignatureOverride.reg"

            if os.path.exists(os.path.join(select_folder,'dlss_amd.txt') or os.path.join(select_folder,'dlss_rtx.txt')):   
                runReg(ffxvi_reg_global)
            
            del_others_mods(select_folder + '\\Anti_Stutter.txt','Do you want to remove the Anti Stutter?',ffxvi_reg)

            if os.path.exists(os.path.join(select_folder,'UltimateASILoader_LICENSE.md')):
                if messagebox.askyesno('FFXVI FIX','Do you want to remove the FFVXVI FIX?'):

                    for ffxvi_fix_files in os.listdir(select_folder):
                        if ffxvi_fix_files in ffxvi_fix_list:
                            os.remove(os.path.join(select_folder,ffxvi_fix_files))
            
            if os.path.exists(os.path.join(select_folder,'Backup_DXGI\\dxgi.dll')):
                shutil.copy(os.path.join(select_folder,'Backup_DXGI\\dxgi.dll'),select_folder)
                shutil.rmtree(os.path.join(select_folder,'Backup_DXGI'))

                if os.path.exists(os.path.join(select_folder,'d3d12.dll')):
                    os.remove(os.path.join(select_folder,'d3d12.dll'))

    except Exception as e:
            messagebox.showinfo('Error','It was not possible to remove the mod files from Final Fantasy XVI. Please close the game or any other folders related to the game and try again.')

    try:
        if select_option == 'Red Dead Redemption':
            remove_anti_stutter_rdr1 = 'mods\\FSR3_RDR1\\Anti Stutter\\RDR_PerformanceBoostDISABLE.reg'
            del_unlock_fps_rdr1 = ['SUWSF.asi','dinput8.dll','SUWSF.ini']

            if select_mod == 'Others Mods RDR1':
                del_others_mods(os.path.join(select_folder, 'AntiStutter.txt'), 'Do you want to remove the Anti Stutter?', remove_anti_stutter_rdr1)
                del_others_mods(os.path.join(select_folder, 'Red Dead Redemption.ini'), 'Do you want to remove the Graphics Preset? It is necessary to remove the ReShade files to completely uninstall it.')
                del_others_mods(os.path.join(select_folder,'game\\tune_d11generic.rpf'), 'Do you want to remove the Intro Skip?')
                del_others_mods(os.path.join(select_folder, 'game\\fonts.rpf'), 'Do you want to remove the DualShock 4 buttons? (This will restore the game\'s default buttons (Xbox)).')
                del_others_mods2(select_folder, 'Do you want to remove the Unlock FPS?', del_unlock_fps_rdr1)

                if os.path.exists(os.path.join(select_folder, 'game\\vfx.txt')):
                    if del_others_mods(os.path.join(select_folder, 'game\\vfx.rpf'), 'Do you want to remove the 4x Texture?'):
                        os.rename(os.path.join(select_folder, 'game\\vfx.txt'), os.path.join(select_folder, 'game\\vfx.rpf'))
    except Exception:
        messagebox.showinfo('Error','Error clearing Red Dead Redemption files, please try again or do it manually')

    try:
        if select_option == 'STAR WARS Jedi: Survivor':
            root_path_jedi = os.path.abspath(os.path.join(select_folder,'..\\..\\..\\SwGame'))

            del_others_mods(root_path_jedi + '\\Content\\Paks\\pakchunk99-Mods_CustomMod_P.pak', 'Do you want to remove the Fix RT mod?')
            del_others_mods(root_path_jedi + '\\Content\\Paks\\SWJSFAI.pak', 'Do you want to remove the Anti Stutter mod?')
            del_others_mods(root_path_jedi + '\\Content\\Movies\\Default_Startup.mp4', 'Do you want to remove the Intro Skip?')
                
    except Exception as e:
        messagebox.showinfo('Error','It was not possible to remove the mod files from Star Wars Jedi: Survivor. Please close the game or any other folders related to the game and try again.')                             

    try:
        if select_option == 'Star Wars Outlaws':
            remove_anti_stutter_outlaws = "mods\\FSR3_Outlaws\\Anti_Stutter\\Uninstall Star Wars Outlaws CPU Priority.reg"
            
            del_all_mods2(del_dlss_to_fg,'Outlaws DLSS RTX')

            if select_mod == 'FSR 3.1.2/DLSS FG Custom':
                if messagebox.askyesno('GPU','Do you have an RTX GPU?'):
                    del_all_mods(del_dlss_rtx,'Star Wars Outlaws')
                else:
                    del_all_mods(del_dlss_amd,'Star Wars Outlaws')

            if os.path.exists(os.path.join(select_folder,'Anti_Sttuter.txt')):
                outlaws_anti_stutter = messagebox.askyesno('Remove Anti Stutter','Do you want to remove the Anti Stutter?')

                if outlaws_anti_stutter:
                    os.remove(os.path.join(select_folder,'Anti_Sttuter.txt'))
                    runReg(remove_anti_stutter_outlaws)
    except Exception:   
        messagebox.showinfo('Error','It was not possible to remove the mod files from Star Wars Outlaws. Please close the game or any other folders related to the game and try again.')                             
                                              
cleanup_label = tk.Label(screen,text='Cleanup Mod',font=font_select,bg='black',fg='#E6E6FA')
cleanup_label.place(x=0,y=476) 
cleanup_var = IntVar()
cleanup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=cleanup_var,command=cbox_cleanup)
cleanup_cbox.place(x=100,y=479)       

#Disables the CMD console when starting the game,this function is only available in the mods listed below
disable_var = None
def cbox_disable_console():
   global disable_var
   disable_var = bool(disable_console_var.get())
   edit_disable_console()

def edit_disable_console():
    disable_console_list = {
        '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
        '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
        'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
        'Uniscaler + Xess + Dlss':'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
        'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
        'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
        'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
        'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
    }
    key_disable = 'logging'
    
    disable_console_folder  = None
    if select_mod in disable_console_list:
        disable_console_folder = disable_console_list[select_mod]
    
    if disable_console_folder is not None:
        with open(disable_console_folder,'r') as file:
            toml_dis = toml.load(file)
        toml_dis.setdefault(key_disable,{})
        toml_dis[key_disable]['disable_console'] = disable_var
        with open(disable_console_folder,'w') as file:
            toml.dump(toml_dis,file)
        
disable_console_label = tk.Label(screen,text='Disable Console',font=font_select,bg='black',fg='#C0C0C0')
disable_console_label.place(x=0,y=296)
disable_console_var = IntVar()
disable_console_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=disable_console_var,command=cbox_disable_console)
disable_console_cbox.place(x=117,y=299)

#For enabling FSR3FG debug overlay, through the .toml file
var_debug_tear = None
def cbox_debug_tear_lines():
    global var_debug_tear
    var_debug_tear = bool(debug_tear_lines_var.get())
    edit_debug_tear_lines()

def edit_debug_tear_lines():
    debug_tear_lines_list = {
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
    }
    
    debug_tear_mod = None
    if select_mod in debug_tear_lines_list:
        debug_tear_mod = debug_tear_lines_list[select_mod]
    key_debug_tear = 'debug'
    
    if debug_tear_mod is not None:
        with open(debug_tear_mod, 'r') as file:
            toml_tear = toml.load(file)
        toml_tear.setdefault(key_debug_tear,{})
        toml_tear[key_debug_tear]['enable_debug_tear_lines'] = var_debug_tear
        with open(debug_tear_mod, 'w') as file:
            toml.dump(toml_tear,file)
      
debug_tear_lines_label = tk.Label(screen,text='Debug Tear Lines',font=font_select,bg='black',fg='#C0C0C0')
debug_tear_lines_var = IntVar()
debug_tear_lines_label.place(x=200,y=296)
debug_tear_lines_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_tear_lines_var,command=cbox_debug_tear_lines)
debug_tear_lines_cbox.place(x=329,y=299)

var_deb_view = False
def cbox_debug_view():
    global var_deb_view
    var_deb_view = bool(debug_view_var.get())
    edit_debug_view()
    
def edit_debug_view():
    global var_deb_view
    debug_view_mod_list = {
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
    }
    
    debug_mod_folder = None
    if select_mod in debug_view_mod_list:
        debug_mod_folder = debug_view_mod_list[select_mod]
        key_debug = 'debug'
    
    if debug_mod_folder is not None:
        with open(debug_mod_folder,'r') as file:
            toml_deb = toml.load(file)
        toml_deb.setdefault(key_debug,{})
        toml_deb[key_debug]['enable_debug_view'] = var_deb_view
        with open(debug_mod_folder,'w') as file:
            toml.dump(toml_deb,file)
        
debug_view_label = tk.Label(screen,text='Debug View',font=font_select,bg='black',fg='#C0C0C0')
debug_view_label.place(x=200,y=266)
debug_view_var = IntVar()
debug_view_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_view_var,command=cbox_debug_view)
debug_view_cbox.place(x=290,y=269)

#Helps the mod work in some specific games, for example, The Callisto Protocol, 2 values are added to the registry editor, the path is available in the .reg file in the Temp folder
def enable_over():
    en_sig_over = 'mods\\Temp\\enable signature override\\EnableSignatureOverride.reg'   
    runReg(en_sig_over)

def disable_over():
    dis_sig_over = 'mods\\Temp\\disable signature override\\DisableSignatureOverride.reg'
    runReg(dis_sig_over)
        
def cbox_enable_sigover():
    if enable_sigover_var.get() == 1:
        enable_over()
    
enable_sigover_label = tk.Label(screen,text='Enable Signature Over',font=font_select,bg='black',fg='#C0C0C0')
enable_sigover_label.place(x=0,y=386)
enable_sigover_var = IntVar()
enable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=enable_sigover_var,command=cbox_enable_sigover)
enable_sigover_cbox.place(x=165,y=389)

def cbox_disable_sigover():
    if disable_sigover_var.get() == 1:
        disable_over()

disable_sigover_label = tk.Label(screen,text='Disable Signature Over',font=font_select,bg='black',fg='#C0C0C0')
disable_sigover_label.place(x=200,y=386)
disable_sigover_var = IntVar()
disable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=disable_sigover_var,command=cbox_disable_sigover)
disable_sigover_cbox.place(x=373,y=389)
guide_fsr_label.lift(disable_sigover_label)
guide_fsr_label.lift(disable_sigover_cbox)

#Copy the selected .dll file, it can help old mods work in specific games
dxgi_contr = False
def cbox_dxgi():
    global dxgi_contr
    if dxgi_var.get() == 1:
        dxgi_contr = True
        dxgi_canvas.configure(bg='white')
    else:
        dxgi_contr = False
        dxgi_canvas.configure(bg='#C0C0C0')
        dxgi_listbox_contr()

dxgi_view = False
def dxgi_cbox_view(event=None):
    global dxgi_view,dxgi_contr
    if dxgi_contr:
        if dxgi_view:
            dxgi_listbox.place_forget()
            dxgi_view = False
        else:
            dxgi_listbox.place(x=295,y=441)
            dxgi_view = True
      
def dxgi_listbox_contr():
    global dxgi_view,dxgi_contr
    if not dxgi_contr and dxgi_view:
        dxgi_listbox.place_forget()
        dxgi_view = False

copy_all_dxgi = None       
def copy_dxgi():
    global copy_all_dxgi
    
    dxgi_folders = {}
    path_dxgi_global = 'mods\\Temp\\dxgi_global'
    for dxgi_key in  ['0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1',
                    '0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1']:
    
        dxgi_folders[dxgi_key] = path_dxgi_global
           
    dxgi_folder = dxgi_folders.get(select_mod)
    
    if select_mod not in dxgi_folders and select_folder != None:
        messagebox.showinfo('Error','Please select a version starting 0.8.0')
        
    elif select_mod not in dxgi_folders and select_folder == None:
        messagebox.showinfo('Error','Please select the destination folder')
        
    try:
        
        for item in os.listdir(dxgi_folder):
            dxgi_path = os.path.join(dxgi_folder,item)
            
            if os.path.isfile(dxgi_path):
                if select_dxgi == 'D3D12 DLL' and item == 'd3d12.dll':
                    shutil.copy2(dxgi_path,select_folder)
                elif select_dxgi == 'DXGI DLL' and item == 'dxgi.dll':
                    shutil.copy2(dxgi_path,select_folder)
                    
    except Exception as e:
        if select_mod in dxgi_folders and select_folder == None:
            messagebox.showinfo('Error','Please select the destination folder')
           
dxgi_label = tk.Label(screen,text='Dxgi.dll',font=font_select,bg='black',fg='#C0C0C0')
dxgi_label.place(x=210,y=416)
dxgi_var = IntVar()
dxgi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=dxgi_var,command=cbox_dxgi)
dxgi_cbox.place(x=270,y=418)
dxgi_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
dxgi_canvas.place(x=295,y=421)
dxgi_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)

#Copy .dll files that can help specific games to function. The Default option includes the default nvngx.dll, and it also has the files DLSS 3.8.10 and XESS 1.3
nvngx_contr = False
def cbox_nvngx():
    global nvngx_contr
    if nvngx_var.get() == 1:
        nvngx_contr = True
        nvngx_canvas.configure(bg='white')
    else:
        nvngx_contr = False
        nvngx_canvas.configure(bg='#C0C0C0')
    nvngx_listbox_contr()

nvngx_view = False
def nvngx_cbox_view(event=None):
    global nvngx_view,nvngx_contr
    if nvngx_contr:
        if nvngx_view:
            nvngx_listbox.place_forget()
            nvngx_view = False
        else:
            nvngx_listbox.place(x=100,y=442)
            nvngx_view = True
            
def nvngx_listbox_contr():
    global nvngx_view
    if not nvngx_contr and nvngx_view:
        nvngx_listbox.place_forget()
        nvngx_view = False
    
nvngx_label = tk.Label(screen,text='Nvngx.dll',font=font_select,bg='black',fg='#C0C0C0')
nvngx_label.place(x=0,y=416)
nvngx_var = IntVar()
nvngx_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=nvngx_var,command=cbox_nvngx)
nvngx_cbox.place(x=73,y=419)
nvngx_canvas = tk.Canvas(screen,width=103,height=19,bg='#C0C0C0',highlightthickness=0)
nvngx_canvas.place(x=100,y=422)
nvngx_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)
nvngx_listbox.pack(side=tk.RIGHT,expand=True,padx=(0,15),pady=(0,410))
nvngx_listbox.place(x=130,y=422)
nvngx_listbox.place_forget()
uni_custom_listbox.lift(nvngx_canvas)

nvngx_path_global = 'mods\\Temp\\nvngx_global\\nvngx'
nvngx_folders = {}

for nvn_key in [
    '0.7.6', '0.8.0', '0.9.0', '0.10.0', '0.10.1', '0.10.1h1', 
    '0.10.2h1', '0.10.3', '0.10.4' 'Uniscaler', 'Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1','FSR 3.1.1/DLSS Optiscaler','FSR 3.1.2/DLSS FG Custom', 'FSR 3.1.3/DLSS FG (Only Optiscaler)','FSR 3.1.3/DLSSG FG (Only Optiscaler)'
]:
    nvngx_folders[nvn_key] = nvngx_path_global

def copy_nvngx():
    global nvngx_folders, nvngx_contr
    nvngx_folder = nvngx_folders.get(select_mod)
    path_nvngx_uni_v2 =  'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\stub_nvngx\\nvngx.dll'
    path_nvngx_uni_fsr31 = 'mods\\Temp\\nvngx_global\\nvngx\\nvngx_uni_fsr3\\nvngx.dll'
    path_nvngx_0_10_4 = 'mods\\Temp\\nvngx_global\\nvngx\\nvngx_0_10_4\\nvngx.dll'
    
    if select_mod not in nvngx_folders:
        messagebox.showinfo('0.7.6','The selected mod has been installed. To use the Nvngx.dll option, select a mod version starting from 0.7.6')
    else:
        try:
            for item in os.listdir(nvngx_folder):
                nvn_path = os.path.join(nvngx_folder, item)

                if os.path.isfile(nvn_path) and select_nvngx == 'Default':
                    if select_mod != "Uniscaler V2" and select_mod != 'Uniscaler FSR 3.1' and select_mod != '0.10.4':
                        if item == 'nvngx.dll':
                            shutil.copy2(nvn_path, select_folder)
                    elif select_mod == 'Uniscaler FSR 3.1':
                        shutil.copy2(path_nvngx_uni_fsr31,select_folder)
                    elif  select_mod == '0.10.4':
                        shutil.copy2(path_nvngx_0_10_4,select_folder)
                    else:
                        shutil.copy2(path_nvngx_uni_v2, select_folder)   

                elif os.path.isfile(nvn_path) and select_nvngx == 'NVNGX Version 1':
                    if item == 'nvngx.ini':
                        shutil.copy2(nvn_path, select_folder)
                        
                elif os.path.isfile(nvn_path) and select_nvngx == 'XESS 1.3.1':
                    if item == 'libxess.dll':
                        name_libxess = os.path.join(select_folder,'libxess.dll')
                        name_libxess_old = os.path.join(select_folder,'libxess.txt')
                        rename_libxess = 'libxess.txt'
                        if os.path.exists(name_libxess) and not os.path.exists(name_libxess_old):
                            os.rename(name_libxess,os.path.join(select_folder,rename_libxess))
                        shutil.copy2(nvn_path, select_folder)  
                
                elif os.path.isfile(nvn_path) and select_nvngx == 'DLSS 3.8.10':
                    if item == 'nvngx_dlss.dll':
                        name_dlss = os.path.join(select_folder,'nvngx_dlss.dll')
                        name_old_dlss = os.path.join(select_folder,'nvngx_dlss.txt')
                        rename_dlss = 'nvngx_dlss.txt'
                        if os.path.exists(name_dlss) and not os.path.exists(name_old_dlss):
                            os.rename(name_dlss,os.path.join(select_folder,rename_dlss))
                        shutil.copy2(nvn_path, select_folder)
                
                elif os.path.isfile(nvn_path) and select_nvngx == 'DLSSD 3.8.1':
                    if item == 'nvngx_dlssg.dll':
                        name_dlssg = os.path.join(select_folder,'nvngx_dlssg.dll')
                        name_old_dlssg = os.path.join(select_folder,'nvngx_dlg.txt')
                        rename_dlssg = 'nvngx_dlg.txt'
                        if os.path.exists(name_dlssg) and not os.path.exists(name_old_dlssg):
                            os.rename(name_dlssg,os.path.join(select_folder,rename_dlssg))
                        shutil.copy2(nvn_path, select_folder)
            
            def copy_dlss(path_dlss_origin,name_old_dlss,path_dlss,rename_dlss):
                if os.path.exists(path_dlss_origin) and not os.path.exists(name_old_dlss):
                    os.rename(path_dlss_origin, os.path.join(select_folder, rename_dlss))
                
                shutil.copy2(path_dlss, select_folder)
                
            if select_nvngx == 'DLSS 4':
                path_dlss_371 = 'mods\\Temp\\nvngx_global\\nvngx\\Dlss\\nvngx_dlss.dll'
                name_dlss_371 = os.path.join(select_folder, 'nvngx_dlss.dll')
                name_old_dlss_371 = os.path.join(select_folder, 'nvngx_dlss.txt')
                rename_dlss_371 = 'nvngx_dlss.txt'
                
                copy_dlss(name_dlss_371,name_old_dlss_371,path_dlss_371,rename_dlss_371)
            
            elif select_nvngx == 'DLSSG 4':
                path_dlssg_371 = 'mods\\Temp\\nvngx_global\\nvngx\\Dlssg_3_7_1\\nvngx_dlssg.dll'
                name_dlssg_371 = os.path.join(select_folder, 'nvngx_dlssg.dll')
                name_old_dlssg_371 = os.path.join(select_folder, 'nvngx_dlssg.txt')
                rename_dlssg_371 = 'nvngx_dlssg.txt'
                
                copy_dlss(name_dlssg_371,name_old_dlssg_371,path_dlssg_371,rename_dlssg_371)
            
            elif select_nvngx == 'DLSSD 4':
                path_dlssd_371 = 'mods\\Temp\\nvngx_global\\nvngx\\Dlssd_3_7_1\\nvngx_dlssd.dll'
                name_dlssd_371 = os.path.join(select_folder, 'nvngx_dlssd.dll')
                name_old_dlssd_371 = os.path.join(select_folder, 'nvngx_dlssd.txt')
                rename_dlssd_371 = 'nvngx_dlssd.txt'
                
                copy_dlss(name_dlssd_371,name_old_dlssd_371,path_dlssd_371,rename_dlssd_371)
            
            if install_contr:
                nvngx_cbox.deselect()
                nvngx_contr = False
                nvngx_canvas.configure(bg='#C0C0C0')
                nvngx_listbox.place_forget()
                                                      
        except Exception as e:
            messagebox.showinfo("Error","Please select the destination folder and the mod version")

#Modify the upscaler resolution through the .toml file, with no default values like the Uniscaler Custom function, users can add values as they wish           
custom_fsr_act = False
def unlock_custom():
    list_custom = ['0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1']
    if select_mod not in list_custom:
        messagebox.showwarning('Error','Please select a mod version starting from 0.9.0')
        custom_fsr_cbox.deselect()
        return False
    else:
        return True

def cbox_custom_fsr():
    global custom_fsr_act
    if custom_fsr_var.get() == 0:
        custom_fsr_act = False
        fsr_balanced_canvas.configure(bg='#C0C0C0')
        fsr_ultraq_canvas.configure(bg='#C0C0C0')
        fsr_ultrap_canvas.configure(bg='#C0C0C0')
        fsr_performance_canvas.configure(bg='#C0C0C0')
        fsr_quality_canvas.configure(bg='#C0C0C0')
        native_res_canvas.configure(bg='#C0C0C0')
    elif unlock_custom():
        fsr_balanced_canvas.configure(bg='white')
        fsr_ultraq_canvas.configure(bg='white')
        fsr_ultrap_canvas.configure(bg='white')
        fsr_performance_canvas.configure(bg='white')
        fsr_quality_canvas.configure(bg='white')
        native_res_canvas.configure(bg='white')
        custom_fsr_act = True
    else:
        custom_fsr_act = False
        
custom_fsr_label = tk.Label(screen,text='Resolution Override  -  Custom FSR',font=font_select,bg='black',fg='#C0C0C0')
custom_fsr_label.place(x=420,y=153)
custom_fsr_var = IntVar()
custom_fsr_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=custom_fsr_var,command=cbox_custom_fsr)
custom_fsr_cbox.place(x=672,y=155)

fsr_ultraq_canvas = tk.Canvas(screen,bg='#C0C0C0',width=50,height=19,highlightthickness=0)
fsr_ultraq_canvas.place(x=565,y=188)
fsr_ultraq_label = tk.Label(screen,text='FSR Ultra Quality:',font=font_select,bg='black',fg='#C0C0C0')
fsr_ultraq_label.place(x=420,y=183)
fsr_ultraq_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_ultraq_label_up.place(x=543,y=183)
fsr_ultraq_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
fsr_ultraq_label_down.place(x=620,y=175)

fsr_quality_label = tk.Label(screen,text='FSR Quality:',font=font_select,bg='black',fg='#C0C0C0')
fsr_quality_label.place(x=420,y=213)
fsr_quality_canvas = tk.Canvas(screen,width=50,height=19,bg='#C0C0C0',highlightthickness=0)
fsr_quality_canvas.place(x=565,y=218)
fsr_quality_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_quality_label_up.place(x=543,y=213)
fsr_quality_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
fsr_quality_label_down.place(x=620,y=205)

fsr_balanced_label = tk.Label(screen,text='FSR Balanced:',font=font_select,bg='black',fg='#C0C0C0')
fsr_balanced_label.place(x=420,y=243)
fsr_balanced_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_balanced_label_up.place(x=543,y=243)
fsr_balanced_canvas = tk.Canvas(screen,bg='#C0C0C0',width=50,height=19,highlightthickness=0)
fsr_balanced_canvas.place(x=565,y=248)
fsr_balanced_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg="#B0C4DE")
fsr_balanced_label_down.place(x=620,y=235)

fsr_performance_label = tk.Label(screen,text='FSR Performance:',font=font_select,bg='black',fg='#C0C0C0')
fsr_performance_label.place(x=420,y=273)
fsr_performance_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_performance_label_up.place(x=543,y=273)
fsr_performance_canvas = tk.Canvas(screen,width=50,height=19,bg='#C0C0C0',highlightthickness=0)
fsr_performance_canvas.place(x=565,y=278)
fsr_performance_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
fsr_performance_label_down.place(x=620,y=265)

fsr_ultrap_label = tk.Label(screen,text='FSR Ultra Performance:',font=font_select,bg='black',fg='#C0C0C0')
fsr_ultrap_label.place(x=420,y=303)
fsr_ultrap_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_ultrap_label_up.place(x=583,y=303)
fsr_ultrap_canvas = tk.Canvas(screen,bg='#C0C0C0',width=50,height=19,highlightthickness=0)
fsr_ultrap_canvas.place(x=603,y=308)
fsr_ultrap_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
fsr_ultrap_label_down.place(x=656,y=295)

native_res_canvas = tk.Canvas(screen,bg='#C0C0C0',width=50,height=19,highlightthickness=0)
native_res_canvas.place(x=495,y=338)
native_res_label = tk.Label(screen,text='Native: ',font=font_select,bg='black',fg='#C0C0C0')
native_res_label.place(x=420,y=333)
native_res_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
native_res_label_up.place(x=475,y=333)
native_res_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
native_res_label_down.place(x=548,y=325)

def edit_fsr_custom(option_quality_fsr,fsr_ultraq_up_count_f):
    list_mod_custom_fsr = {
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
    }  
    mod_fsr_custom_folder = None
    if select_mod in list_mod_custom_fsr:
        mod_fsr_custom_folder = list_mod_custom_fsr[select_mod]
        key_fsr_custom = 'resolution_override'
    
    if mod_fsr_custom_folder is not None:
        with open(mod_fsr_custom_folder, 'r') as file:
            toml_custom = toml.load(file)
        toml_custom.setdefault(key_fsr_custom,{})
        toml_custom[key_fsr_custom][option_quality_fsr] = float(fsr_ultraq_up_count_f)/ 100.0
        with open(mod_fsr_custom_folder,'w') as file:
            toml.dump(toml_custom,file)

fsr_ultraq_up_count = 25
fsr_ultraq_up_count_f = 25
def fsr_ultraq_up_custom(event=None):
    global custom_fsr_act,fsr_ultraq_up_count,fsr_ultraq_up_count_f
    option_quality_fsr = 'ultra_quality'
    fsr_ultraq_up_count_f = f'{fsr_ultraq_up_count:.0f}'
    if custom_fsr_act and fsr_ultraq_up_count < 100:
        fsr_ultraq_up_count += 1
        fsr_ultraq_up_count_f = f'{fsr_ultraq_up_count:.0f}'
        
        fsr_ultraq_canvas.delete('text')
        fsr_ultraq_canvas.create_text(2,8,anchor='w',fill='black',text=fsr_ultraq_up_count_f,tags='text')
        fsr_ultrap_canvas.update()
        fsr_ultraq_label_up.configure(fg='black')
    edit_fsr_custom(option_quality_fsr,fsr_ultraq_up_count_f)
    
def color_fsr_ultraq_up(event=None):
    fsr_ultraq_label_up.configure(fg='#B0C4DE')
        
def fsr_ultraq_down_custom(event=None):
    global fsr_ultraq_up_count,fsr_ultraq_up_count_f
    option_quality_fsr = 'ultra_quality'
    if custom_fsr_act and fsr_ultraq_up_count > 25:
        fsr_ultraq_up_count -= 1
        fsr_ultraq_up_count_f = f'{fsr_ultraq_up_count:.0f}'
        fsr_ultraq_canvas.delete('text')
        fsr_ultraq_canvas.create_text(2,8,anchor='w',fill='black',text=fsr_ultraq_up_count_f,tags='text')
        fsr_ultraq_label_down.configure(fg='black')
    edit_fsr_custom(option_quality_fsr,fsr_ultraq_up_count_f)
    fsr_ultraq_canvas.update()
def color_fsr_ultraq_down(event=None):
    fsr_ultraq_label_down.configure(fg='#B0C4DE')

fsr_quality_up_count = 25 
fsr_quality_up_count_f = 25
def fsr_quality_up_custom(event=None):
    global fsr_quality_up_count,fsr_quality_up_count_f
    option_quality = 'quality'
    fsr_quality_up_count_f = f'{fsr_quality_up_count:.0f}'
    if custom_fsr_act and fsr_quality_up_count <= 100:
        fsr_quality_up_count += 1
        fsr_quality_canvas.delete('text')
        fsr_quality_canvas.create_text(2,8,anchor='w',text=fsr_quality_up_count_f,fill='black',tags='text')       
        fsr_quality_label_up.configure(fg='black')
        fsr_quality_canvas.update()
    edit_fsr_custom(option_quality,fsr_quality_up_count_f)

def color_fsr_quality_up(event=None):
    fsr_quality_label_up.configure(fg='#B0C4DE')

def fsr_quality_down_custom(event=None):
    global fsr_quality_up_count,fsr_quality_up_count_f
    option_quality_fsr = 'quality'
    if custom_fsr_act and fsr_quality_up_count > 25:
        fsr_quality_up_count -= 1
        fsr_quality_up_count_f = f'{fsr_quality_up_count:.0f}'
        fsr_quality_canvas.delete('text')
        fsr_quality_canvas.create_text(2,8,anchor='w',text=fsr_quality_up_count_f,fill='black',tags='text')
        fsr_quality_label_down.configure(fg='black')
    edit_fsr_custom(option_quality_fsr,fsr_quality_up_count_f)

def color_fsr_quality_down(event=None):
    fsr_quality_label_down.configure(fg='#B0C4DE')

fsr_balanced_up_count = 25
fsr_balanced_up_count_f = 25
def fsr_balanced_up_custom(event=None):
    global fsr_balanced_up_count,fsr_balanced_up_count_f
    option_quality_fsr = 'balanced'
    fsr_balanced_up_count_f = f'{fsr_balanced_up_count:.0f}'
    if custom_fsr_act and fsr_balanced_up_count <= 100:
        fsr_balanced_up_count += 1
        fsr_balanced_canvas.delete('text')
        fsr_balanced_canvas.create_text(2,8,anchor='w',text=fsr_balanced_up_count_f,tags='text')
        fsr_balanced_label_up.configure(fg='black')
    edit_fsr_custom(option_quality_fsr,fsr_balanced_up_count_f)

def color_fsr_balanced_up(event=None):
    fsr_balanced_label_up.configure(fg='#B0C4DE')

def fsr_balanced_down_custom(event=None):
    global fsr_balanced_up_count,fsr_balanced_up_count_f
    option_quality_fsr = 'balanced'
    if custom_fsr_act and fsr_balanced_up_count > 25:
        fsr_balanced_up_count -= 1
        fsr_balanced_up_count_f = f'{fsr_balanced_up_count:.0f}'
        fsr_balanced_canvas.delete('text')
        fsr_balanced_canvas.create_text(2,8,anchor='w',text=fsr_balanced_up_count_f,fill='black',tags='text')
        fsr_balanced_label_down.configure(fg='black')
    edit_fsr_custom(option_quality_fsr,fsr_balanced_up_count_f)

def color_fsr_balanced_down(event=None):
    fsr_balanced_label_down.configure(fg='#B0C4DE')

fsr_perf_up_count = 25
fsr_perf_up_count_f = 25
def fsr_perf_up_custom(event=None):
    global fsr_perf_up_count,fsr_perf_up_count_f
    option_quality_fsr = 'performance'
    fsr_perf_up_count_f = f'{fsr_perf_up_count:.0f}'
    if custom_fsr_act and fsr_perf_up_count <= 100:
        fsr_perf_up_count += 1
        fsr_performance_canvas.delete('text')
        fsr_performance_canvas.create_text(2,8,anchor='w',text=fsr_perf_up_count_f,tags='text')
        fsr_performance_label_up.configure(fg='black')
    edit_fsr_custom(option_quality_fsr,fsr_perf_up_count_f)

def color_fsr_perf_up(event=None):
    fsr_performance_label_up.configure(fg='#B0C4DE')

def fsr_perf_down_custom(event=None):
    global fsr_perf_up_count,fsr_perf_up_count_f
    option_quality_fsr = 'performance'
    if custom_fsr_act and fsr_perf_up_count > 25:
        fsr_perf_up_count -= 1
        fsr_perf_up_count_f = f'{fsr_perf_up_count:.0f}'
        fsr_performance_canvas.delete('text')
        fsr_performance_canvas.create_text(2,8,anchor='w',text=fsr_perf_up_count_f,tags='text')
        fsr_performance_label_down.configure(fg='black')
    edit_fsr_custom(option_quality_fsr,fsr_perf_up_count_f)

def color_fsr_perf_down(event=None):
    fsr_performance_label_down.configure(fg='#B0C4DE')

fsr_ultrap_count_up = 25
fsr_ultrap_count_up_f = 25
def fsr_ultrap_up_custom(event=None):
    global fsr_ultrap_count_up,fsr_ultrap_count_up_f
    
    option_quality_fsr = 'ultra_performance'
    fsr_ultrap_count_up_f = f'{fsr_ultrap_count_up:.0f}'
    
    if custom_fsr_act and fsr_ultrap_count_up <= 100:
        fsr_ultrap_count_up += 1
        fsr_ultrap_canvas.delete('text')
        fsr_ultrap_canvas.create_text(2,8,anchor='w',text=fsr_ultrap_count_up_f,fill='black',tags='text')
        fsr_ultrap_label_up.configure(fg='black')
    
    edit_fsr_custom(option_quality_fsr,fsr_ultrap_count_up_f)

def color_fsr_ultrap_up(event=None):
    fsr_ultrap_label_up.configure(fg='#B0C4DE')

def fsr_ultrap_down_custom(event=None):
    global fsr_ultrap_count_up,fsr_ultrap_count_up_f
    
    option_quality_fsr = 'ultra_performance'
    
    if custom_fsr_act and fsr_ultrap_count_up > 25:
        fsr_ultrap_count_up -= 1
        fsr_ultrap_count_up_f = f'{fsr_ultrap_count_up:.0f}'
        fsr_ultrap_canvas.delete('text')
        fsr_ultrap_canvas.create_text(2,8,anchor='w',text=fsr_ultrap_count_up_f,fill='black',tags='text')
        fsr_ultrap_label_down.configure(fg='black')
        
    edit_fsr_custom(option_quality_fsr,fsr_ultrap_count_up_f)

def color_fsr_ultrap_down(event=None):
    fsr_ultrap_label_down.configure(fg='#B0C4DE')

native_count = 25
native_count_f = 25   
def native_res_up_custom(event=None):
    global native_count_f,native_count
    
    option_quality_fsr = 'native'
    native_count_f = f'{native_count:.0f}'
    
    if custom_fsr_act and native_count < 100:
        native_count += 1
        native_res_canvas.delete('text')
        native_res_canvas.create_text(2,8,anchor='w',text=native_count_f,fill='black',tags='text')
        native_res_label_up.configure(fg='black')
        
    edit_fsr_custom(option_quality_fsr,native_count_f)

def color_native_up(event=None):
    native_res_label_up.configure(fg='#B0C4DE')

def native_res_down_custom(event=None):
    global native_count,native_count_f
    
    option_quality_fsr = 'native'
    
    if custom_fsr_act and native_count > 25:
        native_count -= 1
        native_count_f = f'{native_count:.0f}'
        native_res_canvas.delete('text')
        native_res_canvas.create_text(2,8,anchor='w',text=native_count_f,fill='black',tags='text')
        native_res_label_down.configure(fg='black')
        
    edit_fsr_custom(option_quality_fsr,native_count_f)

def color_native_down(event=None):
    native_res_label_down.configure(fg='#B0C4DE')

#Modifies the mod's operation through the .toml file, changing the GPU to RTX 4xxx to unlock Nvidia features
folder_fake_gpu ={
    '0.7.4':'mods\\Temp\\FSR2FSR3_0.7.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.7.5':'mods\\Temp\\FSR2FSR3_0.7.5_hotfix\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.7.6':'mods\\Temp\\FSR2FSR3_0.7.6\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.8.0':'mods\\Temp\\FSR2FSR3_0.8.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'The Callisto Protocol FSR3':'mods\\FSR3_Callisto\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Dlss Jedi':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml',
    'FSR 3.1 Custom Wukong':'mods\\Temp\\Wukong_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
}

def fake_gpu_mod():
    global folder_fake_gpu
    
    key_1 = 'compatibility'
    sob_line = 'fake_nvidia_gpu = true'
    
    if select_mod in folder_fake_gpu:
       folder_gpu = folder_fake_gpu[select_mod]  
       
    edit_fake_gpu_list = ['0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1','Dlss Jedi','FSR 3.1 Custom Wukong']
    
    if select_mod in edit_fake_gpu_list:
        with open(folder_gpu, 'r') as file:
            toml_gpu = toml.load(file)
            
        toml_gpu.setdefault(key_1,{})
        toml_gpu[key_1]['fake_nvidia_gpu'] = True
        
        with open(folder_gpu,'w') as file:
            toml.dump(toml_gpu,file)
    
    edit_old_fake_gpu = ['0.7.4','0.7.5','0.7.6','0.8.0']
    if select_mod in edit_old_fake_gpu:
        with open(folder_gpu,'w') as file:
            file.write(sob_line)
            
    edit_old_fake_gpu_2 = ['0.9.0','0.10.0','0.10.1','0.10.1h1']
    
    if select_mod in edit_old_fake_gpu_2:
        with open(folder_gpu, 'r') as file:
            lines_toml = file.readlines()
            
        lines_toml[0] = sob_line+'\n'  
        
        with open(folder_gpu,'w') as file:
            file.writelines(lines_toml)

def default_fake_gpu():
    global folder_fake_gpu
    
    key_1 = 'compatibility'
    sob_line = 'fake_nvidia_gpu = false'
    
    if select_mod in folder_fake_gpu:
        folder_gpu = folder_fake_gpu[select_mod]
        
    edit_fakegpu_list = ['0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1','Dlss Jedi','FSR 3.1 Custom Wukong']
    
    if select_mod in edit_fakegpu_list:
        with open(folder_gpu,'r') as file:
            toml_gpu = toml.load(file)
            
        toml_gpu.setdefault(key_1,{})
        toml_gpu[key_1]['fake_nvidia_gpu'] = False
        
        with open(folder_gpu,'w') as file:
            toml.dump(toml_gpu,file)
    
    edit_old_fake_gpu = ['0.7.4','0.7.5','0.7.6','0.8.0']
    if select_mod in edit_old_fake_gpu:
        with open(folder_gpu,'w') as file:
            file.write(sob_line)
    
    edit_old_fake_gpu_2 = ['0.9.0','0.10.0','0.10.1','0.10.1h1']
    
    if select_mod in edit_old_fake_gpu_2:
        with open(folder_gpu,'r') as file:
            lines_toml = file.readlines()
            
        lines_toml[0] = sob_line+'\n'
        
        with open(folder_gpu,'w') as file:
            file.writelines(lines_toml)
            
def copy_fake_gpu():
    global folder_fake_gpu
    file_gpu = None
    
    if select_mod in folder_fake_gpu:
        file_gpu = folder_fake_gpu[select_mod]
        
    try:
        if file_gpu is not None:
            if os.path.isfile(file_gpu):
                    shutil.copy2(file_gpu,select_folder)           
    except Exception as e:
        pass

def cbox_fakegpu():
    if select_mod in default_path:
        if fakegpu_cbox_var.get() == 1:
            fake_gpu_mod()
            fakegpu_cbox_var.set == 0
        else:
            fakegpu_cbox_var.set == 1
            default_fake_gpu()
    else:
        messagebox.showinfo('0.7.4','Please select a version starting from 0.7.4')
        fakegpu_cbox.deselect()

fakegpu_label = tk.Label(screen,text='Fake NVIDIA GPU',font=font_select,bg='black',fg='#C0C0C0')
fakegpu_label.place(x=0,y=146)
fakegpu_cbox_var = tk.IntVar()
fakegpu_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=fakegpu_cbox_var,command=cbox_fakegpu)
fakegpu_cbox.place(x=133,y=148)

#Workaround graphical artifacts in Unreal Engine games when selecting DLSS
list_ue = {
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'Dlss Jedi':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml'
    }

def edit_ue():
    global list_ue
    
    ue_folder = None
    key_1 = 'compatibility'
    
    if select_mod in list_ue:
        ue_folder = list_ue[select_mod]
    else:
        messagebox.showwarning('Error','Please select a mod version starting from 0.9.0')
        ue_cbox.deselect()
    
    if ue_folder is not None:
        with open(ue_folder,'r') as file:
            toml_ue = toml.load(file)
        toml_ue.setdefault(key_1,{})
        toml_ue[key_1]['amd_unreal_engine_dlss_workaround'] = True
        with open(ue_folder,'w') as file:
            toml.dump(toml_ue,file)
      
def default_ue():
    global list_ue
    key_1 = 'compatibility'
    
    if select_mod in list_ue:
        ue_folder = list_ue[select_mod]
    
    with open(ue_folder, 'r') as file:
        toml_ue = toml.load(file)
    toml_ue.setdefault(key_1,{})
    toml_ue[key_1]['amd_unreal_engine_dlss_workaround'] = False
    with open(ue_folder,'w') as file:
        toml.dump(toml_ue,file)
      
def cbox_ue():
    if ue_cbox_var.get() == 1:
        edit_ue()
    else:
        default_ue()
        
ue_label = tk.Label(screen,text='UE Compatibility Mode',bg='black',font=font_select,fg='#C0C0C0')
ue_label.place(x=200,y=146)
ue_cbox_var = tk.IntVar()
ue_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=ue_cbox_var,command=cbox_ue)
ue_cbox.place(x=367,y=149)

#Fixes issues with DLSS/FG not available on GTX GPUs
list_nvapi = {
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'Dlss Jedi':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml'
    }
def edit_nvapi():
    global list_nvapi
    
    key_nv = 'compatibility'
    nvapi_folder = None
    
    if select_mod in list_nvapi:
        nvapi_folder = list_nvapi[select_mod]
    else:
        messagebox.showwarning('Error','Please select a mod version starting from 0.10.2h1.')
        nvapi_cbox.deselect()
    
    if nvapi_folder is not None:
        with open(nvapi_folder,'r') as file:
            toml_nv = toml.load(file)
            
        toml_nv.setdefault(key_nv,{})
        toml_nv[key_nv]['fake_nvapi_results'] = True
        
        with open(nvapi_folder,'w') as file:
            toml.dump(toml_nv,file)

def default_nvapi():
    global list_nvapi
    
    key_nv = 'compatibility'
    
    if select_mod in list_nvapi:
        folder_nvapi = list_nvapi[select_mod]
    
    with open(folder_nvapi,'r') as file:
        toml_nv = toml.load(file)
        
    toml_nv.setdefault(key_nv,{})
    toml_nv[key_nv]['fake_nvapi_results'] = False
    
    with open(folder_nvapi,'w') as file:
        toml.dump(toml_nv,file)
      
def cbox_nvapi():
    if nvapi_cbox_var.get() == 1:
        edit_nvapi()
        nvapi_cbox_var.set == 0
        
    else:
        default_nvapi()
        print('nvapi False')
        nvapi_cbox_var.set == 1

nvapi_label = tk.Label(screen,text='NVAPI Results',font=font_select,bg='black',fg='#C0C0C0')
nvapi_label.place(x=0,y=176)
nvapi_cbox_var = tk.IntVar()
nvapi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=nvapi_cbox_var,command=cbox_nvapi)
nvapi_cbox.place(x=118,y=179)

#Enable macOS-specific compatibility tweak
list_macos = {
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
    }
def edit_macos():
    global list_macos
    folder_macos = None
    key_os = 'compatibility'
    
    if select_mod in list_macos:
        folder_macos = list_macos[select_mod]
    else:
        messagebox.showwarning('Error','Please select a mod version starting from 0.9.0')
        macos_sup_cbox.deselect()
     
    if folder_macos is not None:   
        with open(folder_macos) as file:
            toml_mc = toml.load(file)
        toml_mc.setdefault(key_os,{})
        toml_mc[key_os]['macos_crossover_support'] = True
        with open(folder_macos,'w') as file:
            toml.dump(toml_mc,file)  

def default_macos():
    global list_macos
    folder_macos = None
    
    key_1 = 'compatibility'
    
    if select_mod in list_macos:
        folder_macos = list_macos[select_mod]
      
    if folder_macos is not None:  
        with open(folder_macos, 'r') as file:
            toml_os = toml.load(file)
        toml_os.setdefault(key_1,{})
        toml_os[key_1]['macos_crossover_support'] = False
        with open(folder_macos,'w') as file:
            toml.dump(toml_os,file)
        
def cbox_macos():
    if macos_sup_var.get() == 1:
        macos_sup_var.set == 0
        edit_macos()
    else:
        macos_sup_var.set == 1
        default_macos()

macos_sup_label = tk.Label(screen,text='MacOS Crossover Support',font=font_select,bg='black',fg='#C0C0C0')
macos_sup_label.place(x=200,y=176)
macos_sup_var = tk.IntVar()
macos_sup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=macos_sup_var,command=cbox_macos)
macos_sup_cbox.place(x=387,y=179)

#Deletes the .toml file modified by the user and replaces it with a new one
default_path ={
    '0.7.4':'mods\\Temp\\FSR2FSR3_0.7.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.7.5':'mods\\Temp\\FSR2FSR3_0.7.5_hotfix\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.7.6':'mods\\Temp\\FSR2FSR3_0.7.6\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.8.0':'mods\\Temp\\FSR2FSR3_0.8.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'The Callisto Protocol FSR3':'mods\\Temp\\FSR3_Callisto\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'Dlss Jedi':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml',
    'FSR 3.1 Custom Wukong':'mods\\Temp\\Wukong_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
}

replace_flag = False 
def rep_flag():
    global replace_flag
    replace_flag = True

def replace_clean_file():
    clean_file_copy = ""
    if replace_flag:
        clean_file = {
            '0.7.4':'mods\\FSR2FSR3_0.7.4\\enable_fake_gpu',
            '0.7.5':'mods\\FSR2FSR3_0.7.5_hotfix\\enable_fake_gpu',
            '0.7.6':'mods\\FSR2FSR3_0.7.6\\enable_fake_gpu',
            '0.8.0':'mods\\FSR2FSR3_0.8.0\\enable_fake_gpu',
            '0.9.0':'mods\\FSR2FSR3_0.9.0\\enable_fake_gpu',
            '0.10.0':'mods\\FSR2FSR3_0.10.0\\enable_fake_gpu',
            '0.10.1':'mods\\FSR2FSR3_0.10.1\\enable_fake_gpu',
            '0.10.1h1':'mods\\FSR2FSR3_0.10.1h1\\enable_fake_gpu',
            '0.10.2h1':'mods\\FSR2FSR3_0.10.2h1\\enable_fake_gpu',
            '0.10.3':'mods\\FSR2FSR3_0.10.3\\enable_fake_gpu',
            '0.10.4':'mods\\FSR2FSR3_0.10.4\\enable_fake_gpu',
            'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\enable_fake_gpu',
            'Uniscaler + Xess + Dlss':r'mods\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu',
            'The Callisto Protocol FSR3':'mods\\FSR3_Callisto\\enable_fake_gpu',
            'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\enable_fake_gpu',
            'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\enable_fake_gpu',
            'Uniscaler V4':'mods\\FSR2FSR3_Uniscaler_V4\\enable_fake_gpu',
            'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\enable_fake_gpu',
            'Dlss Jedi':'mods\\FSR2FSR3_Miles\\uni_miles_toml',
            'FSR 3.1 Custom Wukong':'mods\\FSR3_WUKONG\\WukongFSR31\\enable_fake_gpu'
        }
        
        clean_file_rep = {
            '0.7.4':'mods\\Temp\\FSR2FSR3_0.7.4\\enable_fake_gpu',
            '0.7.5':'mods\\Temp\\FSR2FSR3_0.7.5_hotfix\\enable_fake_gpu',
            '0.7.6':'mods\\Temp\\FSR2FSR3_0.7.6\\enable_fake_gpu',
            '0.8.0':'mods\\Temp\\FSR2FSR3_0.8.0\\enable_fake_gpu',
            '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu',
            '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu',
            '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu',
            '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu',
            '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu',
            '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu',
            '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu',
            'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu',
            'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu',
            'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu',
            'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu',
            'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu',
            'The Callisto Protocol FSR3':'mods\\Temp\\FSR3_Callisto\\enable_fake_gpu',
            'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu',
            'Dlss Jedi':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu',
            'FSR 3.1 Custom Wukong':'mods\\Temp\\Wukong_FSR31\\enable_fake_gpu'
        }
        
        if select_mod in clean_file and select_mod in clean_file_rep:
            clean_file_copy = clean_file[select_mod]
            rep_clean_file = clean_file_rep[select_mod]

        if os.path.isdir(clean_file_copy) and os.path.isdir(rep_clean_file):
            for file_clean in os.listdir(clean_file_copy):
                c_file = os.path.join(clean_file_copy,file_clean)
                if os.path.isfile(c_file):
                    shutil.copy2(c_file,rep_clean_file)

#Saves the changes made by the user in the TOML Editor
def save_file():
    global file_w
    if file_w:
        try:
            low_text = text_editor.get('1.0','end').lower()
            with open(file_w, 'w') as file:
                file.write(low_text)
            messagebox.showinfo('File Saved','File save sucess')
        except Exception as e:
            messagebox.showerror('Error',f'File not saved: {str(e)}')

screen_toml = None
def open_file():
    global file_w
    replace_clean_file()
    file_w = default_file_path
    if file_w and open_editor_var.get() == 1:
        with open(file_w, 'r') as file:
            content = file.read()
            text_editor.delete('1.0', 'end')
            text_editor.insert('1.0', content)

def cbox_editor():
    global replace_flag,screen_toml,default_path
    if open_editor_var.get() == 1 and select_mod in default_path:
        screen_editor()
        
    elif open_editor_var.get() == 0:
        screen_toml.destroy()
        replace_flag = False
        
    elif open_editor_var.get() == 1 and select_mod == None:
        messagebox.showinfo('Select Mod','Please select the mod version to open TOML EDITOR')
        open_editor_cbox.deselect()

    elif open_editor_var.get() == 1 and select_mod not in default_path:
        messagebox.showinfo('Select Mod','Please select a mod from version 0.7.4 onwards. Specific mods (for example: Alan Wake Uniscaler Custom) do not require changes to the TOML file')
        open_editor_cbox.deselect()

#TOML Editor creation
def screen_editor():
    global text_editor,default_file_path,default_path,b_reload,screen_toml
    
    def exit_screen():
        global replace_flag
        screen_toml.destroy()
        open_editor_cbox.deselect()
        replace_flag = False
    
    screen_toml = tk.Tk()
    screen_toml.protocol("WM_DELETE_WINDOW",exit_screen)
    screen_toml.title("Editor TOML")
    screen_toml.geometry("600x400")

    if select_mod in default_path:
        default_file_path = os.path.join(default_path[select_mod])
    
    text_editor = tk.Text(screen_toml)
    text_editor.pack(expand=True, fill='both')

    open_file()
    
    menubar = tk.Menu(screen_toml)
    b_reload = tk.Button(screen_toml,text='Reload',command=open_file)
    b_reload.place(x=553,y=374)
    b_reload.bind('<Button-1>',lambda event:rep_flag())
    filemenu = tk.Menu(menubar, tearoff=0)
    filemenu.add_command(label="Save", command=save_file)
    filemenu.add_separator()
    filemenu.add_command(label="Exit", command=exit_screen)
    menubar.add_cascade(label="File", menu=filemenu)
    screen_toml.config(menu=menubar)
    screen_toml.resizable(False,False)
    
    screen_toml.mainloop()

open_editor_label = tk.Label(screen,text='Open TOML Editor',font=font_select,bg='black',fg='#C0C0C0')
open_editor_label.place(x=200,y=236)
open_editor_var = tk.IntVar()
open_editor_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=open_editor_var,command=cbox_editor)
open_editor_cbox.place(x=335,y=239)

#Modify the sharpening via the .toml file, from 0.0 to 1.0, where 1.0 is the maximum and -1.0 disables it
unlock_sharp_up_down = False
unlock_cbox_sharp = None
def cbox_sharpness():
    global unlock_sharp_up_down,unlock_cbox_sharp
    if sharpness_var.get() == 1 and unlock_cbox_sharp == True:
        unlock_sharp_up_down = True
        sharpness_value_canvas.configure(bg='white')
    else:
        unlock_sharp_up_down = False
        sharpness_value_canvas.configure(bg='#C0C0C0')
        if unlock_cbox_sharp == False:
            messagebox.showinfo('Select Mod','Please select a version starting from 0.9.0')
            sharpness_cbox.deselect()

def unlock_sharp():
    global unlock_cbox_sharp,select_mod
    mod_list_sharp = ['0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1']
    if select_mod in mod_list_sharp:
        unlock_cbox_sharp = True
    else:
        unlock_cbox_sharp = False
        
def edit_sharpeness_up():
    global unlock_cbox_sharp
    list_mod_sharpness={
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
    }  
    if select_mod in list_mod_sharpness:
        folder_sharp = list_mod_sharpness[select_mod]
        key_sharp = 'general'
        
        if folder_sharp:
            with open(folder_sharp, 'r') as file:
                toml_s = toml.load(file)
            toml_s[key_sharp]['sharpness_override'] = float(cont_value_up_f)
            with open(folder_sharp,'w') as file:
                toml.dump(toml_s,file)  
    else:
        unlock_cbox_sharp = False    
    
sharpness_label = tk.Label(screen,text='Sharpness Override',font=font_select,bg='black',fg='#C0C0C0')
sharpness_label.place(x=420,y=96)
sharpness_var = tk.IntVar()
sharpness_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=sharpness_var,command=cbox_sharpness)
sharpness_cbox.place(x=560,y=98)
sharpness_value_label = tk.Label(screen,text='Sharpness Value:',font=font_select,bg='black',fg='#C0C0C0')
sharpness_value_label.place(x=420,y=125)
sharpness_value_canvas = tk.Canvas(screen,width=80,height=19,bg='#C0C0C0',highlightthickness=0)
sharpness_value_canvas.place(x=565,y=130)
sharpness_value_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
sharpness_value_label_up.place(x=545,y=124)
sharpness_value_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
sharpness_value_label_down.place(x=648,y=117)

cont_value_up = 0
cont_value_up_f = '0.0'
def cont_sharpness_value_up(event=None):
    global cont_value_up,cont_value_up_f,unlock_sharp_up_down
    if unlock_sharp_up_down:
        if cont_value_up == -10: 
            cont_value_up = 0.0
            cont_value_up_f = '0.0'
        elif cont_value_up < 10:
            cont_value_up +=1
            
        cont_value_up_f = f'{cont_value_up/10:.1f}'
        sharpness_value_canvas.delete('text')
        sharpness_value_canvas.create_text(2,8,anchor='w',text=cont_value_up_f,fill='black',tags='text')
        sharpness_value_label_up.configure(fg='black')
        sharpness_value_canvas.update()
    edit_sharpeness_up()

def color_sharpness_value_up(event=None):
    sharpness_value_label_up.configure(fg='#B0C4DE')

def cont_sharpness_value_down(event=None):
    global cont_value_up_f,cont_value_up,unlock_sharp_up_down
    if unlock_sharp_up_down:
        if cont_value_up > 0:
            cont_value_up-=1
            cont_value_up_f = f'{cont_value_up/10:.1f}'
        elif cont_value_up == 0:
            cont_value_up = -10
            cont_value_up_f = '-1.0'

        sharpness_value_canvas.delete('text')
        sharpness_value_canvas.create_text(2,8,anchor='w',text=cont_value_up_f,fill='black',tags='text')
        sharpness_value_canvas.update()
        sharpness_value_label_down.configure(fg='black')
    
    edit_sharpeness_up()

def color_sharpness_value_down(event=None):
    sharpness_value_label_down.configure(fg='#B0C4DE')


#Define which frame gen will be used, FSR 3.1 or FSR3
fg_mode_label = tk.Label(screen,text='Frame Gen Method',font=font_select,bg='black',fg='#C0C0C0')
fg_mode_label.place(x=420,y=68)
fg_mode_canvas = tk.Canvas(screen,width=116,height=19,bg='#C0C0C0',highlightthickness=0)
fg_mode_canvas.place(x=565,y=72)
fg_mode_listbox = tk.Listbox(screen,bg='white',width=19,height=0,highlightthickness=0)

fg_mode_list = ['Uniscaler FSR 3.1','Uniscaler V4']
fg_mode_visible = False
unlock_listbox_fg_mode = False
select_fg_mode = None

def unlock_fg_mode():
    global unlock_listbox_fg_mode
    if select_mod == 'Uniscaler FSR 3.1' or select_mod == 'Uniscaler V4':
        unlock_listbox_fg_mode = True
        fg_mode_canvas.config(bg='white')
    else:
        fg_mode_listbox.place_forget()
        fg_mode_canvas.delete('text')
        fg_mode_canvas.config(bg='#C0C0C0')
        unlock_listbox_fg_mode  = False

def fg_mode_view(event):
    global fg_mode_visible,unlock_listbox_fg_mode
    if unlock_listbox_fg_mode == True:
        if fg_mode_visible:
            fg_mode_listbox.place_forget()
            fg_mode_visible = False
        else:
            fg_mode_listbox.place(x=565,y=95)
            fg_mode_visible = True

def edit_fg_mode():
    global select_fg_mode
    path_fg_mode = {'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
                    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml'}
    
    key_fg_mode = 'general'

    if select_mod in path_fg_mode:
        ini_fg_mode = path_fg_mode[select_mod]

        with open (ini_fg_mode,'r') as file:
            toml_fg = toml.load(file)

        toml_fg.setdefault(key_fg_mode,{})
        toml_fg[key_fg_mode]['frame_generator'] = str(select_fg_mode).replace('.','_').lower()
        
        with open(ini_fg_mode,'w') as file:
            toml.dump(toml_fg,file)

'''
Modify the mod's operation through the .toml file

0.9.0 onwards

Default: How the mod used to operate. DLSS/FSR inputs used for FSR3 Upscaling and FSR3 Frame Generation.
Enable Upscaling Only:  Same as default mode, but enables only FSR3 upscaling, FSR3 FG is disabled
Replace DLSS - FG: For mixing other upscalers like DLSS or XeSS with FSR3 Frame Generation in games that have NATIVE DLSS3 Frame Generation, no HUD ghosting
Use Game Upscaling: same as replace_dlss_fg, but for games WITHOUT Native DLSS3FG, there will be HUD ghosting

Uniscaler

Replaces the mod's operation to enable FG to work with the options below

XESS: Replaces the upscaler to work with XESS
DLSS: Replaces the upscaler to work with DLSS
FSR3: Replaces the upscaler to work with FSR3
'''   
mod_operates_label = tk.Label(screen,text='Mod Operates:',font=font_select,bg='black',fg='#C0C0C0')
mod_operates_label.place(x=420,y=33)
mod_operates_canvas = tk.Canvas(screen,width=150,height=19,bg='#C0C0C0',highlightthickness=0)
mod_operates_canvas.place(x=532,y=38)
mod_operates_listbox = tk.Listbox(screen,bg='white',width=25,height=0,highlightthickness=0)
mod_operates_listbox.place(x=532,y=60)
mod_operates_listbox.place_forget()

optional_mod_op_label = tk.Label(screen,text='optional',font=(font_select,7),bg='black',fg='#696969')
optional_mod_op_label.place(x=430,y=55)

options_mod_op = None
select_mod_op_options = None
def edit_mod_operates():
    global select_mod_op_options,options_mod_op
    mod_operates_folder = None
    mod_folder_list = {
    '0.9.0':'mods\\Temp\\FSR2FSR3_0.9.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\\Temp\\FSR2FSR3_0.10.0\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\\Temp\\FSR2FSR3_0.10.1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\\Temp\\FSR2FSR3_0.10.1h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\\Temp\\FSR2FSR3_0.10.2h1\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\\Temp\\FSR2FSR3_0.10.3\\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\\Temp\\FSR2FSR3_0.10.4\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V4':'mods\\Temp\\Uniscaler_V4\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'Dlss Jedi':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml'
    }

    list_ignore_uniscaler_custom = ['Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1','Dlss Jedi']
    
    if select_mod in mod_folder_list:
        mod_operates_folder = mod_folder_list[select_mod]
        key_mod_operates = 'general'
        
    if select_mod == '0.9.0' and select_mod_operates == 'Enable Upscaling Only':
        options_mod_op = 'enable_upscaling_only'
        select_mod_op_options = True
    elif select_mod == '0.9.0' and select_mod_operates == 'Default':
        options_mod_op = 'enable_upscaling_only'
        select_mod_op_options = False
    elif select_mod != '0.9.0' and select_mod not in list_ignore_uniscaler_custom:
        options_mod_op = 'mode'
        select_mod_op_options = str(select_mod_operates).lower().replace(" ", '_')
    elif select_mod in list_ignore_uniscaler_custom:
        options_mod_op = 'upscaler'
        select_mod_op_options = str(select_mod_operates).lower()
             
    if mod_operates_folder is not None: 
              
        with open(mod_operates_folder,'r') as file:
            toml_op = toml.load(file)
            
        toml_op.setdefault(key_mod_operates,{})
        toml_op[key_mod_operates][options_mod_op] = select_mod_op_options
        
        with open(mod_operates_folder,'w') as file:
            toml.dump(toml_op,file)
        
mod_op_list_visible = False
def mod_operates_view(event):
    global mod_op_list_visible,unlock_listbox_mod_op
    if unlock_listbox_mod_op == True:
        if mod_op_list_visible:
            mod_operates_listbox.place_forget()
            mod_op_list_visible = False
        else:
            mod_operates_listbox.place(x=532,y=60)
            mod_op_list_visible = True

select_folder_canvas = Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
select_folder_canvas.place(x=350,y=75)
select_folder_canvas.create_text(0,8,anchor='w',font=('Arial',9,'bold'),text='Browser',fill='black')
select_folder_label = tk.Label(screen,text='–',font=font_select,bg='black',fg='#C0C0C0')
select_folder_label.place(x=318,y=70)
select_folder = None

#Function to select the game folder and create the selected path text on the Canvas
def open_explorer(event=None): 
    global select_folder
    select_folder = filedialog.askdirectory()
    game_folder_canvas.delete('text')
    game_folder_canvas.create_text(2,8, anchor='w',text=select_folder,fill='black',tags='text') 
               
asi_global={
    '0.7.4':{
        '2.0':'mods\\ASI\\ASI_0_7_4\\2.0',
        '2.1':'mods\\ASI\\ASI_0_7_4\\2.1',
        '2.2':'mods\\ASI\\ASI_0_7_4\\2.2',
        'SDK':'mods\\ASI\\ASI_0_7_4\\SDK',
    },
    '0.7.5':{
        '2.0':'mods\\ASI\\ASI_0_7_5\\2.0',
        '2.1':'mods\\ASI\\ASI_0_7_5\\2.1',
        '2.2':'mods\\ASI\\ASI_0_7_5\\2.2',
        'SDK':'mods\\ASI\\ASI_0_7_5\\SDK',
    },
    '0.7.6':{
        '2.0':'mods\\ASI\\ASI_0_7_6\\2.0',
        '2.1':'mods\\ASI\\ASI_0_7_6\\2.1',
        '2.2':'mods\\ASI\\ASI_0_7_6\\2.2',
        'SDK':'mods\\ASI\\ASI_0_7_6\\SDK',
    },
    '0.8.0':{
        '2.0':'mods\\ASI\\ASI_0_8_0\\2.0',
        '2.1':'mods\\ASI\\ASI_0_8_0\\2.1',
        '2.2':'mods\\ASI\\ASI_0_8_0\\2.2',
        'SDK':'mods\\ASI\\ASI_0_8_0\\SDK',
    },
    '0.9.0':{
        '2.0':'mods\\ASI\\ASI_0_9_0\\2.0',
        '2.1':'mods\\ASI\\ASI_0_9_0\\2.1',
        '2.2':'mods\\ASI\\ASI_0_9_0\\2.2',
        'SDK':'mods\\ASI\\ASI_0_9_0\\SDK',
    },
    '0.10.0':{
        '2.0':'mods\\ASI\\ASI_0_10_0\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_0\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_0\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_0\\SDK',
    },
    '0.10.1':{
        '2.0':'mods\\ASI\\ASI_0_10_1\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_1\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_1\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_1\\SDK',
    },
    '0.10.1h1':{
        '2.0':'mods\\ASI\\ASI_0_10_1h1\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_1h1\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_1h1\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_1h1\\SDK',
    },
    '0.10.2h1':{
        '2.0':'mods\\ASI\\ASI_0_10_2h1\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_2h1\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_2h1\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_2h1\\SDK',
    },
    '0.10.3':{
        '2.0':'mods\\ASI\\ASI_0_10_3\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_3\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_3\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_3\\SDK',
    },
    '0.10.4':{
        '2.0':'mods\\ASI\\ASI_0_10_4\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_4\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_4\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_4\\SDK',
    },
    'Uniscaler':{
        'Uniscaler':'mods\\ASI\\ASI_uniscaler'
    },
    'Uniscaler V2':{
        'Uniscaler V2':'mods\\ASI\\ASI_uniscaler_v2'
    },
    'Uniscaler V3':{ 
        'Uniscaler V3': 'mods\\ASI\\ASI_uniscaler_v3'
    }, 
    'Uniscaler V4':{ 
        'Uniscaler V4': 'mods\\ASI\\ASI_uniscaler_v4' 
    }, 
    'Uniscaler FSR 3.1':{
        'Uniscaler FSR 3.1':'mods\\ASI\\ASI_uniscaler_v3'
    },
    'Uniscaler + Xess + Dlss':{
        'Uniscaler + Xess + Dlss':r'mods\\ASI\\ASI_uniscaler_xess_dlss'
    }
}

def runReg(path_reg):
    reg_path = ['regedit.exe', '/s', path_reg]

    subprocess.run(reg_path,check=True)       

origins_2_2 = None
    
origins_2_2_folder = {
    '0.7.4':'mods\\FSR2FSR3_0.7.4\\FSR2FSR3_220',
    
    '0.7.5':'mods\\FSR2FSR3_0.7.5_hotfix\\FSR2FSR3_220',
    
    '0.7.6':'mods\\FSR2FSR3_0.7.6\\FSR2FSR3_220',
    
    '0.8.0':'mods\\FSR2FSR3_0.8.0\\FSR2FSR3_220',
    
    '0.9.0':['mods\\FSR2FSR3_0.9.0\\Generic FSR\\FSR2FSR3_220',
                'mods\\FSR2FSR3_0.9.0\\FSR2FSR3_COMMON'],
    
    '0.10.0':['mods\\FSR2FSR3_0.10.0\\Generic FSR\\FSR2FSR3_220',
                'mods\\FSR2FSR3_0.10.0\\FSR2FSR3_COMMON'],
    
    '0.10.1':['mods\\FSR2FSR3_0.10.1\\Generic FSR\\FSR2FSR3_220',
                'mods\\FSR2FSR3_0.10.1\\FSR2FSR3_COMMON'],
    
    '0.10.1h1':['mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\Generic FSR\\FSR2FSR3_220',
                'mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\FSR2FSR3_COMMON'],
    
    '0.10.2h1':['mods\\FSR2FSR3_0.10.2h1\\Generic FSR\\FSR2FSR3_220',
                'mods\\FSR2FSR3_0.10.2h1\\FSR2FSR3_COMMON'],
    
    '0.10.3':['mods\\FSR2FSR3_0.10.3\\Generic FSR\\FSR2FSR3_220',
                'mods\\FSR2FSR3_0.10.3\\FSR2FSR3_COMMON'],
    
    '0.10.4':['mods\\FSR2FSR3_0.10.4\\FSR2FSR3_220\\FSR2FSR3_220',
                'mods\\FSR2FSR3_0.10.4\\FSR2FSR3_220\\FSR2FSR3_COMMON'],
    
    'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
    'Uniscaler + Xess + Dlss':r'mods\\FSR2FSR3_Uniscaler_Xess_Dlss\\Uniscaler_mod\\Uniscaler_mod',
    'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
    'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
    'Uniscaler V4':'mods\\FSR2FSR3_Uniscaler_V4\\Uni_V4\\Uni_Mod',
    'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\Uniscaler_FSR31'
    }

list_ignore_uniscaler = ['Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1']

def fsr_2_2():
    global origins_2_2_folder
    
    if select_mod in origins_2_2_folder:
        origins_2_2 = origins_2_2_folder[select_mod]
    else:
        return
    
    if select_mod not in list_ignore_uniscaler:
        try:
            if isinstance(origins_2_2,list):
                for folder_2_2 in origins_2_2:
                    if os.path.isdir(folder_2_2):
                        for file_2_2 in os.listdir(folder_2_2):
                            path_2_2 = os.path.join(folder_2_2,file_2_2)
                            if os.path.isfile(path_2_2):
                                shutil.copy2(path_2_2,select_folder)
            else:
                if os.path.isdir(origins_2_2):
                    for file_2_2 in os.listdir(origins_2_2):
                        path_fsr_2_2 = os.path.join(origins_2_2,file_2_2)
                        if os.path.isfile(path_fsr_2_2):
                            shutil.copy2(path_fsr_2_2,select_folder)
        except Exception as e:
            pass
    else:
        try:
            shutil.copytree(origins_2_2, select_folder, dirs_exist_ok=True)
        except shutil.Error as e:
            pass
    
    if select_mod in asi_global and(select_asi in asi_global[select_mod] or option_asi in asi_global[select_mod]):
        if select_mod in asi_global[select_mod]:
            origins_2_2_f = asi_global[select_mod][select_asi]
        elif select_mod in asi_global[select_mod]:
            origins_2_2_f = asi_global[select_mod][option_asi]
            
    try:
        if select_mod in asi_global:
            if select_asi in asi_global[select_mod]:
                origins_2_2_f = asi_global[select_mod][select_asi]
            else:
                origins_2_2_f = None
                
        if origins_2_2_f and os.path.isdir(origins_2_2_f):
            for i_2_2  in os.listdir(origins_2_2_f):
                file_fsr_2_2 = os.path.join(origins_2_2_f,i_2_2)
                if os.path.isfile(file_fsr_2_2):
                    shutil.copy2(file_fsr_2_2,select_folder)
    except Exception as e:
        print(e)
    
def fsr_2_1():
    
    origins_2_1_folder = {
        '0.7.4':'mods\\FSR2FSR3_0.7.4\\FSR2FSR3_212',
        
        '0.7.5':'mods\\FSR2FSR3_0.7.5_hotfix\\FSR2FSR3_212',
        
        '0.7.6':'mods\\FSR2FSR3_0.7.6\\FSR2FSR3_212',
        
        '0.8.0':'mods\\FSR2FSR3_0.8.0\\FSR2FSR3_212',
        
        '0.9.0':['mods\\FSR2FSR3_0.9.0\\Generic FSR\\FSR2FSR3_210',
                 'mods\\FSR2FSR3_0.9.0\\FSR2FSR3_COMMON'],
        
        '0.10.0':['mods\\FSR2FSR3_0.10.0\\Generic FSR\\FSR2FSR3_210',
                  'mods\\FSR2FSR3_0.10.0\\FSR2FSR3_COMMON'],
        
        '0.10.1':['mods\\FSR2FSR3_0.10.1\\Generic FSR\\FSR2FSR3_210',
                    'mods\\FSR2FSR3_0.10.1\\FSR2FSR3_COMMON'],
        
        '0.10.1h1':['mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\Generic FSR\\FSR2FSR3_210',
                    'mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\\FSR2FSR3_0.10.2h1\\Generic FSR\\FSR2FSR3_210',
                    'mods\\FSR2FSR3_0.10.2h1\\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\\FSR2FSR3_0.10.3\\Generic FSR\\FSR2FSR3_210',
                  'mods\\FSR2FSR3_0.10.3\\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\\FSR2FSR3_0.10.4\\FSR2FSR3_210\\FSR2FSR3_210',
                  'mods\\FSR2FSR3_0.10.4\\FSR2FSR3_210\\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\\FSR2FSR3_Uniscaler_Xess_Dlss\\Uniscaler_mod\\Uniscaler_mod',
        'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
        'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
        'Uniscaler V4':'mods\\FSR2FSR3_Uniscaler_V4\\Uni_V4\\Uni_Mod',
        'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\Uniscaler_FSR31'
    }
    
    if select_mod in origins_2_1_folder:
        origins_2_1 = origins_2_1_folder[select_mod]
    else:
        return
    
    if select_mod not in list_uni:
        try:
            if isinstance(origins_2_1,list):
                for folder_2_1 in origins_2_1:
                    if os.path.isdir(folder_2_1):
                        for file_2_1 in os.listdir(folder_2_1):
                            path_2_1 = os.path.join(folder_2_1,file_2_1)
                            if os.path.isfile(path_2_1):
                                shutil.copy2(path_2_1,select_folder)
            else:
                if os.path.isdir(origins_2_1):
                    for file_2_1 in os.listdir(origins_2_1):
                        path_fsr_2_1 = os.path.join(origins_2_1,file_2_1)
                        if os.path.isfile(path_fsr_2_1):
                            shutil.copy2(path_fsr_2_1,select_folder)
        except Exception as e:
            print(e)
    else:
        try:
            shutil.copytree(origins_2_1, select_folder, dirs_exist_ok=True)     
        except shutil.Error as e:
            print(e)
      
    origins_2_1_f  = None
    if select_mod in asi_global and(select_asi  in asi_global[select_mod] or option_asi in asi_global[select_mod]):
        if select_mod in asi_global[select_mod]:
            origins_2_1_f = asi_global[select_mod][select_asi]
        elif select_mod in asi_global[select_mod]:
            origins_2_1_f = asi_global[select_mod][option_asi]
            
    try:
        if select_mod in asi_global:
            if select_asi in asi_global[select_mod]:
                origins_2_1_f = asi_global[select_mod][select_asi]
            else:
                origins_2_1_f = None
                
        if origins_2_1_f and os.path.isdir(origins_2_1_f):
            for i_2_1  in os.listdir(origins_2_1_f):
                file_fsr_2_1 = os.path.join(origins_2_1_f,i_2_1)
                if os.path.isfile(file_fsr_2_1):
                    shutil.copy2(file_fsr_2_1,select_folder)
            print("Files from directory", origins_2_1_f, "were copied.")
    except Exception as e:
        print(e)

def fsr_2_0():
    global select_option,asi_global
    
    origins_2_0_folder = {
        '0.7.4':'mods\\FSR2FSR3_0.7.4\\FSR2FSR3_201',
        
        '0.7.5':'mods\\FSR2FSR3_0.7.5_hotfix\\FSR2FSR3_201',
        
        '0.7.6':'mods\\FSR2FSR3_0.7.6\\FSR2FSR3_201',
        
        '0.8.0':'mods\\FSR2FSR3_0.8.0\\FSR2FSR3_201',
        
        '0.9.0':['mods\\FSR2FSR3_0.9.0\\Generic FSR\\FSR2FSR3_200',
                 'mods\\FSR2FSR3_0.9.0\\FSR2FSR3_COMMON'],
        
        '0.10.0':['mods\\FSR2FSR3_0.10.0\\Generic FSR\\FSR2FSR3_200',
                  'mods\\FSR2FSR3_0.10.0\\FSR2FSR3_COMMON'],
        
        '0.10.1':['mods\\FSR2FSR3_0.10.1\\Generic FSR\\FSR2FSR3_200',
                    'mods\\FSR2FSR3_0.10.1\\FSR2FSR3_COMMON'],
        
        '0.10.1h1':['mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\Generic FSR\\FSR2FSR3_200',
                    'mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\\FSR2FSR3_0.10.2h1\\Generic FSR\\FSR2FSR3_200',
                    'mods\\FSR2FSR3_0.10.2h1\\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\\FSR2FSR3_0.10.3\\Generic FSR\\FSR2FSR3_200',
                  'mods\\FSR2FSR3_0.10.3\\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\\FSR2FSR3_0.10.4\\FSR2FSR3_200\\FSR2FSR3_200',
                  'mods\\FSR2FSR3_0.10.4\\FSR2FSR3_200\\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\\FSR2FSR3_Uniscaler_Xess_Dlss\\Uniscaler_mod\\Uniscaler_mod',
        'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
        'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
        'Uniscaler V4':'mods\\FSR2FSR3_Uniscaler_V4\\Uni_V4\\Uni_Mod',
        'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\Uniscaler_FSR31'
    }
    
    if select_mod in origins_2_0_folder:
        origins_2_0 = origins_2_0_folder[select_mod]
    else:
        return
     
    if select_mod not in list_uni:   
        try:
            if isinstance(origins_2_0,list):
                for folder_2_0 in origins_2_0:
                    if os.path.isdir(folder_2_0):
                        for file_2_0 in os.listdir(folder_2_0):
                            path_fsr_2_0 = os.path.join(folder_2_0,file_2_0)
                            if os.path.isfile(path_fsr_2_0):
                                shutil.copy2(path_fsr_2_0,select_folder)
            else:
                if os.path.isdir(origins_2_0):
                    for path_2_0 in os.listdir(origins_2_0):
                            path_fsr_2_0 = os.path.join(origins_2_0,path_2_0)
                            if os.path.isfile(path_fsr_2_0):
                                shutil.copy2(path_fsr_2_0,select_folder)
        except Exception as e:
            print(e)
    else:
        try:
            shutil.copytree(origins_2_0, select_folder, dirs_exist_ok=True)
        except shutil.Error as e:
            print(e)
    
    if select_mod in asi_global and(select_asi  in asi_global[select_mod] or option_asi in asi_global[select_mod]):
        if select_mod in asi_global[select_mod]:
            origins_2_0_f = asi_global[select_mod][select_asi]
        elif select_mod in asi_global[select_mod]:
            origins_2_0_f = asi_global[select_mod][option_asi]
            
    try:
        if select_mod in asi_global:
            if select_asi in asi_global[select_mod]:
                origins_2_0_f = asi_global[select_mod][select_asi]
            else:
                origins_2_0_f = None
                
        if origins_2_0_f and os.path.isdir(origins_2_0_f):
            for i_2_1  in os.listdir(origins_2_0_f):
                file_fsr_2_1 = os.path.join(origins_2_0_f,i_2_1)
                if os.path.isfile(file_fsr_2_1):
                    shutil.copy2(file_fsr_2_1,select_folder)
    except Exception as e:
        print(e)

def fsr_sdk():
    global select_fsr,asi_global
    
    origins_sdk_folder = {
        '0.7.4':'mods\\FSR2FSR3_0.7.4\\FSR2FSR3_SDK',
        
        '0.7.5':'mods\\FSR2FSR3_0.7.5_hotfix\\FSR2FSR3_SDK',
        
        '0.7.6':'mods\\FSR2FSR3_0.7.6\\FSR2FSR3_SDK',
        
        '0.8.0':'mods\\FSR2FSR3_0.8.0\\FSR2FSR3_SDK',
        
        '0.9.0':['mods\\FSR2FSR3_0.9.0\\Generic FSR\\FSR2FSR3_SDK',
                 'mods\\FSR2FSR3_0.9.0\\FSR2FSR3_COMMON'],
        
        '0.10.0':['mods\\FSR2FSR3_0.10.0\\Generic FSR\\FSR2FSR3_SDK',
                  'mods\\FSR2FSR3_0.10.0\\FSR2FSR3_COMMON'],
        
        '0.10.1':['mods\\FSR2FSR3_0.10.1\\Generic FSR\\FSR2FSR3_SDK',
                    'mods\\FSR2FSR3_0.10.1\\FSR2FSR3_COMMON'],
        
        '0.10.1h1':['mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\Generic FSR\\FSR2FSR3_SDK',
                    'mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\\FSR2FSR3_0.10.2h1\\Generic FSR\\FSR2FSR3_SDK',
                    'mods\\FSR2FSR3_0.10.2h1\\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\\FSR2FSR3_0.10.3\\Generic FSR\\FSR2FSR3_SDK',
                  'mods\\FSR2FSR3_0.10.3\\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\\FSR2FSR3_0.10.4\\FSR2FSR3_SDK\\FSR2FSR3_SDK',
                  'mods\\FSR2FSR3_0.10.4\\FSR2FSR3_SDK\\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\\FSR2FSR3_Uniscaler_Xess_Dlss\\Uniscaler_mod\\Uniscaler_mod',
        'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
        'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
        'Uniscaler V4':'mods\\FSR2FSR3_Uniscaler_V4\\Uni_V4\\Uni_Mod',
        'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\Uniscaler_FSR31'
    }
    
    if select_mod in origins_sdk_folder:
        origins_sdk = origins_sdk_folder[select_mod]
    
    if select_mod not in list_ignore_uniscaler:
        try:
            if isinstance(origins_sdk,list):
                for sdk_path in origins_sdk:
                    if os.path.isdir(sdk_path):
                        for i_sdk in os.listdir(sdk_path):
                            path_sdk = os.path.join(sdk_path,i_sdk)
                            if os.path.isfile(path_sdk):
                                shutil.copy2(path_sdk,select_folder)
            else:
                if os.path.isdir(origins_sdk):
                    for i_s_dk in os.listdir(origins_sdk):
                        path_s_dk = os.path.join(origins_sdk,i_s_dk)
                        if os.path.isfile(path_s_dk):
                            shutil.copy2(path_s_dk,select_folder)
        except Exception as e:
            print(e)
    else:
        try:
            shutil.copytree(origins_sdk, select_folder, dirs_exist_ok=True)  
        except shutil.Error as e:
            print(e)
 
    if select_mod in asi_global and (select_asi in asi_global[select_mod] or option_asi in asi_global[select_mod]):
        if select_mod in asi_global[select_mod]:
            origins_sdk_f = asi_global[select_mod][select_asi]
        elif select_mod in asi_global[select_mod]:
            origins_sdk_f = asi_global[select_mod][option_asi]
    
    try:
        if select_mod in asi_global:
            if select_asi in asi_global[select_mod]:
                origins_sdk_f = asi_global[select_mod][select_asi]
            else:
                origins_sdk_f = None
                
            if origins_sdk_f and os.path.isdir(origins_sdk_f):
                for i_asi_sdk in os.listdir(origins_sdk_f):
                    path_fsr_sdk = os.path.join(origins_sdk_f,i_asi_sdk)
                    if os.path.isfile(path_fsr_sdk):
                        shutil.copy2(path_fsr_sdk,select_folder)
                    print("Files from directory", origins_sdk_f, "were copied.")
    except Exception as e:
        print(e)

def xess_fsr():
    path_xess = 'mods\\FSR2FSR3_Uniscaler\\CyberXeSS'
    
    name_libxess = os.path.join(select_folder,'libxess.dll')
    name_libxess_old = os.path.join(select_folder,'libxess.txt')
    rename_libxess = 'libxess.txt'
    
    put_xess = messagebox.askyesno('Install Xess 1.3.1','Would you like to enable XESS 1.3.1?')
    if put_xess and os.path.exists(name_libxess) and not os.path.exists(name_libxess_old):
        os.rename(name_libxess,os.path.join(select_folder,rename_libxess))
    
    if put_xess and select_nvngx != 'XESS 1.3.1' or put_xess and not nvngx_contr :
        shutil.copytree(path_xess,select_folder,dirs_exist_ok=True)

def dlss_fsr():
    path_dlss = r'mods\\FSR2FSR3_Uniscaler\nvngx_dlss_3.7.0'
    
    name_dlss = os.path.join(select_folder,'nvngx_dlss.dll')
    name_old_dlss = os.path.join(select_folder,'nvngx_dlss.txt')
    
    rename_dlss = 'nvngx_dlss.txt'
    
    put_dlss = messagebox.askyesno('DLSS 3.8.10','Do you want to enable DLSS 3.8.10?')
    
    if put_dlss and os.path.exists(name_dlss) and not os.path.exists(name_old_dlss) and select_nvngx != 'DLSS 3.8.10':
        os.rename(name_dlss,os.path.join(select_folder,rename_dlss)) 
    
    if put_dlss and select_nvngx != 'DLSS 3.8.10' or put_dlss and not nvngx_contr :
        shutil.copytree(path_dlss,select_folder,dirs_exist_ok=True)

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

        return primary_gpu.lower()  # Return the primary GPU in lowercase

    except subprocess.CalledProcessError:
        return None

def var_gpu_copy(path_amd, path_rtx):
    gpu_name = get_active_gpu()

    print(gpu_name)

    if 'nvidia' in gpu_name:
        shutil.copytree(path_rtx, select_folder, dirs_exist_ok=True)
    elif 'amd' in gpu_name or 'intel' in gpu_name:
        shutil.copytree(path_amd, select_folder, dirs_exist_ok=True)
    elif gpu_name is None:
        shutil.copytree(path_rtx, select_folder, dirs_exist_ok=True if messagebox.askyesno('GPU', 'Do you have an Nvidia GPU?') else path_amd)

def global_dlss():
    path_dlss_rtx = 'mods\\DLSS_Global\\RTX'
    path_dlss_rtx_reshade = 'mods\\DLSS_Global\\RTX_Reshade'
    path_dlss_amd = 'mods\\DLSS_Global\\AMD'
    path_dlss_amd_reshade = 'mods\\DLSS_Global\\AMD_Reshade'
    dlss_global_reg = "mods\\FSR3_LOTF\\RTX\\LOTF_DLLS_3_RTX\\DisableNvidiaSignatureChecks.reg"

    if os.path.exists(os.path.join(select_folder, 'reshade-shaders')):
        var_gpu_copy(path_dlss_amd_reshade, path_dlss_rtx_reshade)
    else:
        var_gpu_copy(path_dlss_amd, path_dlss_rtx)
    
    runReg(dlss_global_reg)

def dlss_to_fsr():
    path_dlss_to_fsr = 'mods\\DLSS_TO_FSR'
    dlss_to_fsr_reg = "mods\\FSR3_LOTF\\RTX\\LOTF_DLLS_3_RTX\\DisableNvidiaSignatureChecks.reg"

    shutil.copytree(path_dlss_to_fsr,select_folder,dirs_exist_ok=True)

    runReg(dlss_to_fsr_reg)

def update_upscalers(dest_path, only_dlss = False, copy_dlssd = False, copy_dlss_dlssd = False, copy_dlss_fsr = False):
    update_fsr = 'mods\\Temp\\FSR_Update'
    update_dlss = 'mods\\Temp\\nvngx_global\\nvngx\\Dlss\\nvngx_dlss.dll'
    update_dlssg = 'mods\\Temp\\nvngx_global\\nvngx\\Dlssg_3_7_1\\nvngx_dlssg.dll'
    update_xess = 'mods\\Temp\\nvngx_global\\nvngx\\libxess.dll'
    update_dlssd = 'mods\\Temp\\nvngx_global\\nvngx\\Dlssd_3_7_1\\nvngx_dlssd.dll'

    if only_dlss:
        if messagebox.askyesno('DLSS', 'Do you want to update DLSS? DLSS 4 will be installed'):
            shutil.copy(update_dlss, dest_path)

    elif copy_dlss_dlssd:
        if messagebox.askyesno('DLSS/DLSSD', 'Do you want to update DLSS/DLSSD? DLSS 4 and DLSSD 4 will be installed.'):
            shutil.copy(update_dlss, dest_path)
            shutil.copy(update_dlssd, dest_path)
    
    elif copy_dlss_fsr:
        if messagebox.askyesno('DLSS/FSR', 'Do you want to update DLSS/FSR? DLSS 4 and FSR 3.1.3 will be installed.'):
            shutil.copy(update_dlss, dest_path)
            shutil.copytree(update_fsr, dest_path, dirs_exist_ok=True)

    else:
        handle_prompt(
            'Update',
            'Do you want to update the upscalers? The latest version of all upscalers will be installed',
            lambda _: (shutil.copytree(update_fsr, dest_path, dirs_exist_ok=True),
            (shutil.copy(update_dlss,dest_path)),
            shutil.copy(update_dlssg,dest_path),
            shutil.copy(update_xess,dest_path),
            shutil.copy(update_dlssd,dest_path) if copy_dlssd else None)
        )

def games_to_update_upscalers():
    default_dlss_path = os.path.abspath(os.path.join(select_folder, '..\\..\\..', 'Engine\\Plugins\\Runtime\\Nvidia\\DLSS\\Binaries\\ThirdParty\\Win64'))

    games_to_update_dlss = {
        'Others Mods Sifu': select_folder,
        'Others Mods Shadow Tomb': select_folder,
        'Others Mods Tlou' : select_folder,
        'Others Mods Steel' : select_folder,
        'Others Mods FFXVI' : select_folder,
        'Others Mods ACE' : select_folder,
        'Others Mods Legion' : select_folder,
        'Others Mods AW2' : select_folder, 
        'Others Mods 6Days' : default_dlss_path,
        'Others Mods HB2':  default_dlss_path,
        'Others Mods Fist' : default_dlss_path,
        'Others Mods HL' :  default_dlss_path,
        'Others Mods GK' :  default_dlss_path,
        'Others Mods WOTH' : default_dlss_path,
        'Others Mods EW' : default_dlss_path,
        'Others Mods TFBK' : default_dlss_path,
        'Others Mods STC' : default_dlss_path,
        'Others GTA Trilogy' : default_dlss_path,
        'Others Mods ATH' : default_dlss_path,
        'Others Mods Stalker 2' : os.path.abspath(os.path.join(select_folder, '..\\..\\..' ,'Engine\\Plugins\\Marketplace\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Others Mods PW' : os.path.abspath(os.path.join(select_folder, '..\\..', 'Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Others Mods KCD2' : os.path.abspath(os.path.join(select_folder, '..' , 'Win64Shared')),
        'Others Mods LOP' : os.path.abspath(os.path.join(select_folder, '..\\..\\..', 'Engine\\Plugins\\Marketplace\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Others Mods FF7RBT' : os.path.abspath(os.path.join(select_folder, '..\\..\\..', 'Engine\\Plugins\\DLSSSubset\\Binaries\\ThirdParty\\Win64')),
        'Others Mods B4B' : os.path.abspath(os.path.join(select_folder, '..\\..\\..', 'Engine\\Binaries\\ThirdParty\\Nvidia\\NGX\\Win64')),
        'Others Mods AITD' : os.path.abspath(os.path.join(select_folder, '..\\..', 'Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Others Mods GR2' : os.path.abspath(os.path.join(select_folder, '..\\..', 'Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Others Mods Remnant II' : os.path.abspath(os.path.join(select_folder,'..\\..', 'Plugins\\Shared\\DLSS\\Binaries\\ThirdParty\\Win64')),
        'Others Mods MShell': os.path.abspath(os.path.join(select_folder, '..\\..\\..', 'Engine\\Binaries\\ThirdParty\\NVIDIA\\NGX\\Win64')),
        'Others Mods POEII': os.path.join(select_folder, 'Streamline'),
    }
    games_to_update_dlssd = {
        'Others Mods Spider': select_folder,
    }
    games_to_update_fsr_dlss = {
        'Others Mods Control' : select_folder,
        'Others Mods HZD' : select_folder,
        'Others Mods Hitman 3' : select_folder
    }

    if select_mod in games_to_update_dlss:
        path_dlss = games_to_update_dlss.get(select_mod).lower()
        print(path_dlss)
        if os.path.exists(os.path.join(path_dlss)):
            update_upscalers(path_dlss, True)
        else:
            messagebox.showinfo('DLSS',f'To update DLSS, select the .exe path.')

    elif select_mod in games_to_update_dlssd:
        path_dlssd = games_to_update_dlssd.get(select_mod).lower()
        
        if os.path.exists(os.path.join(path_dlssd)):
            update_upscalers(path_dlssd, False, True)
        else:
            messagebox.showinfo('DLSSD',f'To update DLSSD, select the .exe path.')
    
    elif select_mod in games_to_update_fsr_dlss:
        path_fsr_dlss = games_to_update_fsr_dlss.get(select_mod).lower()
        
        if os.path.exists(os.path.join(path_fsr_dlss)):
            update_upscalers(path_fsr_dlss, False, False, False, True)
        else:
            messagebox.showinfo('FSR/DLSS',f'To update FSR/DLSS, select the .exe path.')

def dlss_overlay():
    enable_dlss_overlay = 'mods\\Addons_mods\\DLSS Preset Overlay\\Enable Overlay.reg'
    gpu_name = get_active_gpu()

    if 'rtx' in gpu_name and not os.path.exists(os.path.join(select_folder, 'Enable Overlay.reg')):
        handle_prompt(
        'DLSS Overlay',
        'Do you want to enable the DLSS Overlay? (It is useful for verifying if the preset selected for DLSS 4 in Optiscaler is correct (Preset K), but it is not required. It cannot be disabled in the game for now; to remove it, uninstall the mod and reinstall it, check the FSR 3.1.3/DLSS Guide (Only Optiscaler) in the FSR Guide to learn how to use DLSS 4.)',
        lambda _: (
            runReg(enable_dlss_overlay),
            shutil.copy(enable_dlss_overlay, select_folder)
            )
        )

mods_to_install_optiscaler_fsr_dlss = {'FSR 3.1.3/DLSS FG (Only Optiscaler)','FSR 3.1.3/DLSSG FG (Only Optiscaler)','FSR 3.1.3/DLSS Gow4','FSR 3.1.3/DLSS FG Custom RDR2'}
def optiscaler_fsr_dlss(copy_dlss = True, copy_nvapi = True): # Default Optiscaler is used for games that don't work with Custom Optiscaler or other mods
    path_optiscaler = 'mods\\Addons_mods\\OptiScaler'
    path_optiscaler_dlss = 'mods\\Addons_mods\\Optiscaler DLSS'
    path_optiscaler_dlssg = 'mods\\Addons_mods\\Optiscaler DLSSG\\nvngx.ini'
    path_dlss_to_fsr = 'mods\\Addons_mods\\Optiscaler DLSSG\\dlssg_to_fsr3_amd_is_better.dll'
    path_ini_only_upscalers = 'mods\\Addons_mods\\Optiscaler Only Upscalers\\nvngx.ini'
    nvapi_amd = 'mods\\Addons_mods\\Nvapi AMD\\Nvapi'
    nvapi_ini = 'mods\\Addons_mods\\Nvapi AMD\\Nvapi Ini\\nvngx.ini'
    nvapi_ini_dlssg = 'mods\\Addons_mods\\Nvapi AMD\\DLSSG Nvapi Ini\\nvngx.ini'
    gpu_name = get_active_gpu()
    games_to_install_nvapi_amd = ['Microsoft Flight Simulator 2024', 'Death Stranding Director\'s Cut', 'Shadow of the Tomb Raider', 'Rise of The Tomb Raider', 'The Witcher 3', 'Uncharted Legacy of Thieves Collection', 'Suicide Squad: Kill the Justice League','Sifu', 'Mortal Shell', 'FIST: Forged In Shadow Torch', 'Ghostrunner 2', 'Final Fantasy XVI', 'Sengoku Dynasty', 'Red Dead Redemption 2', 'S.T.A.L.K.E.R. 2']
    games_to_use_anti_lag_2 = ['God of War Ragnarök', 'God Of War 4', 'Path of Exile II', 'Hitman 3', 'Marvel\'s Midnight Suns', 'Hogwarts Legacy', 'The First Berserker: Khazan']
    games_only_upscalers = ['The Last Of Us Part I']
    games_with_dlssg = ['The First Berserker: Khazan', 'Atomic Heart','Marvel\'s Spider-Man Remastered', 'Marvel\'s Spider-Man Miles Morales', 'Marvel\'s Spider-Man 2', 'Alan Wake 2', 'S.T.A.L.K.E.R. 2', 'Eternal Strands' ]
    games_with_anti_cheat = ['Back 4 Blood']
    games_no_nvngx = ['Red Dead Redemption 2', 'Marvel\'s Spider-Man Remastered', 'Marvel\'s Spider-Man Miles Morales', 'Marvel\'s Spider-Man 2'] # Games that don't need the file nvngx_dlss.dll renamed to nvngx.dll (Only RTX)

    try:
        # Rename the dxgi.dll file from ReShade to d3d12.dll
        if os.path.exists(os.path.join(select_folder, 'dxgi.dll')) and os.path.exists(os.path.join(select_folder, 'reshade-shaders')):
            os.replace(os.path.join(select_folder, 'dxgi.dll'), os.path.join(select_folder, 'd3d12.dll'))

        # Rename the DLSS file (nvngx_dlss.dll) to nvngx.dll.
        if os.path.exists(os.path.join(select_folder, 'nvngx_dlss.dll')) and copy_dlss:
            shutil.copytree(path_optiscaler, select_folder, dirs_exist_ok=True)
            os.replace(os.path.join(select_folder, 'nvngx.dll'), os.path.join(select_folder, 'dxgi.dll'))

            if not select_option in games_no_nvngx or gpu_name in ['amd', 'rx', 'intel', 'arc', 'gtx']:
                shutil.copy(os.path.join(select_folder, 'nvngx_dlss.dll'), os.path.join(select_folder, 'nvngx.dll'))
        else:
            shutil.copytree(path_optiscaler_dlss, select_folder, dirs_exist_ok=True)

            if select_option in games_no_nvngx and 'rtx' in gpu_name and os.path.exists(os.path.join(select_folder, 'nvngx.dll')):
                os.replace(os.path.join(select_folder, 'nvngx.dll'), os.path.join(select_folder, 'nvngx_dlss.dll'))

        if select_mod == 'FSR 3.1.3/DLSSG FG (Only Optiscaler)':
            shutil.copy(path_optiscaler_dlssg, select_folder)

            # Install the dlss_to_fsr file if the mod does not work with the default files
            if any(gpus in gpu_name for gpus in ['amd', 'rx', 'intel', 'arc', 'gtx', 'rtx']) and select_option not in games_only_upscalers and messagebox.askyesno('DLSS/FSR','Do you want to install the dlssg_to_fsr3_amd_is_better.dll file? It is recommended to install this only if you are unable to enable the game\'s DLSS Frame Generation (this mod does not have its own FG; the game\'s DLSS FG is used).' or select_option in games_with_dlssg ):
                shutil.copy(path_dlss_to_fsr, select_folder)

        if select_option in games_only_upscalers:
            shutil.copy(path_ini_only_upscalers, select_folder)

        # AMD Anti Lag 2
        if select_option in games_to_use_anti_lag_2 and messagebox.askyesno('Anti Lag 2', f'Do you want to use AMD Anti Lag 2? Check the {select_option} guide in FSR Guide to see how to enable it.'):
            shutil.copytree(nvapi_amd, select_folder, dirs_exist_ok=True)

            nvapi_ini_file = nvapi_ini_dlssg if select_mod == 'FSR 3.1.3/DLSSG FG (Only Optiscaler)' else nvapi_ini
            shutil.copy(nvapi_ini_file, select_folder)

        # Nvapi for non-RTX users
        elif copy_nvapi and any(gpus in gpu_name for gpus in ['amd', 'rx', 'intel', 'arc', 'gtx']) and select_option in games_to_install_nvapi_amd and messagebox.askyesno('Nvapi', 'Do you want to install Nvapi? Only select "Yes" if the mod doesn\'t work with the default files.'):
            shutil.copytree(nvapi_amd, select_folder, dirs_exist_ok=True)
            
            nvapi_ini_file = nvapi_ini_dlssg if select_mod == 'FSR 3.1.3/DLSSG FG (Only Optiscaler)' else nvapi_ini
            shutil.copy(nvapi_ini_file, select_folder)

        if select_option in games_with_anti_cheat:
            messagebox.showinfo('Anti Cheat','Do not use the mod in Online mode, or you may be banned')
        
        # Enable DLSS Overlay
        dlss_overlay()

    except Exception as e:
        print(e)

def fsr3_rdr2():
    global select_fsr,select_mod

    rdr2_mix = 'mods\\RDR2_FSR3_mix'
    rdr2_fg_custom = 'mods\\FSR3_RDR2\\RDR2 FG Custom'
    rdr2_amd_ini  = 'mods\\FSR3_RDR2\\RDR2 FG Custom\\Amd Ini\\RDR2Upscaler.ini'   
    gpu_name = get_active_gpu()

    if select_mod == 'RDR2 Mix':
        shutil.copytree(rdr2_mix, select_folder, dirs_exist_ok=True)
    
    if select_mod == 'RDR2 FG Custom':
        shutil.copytree(rdr2_fg_custom, select_folder)

        if 'amd' in gpu_name and os.path.exists(os.path.join(select_folder, 'mods')):
            shutil.copy(rdr2_amd_ini,os.path.join(select_folder, 'mods'))

def fsr3_dd2():
    dinput_dd2 = 'mods\\FSR3_DD2\\dinput'

    if select_mod == 'Dinput8 DD2':
        shutil.copytree(dinput_dd2, select_folder, dirs_exist_ok=True)
    else:
        messagebox.showinfo('Dinput8','If you haven\'t installed the dinput8.dll file, check the DD2 guide in the FSR Guide for installation instructions. It is required for the mod to work')

    if os.path.exists(os.path.join(select_folder,'shader.cache2')):
        if messagebox.showinfo('Do you want to remove the sharder_cache2? It is necessary for the mod to work'):
            os.remove(os.path.join(select_folder,'shader.cache2'))

er_origins = {'Disable_Anti-Cheat':'mods\\Elden_Ring_FSR3\\ToggleAntiCheat',
              'Elden_Ring_FSR3':'mods\\Elden_Ring_FSR3\\EldenRing_FSR3',
              'Elden_Ring_FSR3 V2':'mods\\Elden_Ring_FSR3\\EldenRing_FSR3 v2',
              'FSR 3.1.3/DLSS FG Custom Elden':'mods\\Elden_Ring_FSR3\\EldenRing_FSR3 v3',
              }

def elden_fsr3():
    global er_origins
    update_fsr_elden = 'mods\\Temp\\FSR_Update'
    update_dlss_elden = 'mods\\Temp\\nvngx_global\\nvngx\\Dlss\\nvngx_dlss.dll'

    if select_mod in er_origins:
        elden_folder = er_origins[select_mod]

    if select_mod in er_origins:
        shutil.copytree(elden_folder,select_folder, dirs_exist_ok=True)

    if select_mod == 'Unlock FPS Elden':  
        shutil.copytree('mods\\Elden_Ring_FSR3\\Unlock_Fps',select_folder,dirs_exist_ok=True)

    if os.path.exists(os.path.join(select_folder, 'toggle_anti_cheat.exe')):
        run_dis_anti_c()
    
    if select_mod == 'FSR 3.1.3/DLSS FG Custom Elden' and os.path.exists(os.path.join(select_folder,'ERSS2\\bin')):
        shutil.copytree(update_fsr_elden,os.path.join(select_folder,'ERSS2\\bin'), dirs_exist_ok=True)
        shutil.copy(update_dlss_elden, os.path.join(select_folder,'ERSS2\\bin'))
    
    # Enable DLSS Overlay
    dlss_overlay()

def run_dis_anti_c():
    var_anti_c = messagebox.askyesno('Disable Anti Cheat','Do you want to disable the anticheat? (only for Steam users)')
    
    del_anti_c_path = os.path.join(select_folder,'toggle_anti_cheat.exe')
    if var_anti_c:
        subprocess.call(del_anti_c_path)

def bdg_fsr3():
    bdg_origins = {'Baldur\'s Gate 3 FSR3':'mods\\FSR3_BDG',
               'Baldur\'s Gate 3 FSR3 V2':['mods\\FSR3_BDG','mods\\FSR3_BDG\\FSR3_BDG_2'],
               'Baldur\'s Gate 3 FSR3 V3':['mods\\FSR3_BDG','mods\\FSR3_BDG\\FSR3_BDG_2']}
    
    if select_mod in bdg_origins:
        bdg_origin = bdg_origins[select_mod]
    
        if isinstance(bdg_origin, list):  
            for path_bdg in bdg_origin:
                shutil.copytree(path_bdg, select_folder, dirs_exist_ok=True)
        else:
            shutil.copytree(bdg_origin, select_folder, dirs_exist_ok=True)
        
        if select_mod == 'Baldur\'s Gate 3 FSR3 V3':
            path_bdg_ini = 'mods\\FSR3_BDG_3\\BG3Upscaler.ini'
            path_mods_bdg = os.path.join(select_folder,'mods')
            
            if os.path.exists(path_mods_bdg):
                shutil.copy2(path_bdg_ini,path_mods_bdg)
            
callisto_origins = {'The Callisto Protocol FSR3':'mods\\FSR3_Callisto\\FSR_Callisto'}
def callisto_fsr():
    path_tcp = 'mods\\FSR3_Callisto\\Reshade\\TCP Cinematic\\TCP.ini'
    path_real_life = 'mods\\FSR3_Callisto\\Reshade\\The Real Life\\The Real Life The Callisto Protocol Reshade BETTER TEXTURES and Realism 2022.ini'
    fsr_custom_callisto = 'mods\\FSR3_DL2\\Custom_FSR'
    
    if select_mod == 'FSR 3.1.3/DLSS Custom Callisto':
        shutil.copytree(fsr_custom_callisto, select_folder, dirs_exist_ok=True)

    if select_mod in callisto_origins:
        callisto_origin  = callisto_origins[select_mod]
    
    if select_mod in callisto_origins:
        shutil.copytree(callisto_origin,select_folder,dirs_exist_ok=True)
    
    if messagebox.askyesno('TCP MOD','Do you want to install the TCP mod? (It is necessary to install ReShade for this mod to work, check the guide in FSR GUIDE for more information about the mod.)'):
        shutil.copy(path_tcp,select_folder)
    
    if messagebox.askyesno('Real Life','Do you want to install the Real Life mod? (It is necessary to install ReShade for the mod to work, check the guide in FSR GUIDE for more information about the mod and how to install it.)'):
        shutil.copy(path_real_life,select_folder)

def fallout_fsr():
    high_fps_path = 'mods\\FSR3_Fallout4\\High FPS Physics'
    f4se_plugins = 'mods\\FSR3_Fallout4\\Addres Library'
    fl4_ups_rtx = 'mods\\FSR3_Fallout4\\Fallout_Upscaler_RTX'
    fl4_ot_gpus = 'mods\\FSR3_Fallout4\\Fallout_Upscaler_Others'
    loader_fl4 = 'mods\\FSR3_Fallout4\\Loader_Fallout4'
    path_data = os.path.join(select_folder,'Data')
    not_loader_fl4 = 'mods\\FSR3_Fallout4\\Loader_Fallout4_TRUE3DSOUND_Compatible'
    f4se_fl4 = 'mods\\FSR3_Fallout4\\f4se_0_06_23\\f4se_0_06_23'
    path_ini_fps = os.path.join(select_folder,r'Data\\Data\\F4SE\\Plugins\\HighFPSPhysicsFix.ini')
    path_sym_link = 'mods\\FSR3_Fallout4\\SymlinkCreator.exe'
    
    gpu_ups = messagebox.askyesno('Select GPU','Do you own an RTX 4xxx?')
    
    fps_user= tk.simpledialog.askstring("FPS", "Type half of your monitor's refresh rate (Hz), for example: 60Hz, type 30.")
    if fps_user is None:
        fps_user = 0.0
    
    fps_user_int = int(fps_user)
    
    open_sym_link = messagebox.askyesno('Open Sym Link','Do you want to open the Sym Link? It is necessary to proceed with the installation.')
    
    try:
        if os.path.exists(os.path.join(select_folder,'Data')):
            shutil.copytree(high_fps_path,path_data, dirs_exist_ok=True)
            shutil.copytree(f4se_plugins,path_data, dirs_exist_ok=True)
            
            if gpu_ups :
                shutil.copytree(fl4_ups_rtx,path_data, dirs_exist_ok=True)
                
            elif not gpu_ups:
                shutil.copytree(fl4_ot_gpus,path_data, dirs_exist_ok=True)

            if not os.path.exists(path_ini_fps):
                messagebox.showinfo('Error','File HighFPSPhysicsFix.ini not found, please check if the file is in the folder with the ending Data\\Data\\F4SE\\Plugins, if necessary reinstall the mod.')
            else:
                config_fps = ConfigObj(path_ini_fps)

                if 'Limiter' not in config_fps:
                    config_fps['Limiter'] = {}

                config_fps['Limiter']['InGameFPS'] = fps_user_int - 1

                config_fps.write()
                        
        if os.path.exists(os.path.join(select_folder,'True3DSound.dll')):
            shutil.copytree(loader_fl4,select_folder, dirs_exist_ok=True)
        else:
            shutil.copytree(not_loader_fl4,select_folder, dirs_exist_ok=True)
        try:
            shutil.copytree(f4se_fl4,select_folder, dirs_exist_ok=True)
        except Exception:
            pass
        
        if open_sym_link:
            subprocess.run(path_sym_link)
        else:
            return
        
    except Exception as e:
        messagebox.showinfo('Error','Error during installation, please try again.')

def fh_fsr3():
    var_gpu = messagebox.askyesno('Select GPU','Do you have an Nvidia RTX GPU?')
    
    path_rtx = 'mods\\FSR3_FH\\RTX'
    path_ot_gpu = 'mods\\FSR3_FH\\Ot_Gpu'
    
    en_rtx_reg = "mods\\FSR3_FH\\RTX\\DisableNvidiaSignatureChecks.reg"
    
    if var_gpu:
        shutil.copytree(path_rtx,select_folder,dirs_exist_ok=True)
        runReg(en_rtx_reg)
    elif not var_gpu:
        shutil.copytree(path_ot_gpu,select_folder,dirs_exist_ok=True)

def pw_fsr3():
    gpu_name = get_active_gpu()  
    path_pw_mod = 'mods\\FSR3_PW\\FG'
    path_ini_fg_rtx = 'mods\\FSR3_PW\\Ini FG RTX\\PalworldUpscaler.ini'
    appdata_pw = os.getenv("LOCALAPPDATA")
    path_ini_pw = os.path.join(appdata_pw, 'Pal\\Saved\\Config\\WinGDK')
    dx12_ini_pw = 'mods\\FSR3_PW\\Dx12\\Engine.ini'

    if select_mod == 'Palworld Build03':
        shutil.copytree(path_pw_mod,select_folder,dirs_exist_ok=True)

        if 'rtx' in gpu_name and os.path.exists(os.path.join(select_folder, 'mods')):
            shutil.copy(path_ini_fg_rtx, os.path.join(select_folder, 'mods'))

    try:
        if os.path.exists(os.path.join(select_folder, 'Palworld-WinGDK-Shipping.exe')):

            if os.path.exists(path_ini_pw):
                if not os.path.exists(os.path.abspath(os.path.join(path_ini_pw, '..', 'Engine.ini'))):
                    shutil.copy(os.path.join(path_ini_pw, 'Engine.ini'), os.path.abspath(os.path.join(path_ini_pw, '..'))) # Engine.ini Backup

                    shutil.copy(dx12_ini_pw, path_ini_pw)
            else:
                shutil.copy(dx12_ini_pw, select_folder)
                messagebox.showinfo('Error', 'Unable to activate DX12 (it is required for the mod to work). Try reinstalling or copy the Engine.ini file, which was installed in the selected folder in Utility, to the following path:"C:\\Users\\YourName\\AppData\\Local\\Pal\\Saved\\Config\\WinGDK".')
        
        elif os.path.exists(os.path.join(select_folder, 'Palworld-Win64-Shipping.exe')):
            messagebox.showinfo('DX12', 'Check the "Palworld" guide in FSR Guide on how to enable DX12 (it is required for the mod to work).')

    except:
        shutil.copy(dx12_ini_pw, select_folder)
        messagebox.showinfo('Error', 'Unable to activate DX12 (it is required for the mod to work). Try reinstalling or copy the Engine.ini file, which was installed in the selected folder in Utility, to the following path:"C:\\Users\\YourName\\AppData\\Local\\Pal\\Saved\\Config\\WinGDK".')
    
def ulck_fps_tekken():
    path_tekken = 'mods\\Unlock_fps_Tekken'
    
    if select_mod == 'Unlock Fps Tekken 8':
        shutil.copytree(path_tekken,select_folder,dirs_exist_ok=True)

    messagebox.showinfo('Run Overlay','Run TekkenOverlay.exe for the mod to work, refer to the FSR GUIDE if needed.')

def auto_shortcut(path_exe,name_shortcut,dx_12,name_messagebox):
    create_shortcut_icr = messagebox.askyesno('Create Shortcut',f'Do you want to create a DX12 shortcut? If you prefer to create it manually, click "NO" and follow the steps in the {name_messagebox} guide in FSR GUIDE. This is necessary for the mod to work correctly.')
    
    if create_shortcut_icr:
        if os.path.exists(path_exe):
            shell_win = win32com.client.Dispatch("WScript.Shell")
            desktop_path = shell_win.SpecialFolders("Desktop")
            shortcut_path = os.path.join(desktop_path, name_shortcut + ".lnk")
            shortcut_icr = shell_win.CreateShortcut(shortcut_path)
            shortcut_icr.TargetPath = path_exe
            shortcut_icr.Arguments = dx_12
            shortcut_icr.Save()
            messagebox.showinfo('Shortcut successfully created','Shortcut successfully created on the Desktop, run the game through the shortcut for the mod to function properly.')
        else:
            messagebox.showinfo(f'Shortcut Not Found',f'"{path_exe}" not found, please create a shortcut manually, see the {name_messagebox} guide in FSR GUIDE and follow the steps.')
               
def icarus_fsr3():
    icr_rtx = 'mods\\FSR3_ICR\\ICARUS_DLSS_3_FOR_RTX'
    icr_ot_gpu = 'mods\\FSR3_ICR\\ICARUS_FSR_3_FOR_AMD_GTX'
    icr_rtx_reg = "mods\\FSR3_ICR\\ICARUS_DLSS_3_FOR_RTX\\DisableNvidiaSignatureChecks.reg"
    
    if select_mod == 'Icarus FSR3 RTX':
        shutil.copytree(icr_rtx,select_folder,dirs_exist_ok=True)
        act_dlss = messagebox.askyesno('DLSS','Do you want to run DisableNvidiaSignatureChecks.reg? It\'s necessary for the mod to work')
        
        if act_dlss:
            runReg(icr_rtx_reg)
    
    elif select_mod == 'Icarus FSR3 AMD/GTX':
        shutil.copytree(icr_ot_gpu,select_folder,dirs_exist_ok=True)
    
    shortcut_icr_path = os.path.join(select_folder,'Icarus-Win64-Shipping.exe')
    new_target_path = ('Icarus') 
    dx_12 = "-dx12"
    game_name = 'Icarus'
    
    auto_shortcut(shortcut_icr_path,new_target_path,dx_12,game_name)

def chernobylite_short_cut():
    shortcut_cbl_path = os.path.join(select_folder,'ChernobylGame-Win64-Shipping.exe')
    new_target_path = ('Chernobylite') 
    dx_12 = "-dx12"
    game_name = 'Chernobylite'
    
    if select_option == 'Chernobylite':
        auto_shortcut(shortcut_cbl_path,new_target_path,dx_12,game_name)

def gtav_fsr3():
    dinput8_gtav = 'mods\\FSR3_GTAV\\dinput8_gtav'
    gtav_fsr3_path ='mods\\FSR3_GTAV\\GtaV_B02_FSR3'
    gta_v_epic = 'mods\\FSR3_GTAV\\Gtav_Epic'
    file_dxgi_asi = os.path.join(select_folder,'dxgi.asi')
    file_gtavups_asi = os.path.join(select_folder,'GTAVUpscaler.asi')
    file_gtavups_org = os.path.join(select_folder,'GTAVUpscaler.org.asi')
    rename_asi = 'dxgi.dll'
    rename_asi_online = 'd3d12.dll'
    rename_gtavups_asi = 'GTAVUpscaler.dll'
    rename_gtavups_org = 'GTAVUpscaler.org.dll'
    gpu_name = get_active_gpu()  
    enable_dlss_overlay = 'mods\\Addons_mods\\DLSS Preset Overlay\\Enable Overlay.reg'
    dinput8_var = os.path.exists(os.path.join(select_folder,'dinput8.dll'))

    if 'rtx' in gpu_name:
        handle_prompt(
        'DLSS Overlay',
        'Do you want to enable the DLSS Overlay? (It is useful for verifying if the preset selected for DLSS 4 in Optiscaler is correct (Preset K), but it is not required. It cannot be disabled in the game for now; to remove it, uninstall the mod and reinstall it.)',
        lambda _: (
            runReg(enable_dlss_overlay),
            shutil.copy(enable_dlss_overlay, select_folder)
            )
        )

    if select_mod == 'Dinput 8':
        shutil.copytree(dinput8_gtav,select_folder,dirs_exist_ok=True)
        return True
        
    elif select_mod == 'GTA V FSR3/DLSS4' and dinput8_var:
        shutil.copytree(gtav_fsr3_path,select_folder,dirs_exist_ok=True)
        return True
    
    elif select_mod == 'GTA V FiveM':
        fivem_ui = messagebox.askyesno('UI Fix','Do you want to fix the delay in the FiveM user interface?')
        shutil.copytree(gtav_fsr3_path,select_folder,dirs_exist_ok=True)
        if fivem_ui:
            os.rename(file_dxgi_asi,os.path.join(select_folder,rename_asi))
        return True
    
    elif select_mod == 'GTA Online':
        ban_var = messagebox.askyesno('Ban','We are not responsible if you get banned. Do you want to proceed with the installation of the mod?')
        
        if ban_var:
            shutil.copytree(gtav_fsr3_path,select_folder,dirs_exist_ok=True)
            if os.path.exists(os.path.join(select_folder,file_dxgi_asi)):
                
                os.rename(file_dxgi_asi,os.path.join(select_folder,rename_asi_online))
                os.rename(file_gtavups_asi,os.path.join(select_folder,rename_gtavups_asi))
                os.rename(file_gtavups_org,os.path.join(select_folder,rename_gtavups_org))
                
                shutil.copy2(os.path.join(select_folder,rename_asi_online),os.path.join(select_folder,'mods'))
                shutil.copy2(os.path.join(select_folder,rename_gtavups_asi),os.path.join(select_folder,'mods'))
                shutil.copy2(os.path.join(select_folder,rename_gtavups_org),os.path.join(select_folder,'mods'))
        else:
            return
        return True
    
    elif select_mod == 'GTA V FSR3/DLSS4' and not dinput8_var and select_mod :
        messagebox.showinfo('Dinput 8 not found', 'Please install the \'dinput8\' file. Refer to the GTA V FSR Guide if you need assistance.')
        return False

    elif select_mod == 'GTA V Epic':
        shutil.copytree(gtav_fsr3_path,select_folder,dirs_exist_ok=True)
        return True
    
    elif select_mod == 'GTA V Epic V2':
        shutil.copytree(gta_v_epic,select_folder,dirs_exist_ok=True)
        return True

def lotf_fsr3():
    rtx_fsr3 = 'mods\\FSR3_LOTF\\RTX\\LOTF_DLLS_3_RTX'
    amd_gtx_fsr3 = 'mods\\FSR3_LOTF\\AMD_GTX'
    lotf_rtx_reg = "mods\\FSR3_LOTF\\RTX\\LOTF_DLLS_3_RTX\\DisableNvidiaSignatureChecks.reg"
    
    if select_mod == 'Lords of The Fallen FSR3':
        rtx_amd = messagebox.askyesno('RTX','Do you have an RTX GPU?"?')
        if rtx_amd:
            shutil.copytree(rtx_fsr3,select_folder,dirs_exist_ok=True)
        else:
            shutil.copytree(amd_gtx_fsr3,select_folder,dirs_exist_ok=True)
    
        runReg(lotf_rtx_reg)
        
        shortcut_lotf_bat = messagebox.askyesno('Shortcut','Do you want to create a shortcut for the .bat file? To make the mod work, you need to run the game through the .bat file')
        bat_path = os.path.join(select_folder,'launch.bat')
        if shortcut_lotf_bat:
            shell_win = win32com.client.Dispatch("WScript.Shell")
            desktop_path = shell_win.SpecialFolders("Desktop")
            shortcut_path = os.path.join(desktop_path, 'launch.bat' + ".lnk")
            shortcut_lotf= shell_win.CreateShortcut(shortcut_path)
            shortcut_lotf.TargetPath = bat_path
            shortcut_lotf.Save()

def cod_fsr():
    messagebox.showinfo('Ban','Do not use the mod in multiplayer, otherwise you may be banned. We are not responsible for any bans')

def cod_mw3_fsr3():
    global_dlss()

def metro_fsr3():
    preset_metro = 'mods\\FSR3_Metro\\Preset\\DefinitiveEdition.ini'
    
    if select_mod == 'Others Mods Metro':
        # Graphics Preset
        handle_prompt(
        'Graphics Preset',
        'Do you want to install the Graphics Preset? Check the ReShade guide in the Metro Exodus Enhanced guide to complete the installation.',
        lambda _: (
            shutil.copy(preset_metro, select_folder)
            )
        )

def hfw_fsr3():
    hfw_rtx = 'mods\\FSR3_HFW\\RTX FSR3'
    xess_hfw ='mods\\Temp\\nvngx_global\\nvngx\\libxess.dll'
    hfw_ot_gpu = 'mods\\FSR3_Callisto\\FSR_Callisto'
    hfw_rtx_reg = "mods\\FSR3_HFW\\RTX FSR3\\DisableNvidiaSignatureChecks.reg"
    hfw_ot_gpu_reg = "mods\\Temp\\enable signature override\\EnableSignatureOverride.reg"
    
    if select_mod == 'Horizon Forbidden West FSR3':
        var_gpu = messagebox.askyesno('GPU','Do you have an RTX GPU?')
        
        if var_gpu:
            shutil.copytree(hfw_rtx,select_folder,dirs_exist_ok=True)
            shutil.copy2(xess_hfw,select_folder)
            runReg(hfw_rtx_reg)
            
        else:
            shutil.copytree(hfw_ot_gpu,select_folder,dirs_exist_ok=True)
            shutil.copy2(xess_hfw,select_folder)
            runReg(hfw_ot_gpu_reg)

def fsr3_dg_veil():
    amd_dg_veil = 'mods\\DLSS_Global\\For games that have native FG\\AMD'
    rtx_dg_veil = 'mods\\DLSS_Global\\For games that have native FG\\RTX'
    anti_stutter_dg_veil = 'mods\\FSR3_Dg_Veil\\Anti Stutter\\Install DATV High CPU Priority.reg'
    var_anti_stutter_dg_veil =  'mods\\FSR3_SH2\\Anti_Stutter\\AntiStutter.txt'
    remove_filter_purple_dg_veil = 'mods\\FSR3_Dg_Veil\\Remove_Purple_Tones'

    if select_mod == 'FSR 3.1.3/DLSS DG Veil':
        var_gpu_copy(amd_dg_veil, rtx_dg_veil)

    if select_mod == 'Others Mods DG Veil':
        # Anti Stutter
        handle_prompt(
            'Anti Stutter',
            'Do you want to enable Anti-Stutter? (prevents possible stuttering in the game)',
            lambda _: (
                runReg(anti_stutter_dg_veil),
                shutil.copy(var_anti_stutter_dg_veil, select_folder)
                )
            )

        # Remove Purple Tones
        handle_prompt(
            'Filter Purple Color',
            'Do you want to remove the purple color filter from the game?',
            lambda _: (
                shutil.copytree(remove_filter_purple_dg_veil, select_folder, dirs_exist_ok=True)
                )
            )

def fsr3_control():
    Hdr_control_paths = {
        'Steam': 'mods\\FSR3_Control\\HDR\\Control HDR v1.5.1 (Steam)',
        'Epic': 'mods\\FSR3_Control\\HDR\\Control HDR v1.5.1 (Epic Store)',
        'Others': 'mods\\FSR3_Control\\HDR\\Control HDR v1.5.1 (No DRM)'
    }
    backup_hdr_control = os.path.join(select_folder, 'HDR Control')

    if select_mod == 'FSR 3.1.3/DLSS FG (Only Optiscaler)':
        if not os.path.exists(backup_hdr_control):
            os.makedirs(backup_hdr_control)

        path_to_backup = None
        for store, path in Hdr_control_paths.items():
            if store != 'Others' and messagebox.askyesno(store,f'Is your game on {store}?'):
                path_to_backup = path
                break
    
        if not path_to_backup:
            path_to_backup = Hdr_control_paths['Others']
        
        messagebox.showinfo('Await', 'Wait until the mod is installed.')

        for root, _, files in os.walk(path_to_backup):
            for file_name in files:
                source_file = os.path.join(root, file_name)
                relative_path = os.path.relpath(source_file, path_to_backup)
                dest_file = os.path.join(select_folder, relative_path)
                backup_file = os.path.join(backup_hdr_control, relative_path)

                if os.path.exists(dest_file) and open(source_file, "rb").read() == open(dest_file, "rb").read():
                    os.makedirs(os.path.dirname(backup_file), exist_ok=True)
                    shutil.copy2(dest_file, backup_file)
        
        if path_to_backup:
            shutil.copytree(path, select_folder, dirs_exist_ok=True)
        else:
            shutil.copytree(path_to_backup, select_folder, dirs_exist_ok=True)
        
    
def fsr3_aw2():
    path_rtx = 'mods\\FSR3_AW2\\RTX'
    path_dlss = 'mods\\Temp\\nvngx_global\\nvngx\\nvngx_dlss.dll'
    path_amd = 'mods\\FSR3_AW2\\AMD'
    appdata_aw2 = os.getenv("LOCALAPPDATA")
    path_folder_ini_aw2 = appdata_aw2 + '\\Remedy\\AlanWake2'
    path_iniaw2 = path_folder_ini_aw2 + '\\renderer.ini'
    path_backup_ini_aw2 = os.path.abspath(os.path.join(path_folder_ini_aw2,'..'))
    preset_aw2 = 'mods\\FSR3_AW2\\Preset\\Realistic Reshade.ini'
    anti_stutter_aw2 = 'mods\\FSR3_AW2\\Anti Stutter\\Install Alan Wake 2 CPU Priority.reg'
    var_anti_sttuter_aw2 = 'mods\\FSR3_SH2\\Anti_Stutter\\AntiStutter.txt'
    rt_normal_aw2 = 'mods\\FSR3_AW2\\RT\\Normal\\renderer.ini'
    rt_ultra_aw2 = 'mods\\FSR3_AW2\\RT\\Ultra\\renderer.ini'
    var_rt_aw2 = 'mods\\FSR3_AW2\\RT\\Var\\VarRT.txt'
    var_post_processing_aw2 = 'mods\\FSR3_AW2\\Var Post Processing\\VarPost.txt'

    value_remove_pos_processing_aw2 = {   
            "m_bLensDistortion": False,
            "m_bFilmGrain": False,
            "m_bVignette": False
        } 

    if select_mod == 'Others Mods AW2':

        # Anti Stutter
        handle_prompt(
            'Anti Stutter',
            'Do you want to install the Anti Stutter?',
            lambda _: (runReg(anti_stutter_aw2),
            copy_if_exists(var_anti_sttuter_aw2, select_folder,r'Path not found. The path to the Renderer.ini file is something like this: C:\\Users\\USER_NAME\\AppData\Local\\Remedy\\AlanWake2',False))
        )

        # Realistic AW2
        handle_prompt(
            'Preset',
            'Do you want to install the Realistic preset? ReShade is required for the mod to work. See the guide for installation instructions.\nif you are going to use the FSR3 FG mod, it is recommended to install the preset first.',
            lambda _: (shutil.copy(preset_aw2, select_folder),
            os.rename(os.path.join(select_folder, 'dxgi.dll'), os.path.join(select_folder, 'D3D12.dll')) if os.path.exists(os.path.join(select_folder, 'dxgi.dll')) and not os.path.exists(os.path.join(select_folder, 'D3D12.dll')) else None) # Rename the dxgi file so that the FG mods work

        )
        
        # Control RT
        if os.path.exists(path_iniaw2):  
            handle_prompt(
                'RT',
                'Do you want to unlock Ray Tracing from the game Control in Alan Wake 2? If you want to install Ultra Ray Tracing, just select "No" and then select "Yes" in the next window (This is the Standard version)',
                lambda _: (shutil.copy(path_iniaw2, path_backup_ini_aw2),
                           shutil.copy(var_rt_aw2,select_folder),
                           shutil.copy(rt_normal_aw2,path_folder_ini_aw2))
            )
            handle_prompt(
                'RT',
                'Do you want to install Ultra Ray Tracing from the game Control in Alan Wake 2?',
                lambda _: (shutil.copy(rt_ultra_aw2,path_folder_ini_aw2),
                           shutil.copy(var_rt_aw2,select_folder),
                           shutil.copy(path_iniaw2, path_backup_ini_aw2) if not os.path.exists(os.path.join(path_backup_ini_aw2, 'renderer.ini')) else None)
            )
        else:
            messagebox.showinfo('Not found','If you want to install Ray Tracing from the game Control for Alan Wake 2, please check if the path C:\\Users\\USER_NAME\\AppData\\Local\\Remedy\\AlanWake2 exists and try again.')

    if select_mod == 'Alan Wake 2 FG RTX':
        shutil.copytree(path_rtx,select_folder,dirs_exist_ok=True)
        shutil.copy2(path_dlss,select_folder)
    
    elif select_mod  == 'Alan Wake 2 Uniscaler Custom':
        shutil.copytree(path_amd,select_folder,dirs_exist_ok=True)

    if messagebox.askyesno('Fix Ghosting Aw2','Do you want to fix possible ghosting issues caused by the FSR3 mod?'):       
        config_json(path_iniaw2,value_remove_pos_processing_aw2,"'Path not found, the path to the renderer.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\Remedy\\AlanWake2. Would you like to select the path manually?'",'Post-processing effects successfully removed')
        shutil.copy(var_post_processing_aw2, select_folder)
        
        if not os.path.exists(os.path.join(path_backup_ini_aw2, 'renderer.ini')):
            shutil.copy(path_iniaw2, path_backup_ini_aw2)

def fsr3_motogp():
    if select_option == 'MOTO GP 24':
        path_uni = os.path.join(select_folder,'uniscaler')
        
        if os.path.exists(path_uni):
            shutil.rmtree(path_uni)

def fsr3_got():
    path_dlss_got = 'mods\\FSR3_GOT\\DLSS FG'
    got_reg = "mods\\FSR3_GOT\\DLSS FG\\DisableNvidiaSignatureChecks.reg"
    post_processing_got_folder = 'mods\\FSR3_GOT\\Remove_Post_Processing'
    path_var_post_processing_got = 'mods\\FSR3_GOT\\Remove_Post_Processing\\no-filmgrain.reg'
    
    if select_option == 'Ghost of Tsushima':
        shutil.copytree(path_dlss_got,select_folder,dirs_exist_ok=True)
        
        runReg(got_reg)
    
    remove_post_processing_got = messagebox.askyesno('Remove Post Processing','Would you like to remove the post-processing effects? (Film grain, Mouse Smoothing, etc.)')
    
    try:
        
        if remove_post_processing_got:
            for file_post in os.listdir(post_processing_got_folder):
                if file_post.endswith('.reg'):
                    reg_got_path = os.path.join(post_processing_got_folder,file_post)
                    subprocess.run(['reg','import',reg_got_path],check=True)
            
            shutil.copy2(path_var_post_processing_got,select_folder)
            
    except Exception as e:
        messagebox.showinfo('Error','It was not possible to remove the post-processing effects.')
    
def fsr3_the_medium():
    shortcut_medium_path = os.path.join(select_folder,'Medium-Win64-Shipping.exe')
    new_target_path = ('The Medium') 
    dx_12 = "-dx12"
    game_name = 'The Medium'
    if select_option == 'The Medium':
        auto_shortcut(shortcut_medium_path,new_target_path,dx_12,game_name) 

def fsr3_ac_valhalla():
    path_dlss = 'mods\\Ac_Valhalla_DLSS'
    path_dlss2 = 'mods\\Ac_Valhalla_DLSS2'
    
    if select_mod == "Ac Valhalla DLSS3 (Only RTX)":
        shutil.copytree(path_dlss,select_folder,dirs_exist_ok=True)
    elif  select_mod == "Ac Valhalla FSR3 All GPU":
        shutil.copytree(path_dlss2,select_folder,dirs_exist_ok=True)

def fsr3_ffvxi():
    ffvxi_fix = 'mods\\FSR3_FFVXI\\FFXVIFix'
    ffvxi_anti_stutter = 'mods\\FSR3_FFVXI\\Anti Stutter\\Final Fantasy XVI High Priority Processes-7-2-1726663253\\Install Final Fantasy XVI High Priority Processes.reg'
    ffvxi_var_anti_stutter = 'mods\\FSR3_FFVXI\\Anti Stutter\\Anti_Stutter.txt'
    ffvxi_preset = 'mods\\FSR3_FFVXI\\ReShade'

    if select_mod == 'FFXVI DLSS RTX':
        dlss_to_fsr()
    
    if not os.path.exists(os.path.join(select_folder,'d3d12.dll')):
        Backup_Dxgi('d3d12.dll',select_folder + '\\dxgi.dll')

    if select_mod == 'Others Mods FFXVI':
        if os.path.exists(os.path.join(select_folder,'ffxvi.exe')):

            if messagebox.askyesno('FFVI FIX','Do you want to install the fixes mod? (It unlocks FPS in cutscenes, adds ultrawide support, etc. See all fixes in the FSR Guide)'):
                shutil.copytree(ffvxi_fix,select_folder,dirs_exist_ok=True)
            
            if messagebox.askyesno('Anti Stutter','Do you want to install the Anti Stutter?'):
                runReg(ffvxi_anti_stutter)
                shutil.copy(ffvxi_var_anti_stutter,select_folder)
            
            if messagebox.askyesno('Graphics Preset','Do you want to install the Graphics Preset?'):
                shutil.copytree(ffvxi_preset,select_folder,dirs_exist_ok=True)
                messagebox.showinfo('FSR Guide','Check the FINAL FANTASY XVI guide on FSR Guide to complete the installation. (If you do not follow the steps in the guide, the mod will not work).')
        else:
            messagebox.showinfo('Path Not Found','If you want to install the other mods (Anti Stutterr, Graphic Preset, etc.), select the path to the .exe, something like: FINAL FANTASY XVI\\ffxvi.exe')

def fsr3_gow_rag():
    gow_rag_anti_stutter = 'mods\\FSR3_GOW_RAG\\God of War Ragnarök\\Anti-Stutter GoW Ragnarok\\Install GoWR High CPU Priority.reg'
    gow_reg_anti_stutter_var = 'mods\\FSR3_GOW_RAG\\God of War Ragnarök\\Anti-Stutter GoW Ragnarok\\Anti_Stutter.txt'
    gow_rag_preset = 'mods\\FSR3_GOW_RAG\\God of War Ragnarök\\ReShade\\God of War Ragnarök.ini'
    gow_rag_intro_skip = 'mods\\FSR3_GOW_RAG\\God of War Ragnarök\\Intro Skip'
    gow_reg_1060_3050 = 'mods\\FSR3_GOW_RAG\\God of War Ragnarök\\Unlock Vram\\GTX 1060 3050 6GB\\dxgi.dll'
    gow_reg_vram_6gb = 'mods\\FSR3_GOW_RAG\\God of War Ragnarök\\Unlock Vram\\6GB VRAM\\dxgi.dll'
    gow_reg_var_vram = 'mods\\FSR3_GOW_RAG\\God of War Ragnarök\\Unlock Vram\\Vram.txt'
    gow_rag_nvapi = 'mods\\Addons_mods\\Nvapi AMD'

    if select_mod == 'Others Mods Gow Rag':
        update_upscalers(select_folder)

        if os.path.exists(os.path.join(select_folder,'exec')):
            if messagebox.askyesno('Anti Stutter','Dou you want to install the Anti Stutter?'):
                runReg(gow_rag_anti_stutter)
                shutil.copy(gow_reg_anti_stutter_var,select_folder)
        
            if messagebox.askyesno('Reshade','Do you want to install the Graphics Preset?'):
                shutil.copy(gow_rag_preset,select_folder)
                messagebox.showinfo('FSR Guide','Check the God of War Ragnarök guide on FSR Guide to complete the installation. (If you do not follow the steps in the guide, the mod will not work).')

            if messagebox.askyesno('Intro Skip','Do you want to install the Intro Skip?'):
                shutil.copytree(gow_rag_intro_skip,select_folder,dirs_exist_ok=True)
            
            if messagebox.askyesno('Unlock Vram','Do you want to install the Unlock Vram?'):
                if messagebox.askyesno('VRAM','Do you have a 3050 or 1060 GPU?. If the game doesn\'t work, select the opposite option (if you selected \'yes\' the first time, select \'no\' so a different file will be installed)'):
                    shutil.copy(gow_reg_1060_3050,select_folder)
                else:
                    shutil.copy(gow_reg_vram_6gb,select_folder)  

                shutil.copy(gow_reg_var_vram,select_folder)  
        else:
            messagebox.showinfo('Path Not Found','If you want to install the other mods (Anti Stutterr, Graphic Preset, etc.), select the path to the .exe, something like: God of War Ragnarök\\GoWR.exe')

def fsr3_space_marine():
    anti_stutter_marine = 'mods\\FSR3_Outlaws\\Anti_Stutter\\Install Star Wars Outlaws CPU Priority.reg'
    txt_marine_stutter = 'mods\\FSR3_SpaceMarine\\Anti_Stutter\\Marine_Anti_Stutter.txt'
    preset_marine = 'mods\\FSR3_SpaceMarine\\Preset\\Warhammer 40000 Space Marine 2.ini'
    path_dxgi = select_folder + '\\dxgi.dll'

    if select_mod == 'FSR 3.1.3/DLSS FG Marine':
        global_dlss()

    if os.path.exists(path_dxgi):
        backup_folder_marine = os.path.join(select_folder, 'Backup_DXGI')
        os.makedirs(backup_folder_marine, exist_ok=True)

        shutil.copy(path_dxgi, backup_folder_marine)  

        os.rename(path_dxgi, os.path.join(select_folder, 'd3d12.dll'))

    if select_mod == 'Others Mods Space Marine':
        update_upscalers(select_folder, False, False, False, True)

        if messagebox.askyesno('Anti Stutter','Do you want to install the Anti Stutter?'):
            runReg(anti_stutter_marine)
            shutil.copy(txt_marine_stutter,select_folder)
        
        if messagebox.askyesno('Graphic Preset','Do you have to install the Graphic Preset?, select the path similar to: client_pc\\root\\bin\\pc for the mod to work. (It is necessary to install ReShade for the preset to work. See the guide in the FSR Guide to learn how to install it.)'):
            shutil.copy(preset_marine,select_folder)

def fsr3_outlaws():
    outlaws_reg = "mods\\FSR3_Outlaws\\Anti_Stutter\\Install Star Wars Outlaws CPU Priority.reg"
    graphics_preset_outlaws = 'mods\\FSR3_Outlaws\\Preset\\Outlaws2.ini'
    var_stutter_outlaws = 'mods\\FSR3_Outlaws\\Anti_Stutter\\Anti_Sttuter.txt'

    if select_mod == 'Outlaws DLSS RTX':
        dlss_to_fsr()
    
    anti_stutter_outlaws = messagebox.askyesno('Anti Stutter','Do you want to install the anti-stutter?')

    if anti_stutter_outlaws:
        shutil.copy(var_stutter_outlaws,select_folder) #File used to remove the Anti-Stutter in 'Cleanup Mod'
        runReg(outlaws_reg)
    
    preset_outlaws = messagebox.askyesno('Graphics Preset','Do you want to install he Graphics Preset?')

    if preset_outlaws:
        shutil.copy(graphics_preset_outlaws,select_folder)

        messagebox.showinfo('FSR Guide','To apply the graphics preset, see the Star Wars Outlaws guide in the FSR Guide.')
        

def handle_prompt(window_title, window_message,action_func=None):
    user_choice = messagebox.askyesno(window_title, window_message)
    
    if user_choice and action_func:
        action_func(user_choice)

    return user_choice

def copy_if_exists(folder_path, dest_path,message,dirs_exist = True):
    try:
        if os.path.exists(dest_path):
            if dirs_exist:
                shutil.copytree(folder_path, dest_path, dirs_exist_ok=True)
            else:
                shutil.copy(folder_path, dest_path)
        else:
             messagebox.showinfo('Not Found', message)
    except Exception as e:
        messagebox.showinfo('Error','It was not possible to complete the installation, please restart the Utility and try again.')
        print(e)

def wukong_fsr3():
    wukong_stutter_reg =  r"mods\\FSR3_WUKONG\\HIGH CPU Priority\\Install Black Myth Wukong High Priority Processes.reg"
    wukong_file_optimized = r'mods\\FSR3_WUKONG\\BMWK\\BMWK - SPF'
    wukong_graphic_preset = r'mods\\FSR3_WUKONG\\Graphic Preset'
    wukong_ue4_map = r"mods\\FSR3_WUKONG\\Map\\WukongUE4SS"
    wukong_map = r"mods\\FSR3_WUKONG\\Map\\b1"
    wukong_hdr = r"mods\\FSR3_WUKONG\\HDR"
    full_path_wukong = os.path.abspath(os.path.join(select_folder, '..\\..\\..'))
    path_fsr31_wukong = 'mods\\FSR3_WUKONG\\WukongFSR31\\FSR31_Wukong'
    cache_wukong = os.path.join(os.getenv('USERPROFILE'), 'AppData')
    message_not_found_wukong = 'Please select the .exe path in "Select Folder". The path should look something like this: BlackMythWukong\\b1\\Binaries\\Win64'
    
    if select_mod == 'DLSS FG (ALL GPUs) Wukong':
        dlss_to_fsr()

    if select_mod == 'FSR 3.1 Custom Wukong':
        shutil.copytree(path_fsr31_wukong,select_folder,dirs_exist_ok=True)

    if select_mod  == 'FSR 3.1.1/DLSS Optiscaler':
        if os.path.exists(cache_wukong + '\\Local\\b1\\Saved\\D3DDriverByteCodeBlob_V4098_D5686_S372641794_R220.ushaderprecache'):

            if messagebox.askyesno('Cache','Do you want to clear the game cache? (it may prevent possible texture errors caused by the mod)'):
                os.remove(cache_wukong + '\\Local\\b1\\Saved\\D3DDriverByteCodeBlob_V4098_D5686_S372641794_R220.ushaderprecache')

    if select_mod == 'Others Mods Wukong':
        if os.path.exists(os.path.join(full_path_wukong, 'Engine\\Plugins\\Runtime\\Nvidia\\DLSS\\Binaries\\ThirdParty\\Win64')):
            update_upscalers(os.path.join(full_path_wukong, 'Engine\\Plugins\\Runtime\\Nvidia\\DLSS\\Binaries\\ThirdParty\\Win64'), False, False, True)
        else:
            messagebox.showinfo('DLSS','To update DLSS, select the path to the .exe (BlackMythWukong\\b1\\Binaries\\Win64).')

        if os.path.exists(os.path.join(full_path_wukong + "\\b1\\Binaries\\Win64")):

            wukong_optimized = messagebox.askyesno('Optimized Wukong','Do you want to install the optimization mod? (Faster Loading Times, Optimized CPU and GPU Utilization, etc. To check the other optimizations, see the guide in FSR Guide).')
            if wukong_optimized:
                full_path_optimized = os.path.abspath(os.path.join(select_folder,'..\\..\\Content\\Paks'))
                if os.path.exists(full_path_optimized):
                    if not os.path.exists(full_path_optimized + "\\~mods"):
                        os.makedirs(full_path_optimized + "\\~mods")

                    shutil.copytree(wukong_file_optimized,full_path_optimized + "\\~mods",dirs_exist_ok=True)
        
            handle_prompt(
            'High CPU Priority',
            'Do you want to enable Anti-Stutter - High CPU Priority? (prevents possible stuttering in the game)',
            lambda _: (
                runReg(wukong_stutter_reg),
                shutil.copy(r'mods\\FSR3_WUKONG\\HIGH CPU Priority\\Anti-Stutter - Utility.txt', select_folder)
                )
            )

            handle_prompt(
                'Graphic Preset',
                'Do you want to apply the Graphics Preset? (ReShade must be installed for the preset to work, check the guide in FSR Guide for more information)',
                lambda _: copy_if_exists(wukong_graphic_preset, full_path_wukong + "\\b1",message_not_found_wukong)
            )

            view_message_wukong = handle_prompt(
                'Mini Map',
                'Would you like to install the mini map?',
                lambda _:(
                    copy_if_exists(wukong_ue4_map,select_folder,message_not_found_wukong),
                    copy_if_exists(wukong_map,full_path_wukong + "\\b1",message_not_found_wukong),
                )
            )

            view_message_wukong = handle_prompt(
                'HDR',
                'Would you like to install the HDR correction?',
                lambda _: copy_if_exists(wukong_hdr,full_path_wukong,message_not_found_wukong,message_not_found_wukong)
            )

            if view_message_wukong or wukong_optimized:
                messagebox.showinfo('Success', 'Preset applied successfully. To complete the installation, go to the game\'s page in your Steam library, click the gear icon \'Manage\' to the right of \'Achievements\', select \'Properties\', and in \'Launch Options\', enter -fileopenlog.')
        else:
            messagebox.showinfo('Not Found','If you want to install the other mods (Mini Map, Graphic Preset, etc.), select the path to the .exe, something like: BlackMythWukong\\b1\\Binaries\\Win64')

# Modify the ini file to remove post-processing effects
def Remove_ini_effect(key_ini, value_ini, path_ini, message_path_not_found, message_hb2 = None):
    global select_folder
    
    if not os.path.exists(path_ini):
        messagebox.showinfo('Path Not Found', message_path_not_found)
        return

    if select_option == 'Hellblade 2':
        select_folder = os.path.dirname(path_ini)
        game_folder_canvas.delete('text')
        game_folder_canvas.create_text(2, 8, anchor='w', text=select_folder, fill='black', tags='text')

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
        updated = False
        
        for key, new_value in value_ini.items():
            for idx, line in enumerate(updated_section):
                if line.startswith(f"{key}="):
                    updated_section[idx] = f"{key}={new_value}\n"
                    updated = True
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

def config_json(path_json, values_json,path_not_found_message,ini_message=None):

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
    
def remove_post_processing_effects_hell2():
    path_inihb2 = os.getenv("LOCALAPPDATA") + '\\Hellblade2\\Saved\\Config\\Windows\\Engine.ini'
    alt_path_hb2 = os.getenv("LOCALAPPDATA") + '\\Hellblade2\\Saved\\Config\\WinGDK\\Engine.ini'
    
    value_remove_black_bars = {'r.NT.EnableConstrainAspectRatio' :'0'}
    value_remove_black_bars_alt = {
                'r.NT.AllowAspectRatioHorizontalExtension': '0',
                'r.NT.EnableConstrainAspectRatio': '0'
            }
    value_remove_pos_processing = {   
                'r.NT.Lens.Distortion.Intensity':'0',
                'r.NT.Lens.Distortion.Stretch':'0', 
                'r.NT.Lens.ChromaticAberration.Intensity':'0',
                'r.NT.AllowAspectRatioHorizontalExtension':'0',
                'r.NT.EnableConstrainAspectRatio':'0'
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
    
    elif select_folder is None: 
        messagebox.showinfo('Path Not Found','Path not found, please select manually. The path to the Engine.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\Hellblade2\\Saved\\Config\\Windows or WinGDK and then select the option again. If you need further instructions, refer to the Hellblade 2 FSR Guide') 
        return
    else:
        manually_folder_ini = os.path.join(select_folder,'Engine.ini')
        if os.path.exists(manually_folder_ini):
            path_final = manually_folder_ini
    
    if path_final != "":

        # Remove Black Bars   
        handle_prompt(
        'Remove Black Bars',
        'Do you want to remove the Black Bars?',
        lambda _: (
            Remove_ini_effect(key_remove_post_processing,value_remove_black_bars,path_final,message_path_not_found_hb2) 
            )
        )

        # Remove Black Bars Alt
        handle_prompt(
        'Remove Black Bars Alt',
        'Do you want to remove the Black Bars? Select this option if the previous option did not work, the removal of the black bars will be\nautomatically performed if the Engine.ini file is found. If it is not found, you need to select the path\nin \'Select Folder\' and press \'Install\'.\n\n',
        lambda _: (
                Remove_ini_effect(key_remove_post_processing,value_remove_black_bars_alt,path_final,message_path_not_found_hb2)  
            )
        )    

        # Remove Post Processing Effects
        handle_prompt(
        'Remove Post Processing Effects',
        'Do you want to remove the main post-processing effects? (Lens Distortion, Black Bars, and Chromatic Aberration will be removed). If you want to remove all post-processing effects, select "No" and then select "Yes" in the next window.',
        lambda _: (
                Remove_ini_effect(key_remove_post_processing,value_remove_black_bars_alt,path_final,message_path_not_found_hb2)  
            )
        )   

        # Remove All Post Processing Effects
        handle_prompt(
        'Remove All Post Processing Effects',
        'Do you want to remove all post-processing effects?',
        lambda _: (
                Remove_ini_effect(key_remove_post_processing,value_remove_all_pos_processing,path_final,message_path_not_found_hb2) 
            )
        )   

        handle_prompt(
        'Restore Post Processing',
        'Do you want to revert to the post-processing options? (Black bars, film grain, etc.)',
        lambda _: (
            path_replace_ini := 'mods\\FSR3_HB2\\Replace_ini\\Engine.ini',

            os.path.exists(os.path.join(path_inihb2)) and shutil.copy2(path_replace_ini, path_inihb2) or
            os.path.exists(os.path.join(alt_path_hb2)) and shutil.copy2(path_replace_ini, alt_path_hb2) or
            select_folder is None or (
                replace_ini_path := os.path.join(select_folder, 'Engine.ini'),
                os.path.exists(replace_ini_path) and shutil.copy2(path_replace_ini, os.path.dirname(replace_ini_path))
                )
            )
        )
    else:
        messagebox.showinfo('Not Found', 'Engine.ini not found, please check if it exists. The path is something like C:\\Users\\YourName\\AppData\\Local\\Hellblade2\\Saved\\Config\\Windows or WinGDK. If it\'s not there, open the game to have the file created.')
                    
def fsr3_hellblade_2():
    global select_folder
    path_dlss_hb2 = 'mods\\FSR3_GOT\\DLSS FG'
    hb2_reg = "mods\\FSR3_GOT\\DLSS FG\\DisableNvidiaSignatureChecks.reg"
    fix_dlss_hb2 = 'mods\\FSR3_HB2\\Fix_rtx_gtx'
    cpu_reg = "mods\\FSR3_HB2\\Cpu_Hb2\\Install Hellblade 2 CPU Priority.reg"
    
    if select_mod == 'Hellblade 2 FSR3 (Only RTX)':
        shutil.copytree(path_dlss_hb2,select_folder,dirs_exist_ok=True)
        runReg(hb2_reg)
    
    if select_mod == 'Others Mods HB2':
        remove_post_processing_effects_hell2()
    
        # Anti Stutter
        handle_prompt(
        'High CPU Priority',
        'Do you want to install Anti Stutter? (prevents possible stuttering in the game)',
        lambda _: (
            runReg(cpu_reg),
            shutil.copy2("mods\\FSR3_HB2\\Cpu_Hb2\\Install Hellblade 2 CPU Priority.reg",select_folder)
            )
        )

def fsr3_silent2():
    root_path_sh2 = os.path.abspath(os.path.join(select_folder, '..\\..\\..'))
    mods_path = 'mods\\FSR3_SH2'
    rtx_fg_sh2 = 'mods\\FSR3_SH2\\RTX_FG'
    preset_sh2 = 'mods\\FSR3_SH2\\Preset\\Silent hill dark.ini'
    path_ultra_plus_optimized = 'mods\\FSR3_SH2\\Ultra Plus\\Optimized'
    path_ultra_plus_complete = 'mods\\FSR3_SH2\\Ultra Plus\\normal'
    path_engine_ultra_plus = 'mods\\FSR3_SH2\\Ultra Plus\\Engine.ini'
    path_fsr3_fg_optimized = 'mods\\FSR3_SH2\\FSR3 Native Optimized\\Engine.ini'
    ray_reconstruction_dll_sh2 = f'{mods_path}\\RayReconstruction\\nvngx_dlssd.dll'
    ray_reconstruction_ini_sh2 = f'{mods_path}\\RayReconstruction\\Engine.ini'
    intro_skip_sh2 = f'{mods_path}\\Intro_Skip'
    fsr31_custom_rtx_sh2 = 'mods\\DLSS_Global\\RTX_Custom'
    dx12_dll_sh2 = 'mods\\FSR3_SH2\\DX12DLL\\D3D12.dll'
    anti_stutter_sh2 = f'{mods_path}\\Anti_Stutter\\Install Silent Hill 2 Remake High Priority Processes.reg'
    var_anti_stutter_sh2 = 'mods\\FSR3_SH2\\Anti_Stutter\\AntiStutter.txt'
    unlock_cutscene_fps_sh2 = f'{mods_path}\\Unlock Cutscene Fps'
    var_native_fsr3_sh2 = f'{mods_path}\\Var\\nativeFSR3.txt'
    var_native_fsr3_opt_sh2 = 'mods\\FSR3_SH2\\FSR3 Native Optimized\\nativeFSR3Opt.txt'
    var_post_processing_sh2 = f'{mods_path}\\Var\\PostProcessing.txt'
    not_found_message_sh2 = 'Path not found, please select manually. The path to the Engine.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\SilentHill2\\Saved\\Config\\Windows.'
    message_not_found_exe_sh2 = 'Select the .exe path to install the Intro Skip mod, the .exe path is SHProto\\Binaries\\Win64.'
    path_folder_engine_ini_sh2 = os.path.join(os.getenv('LOCALAPPDATA'), 'SilentHill2\\Saved\\Config\\Windows')
    path_engine_ini_sh2 = os.path.join(path_folder_engine_ini_sh2, 'Engine.ini')

    fsr3_sh2_value = {'r.FidelityFX.FI.Enabled': '1'}
    remove_fsr3_sh2_value = {'r.FidelityFX.FI.Enabled': '0'}
    post_processing_sh2 = {
        'r.SceneColorFringe.Max': '0',
        'r.SceneColorFringeQuality': '0',
        'r.motionblurquality': '0',
        'r.Distortion': '0',
        'r.DisableDistortion': '1'
    }

    if select_mod == 'FSR 3.1.1/DLSS FG RTX Custom':
        shutil.copytree(fsr31_custom_rtx_sh2, select_folder, dirs_exist_ok=True)
    
    if select_mod == 'DLSS FG RTX':
        shutil.copytree(rtx_fg_sh2,select_folder,dirs_exist_ok=True)
    
    if select_mod == 'Others Mods Sh2':
        # Anti Stutter
        handle_prompt(
        'High CPU Priority',
        'Do you want to install Anti Stutter? (prevents possible stuttering in the game)',
        lambda _: (
            runReg(anti_stutter_sh2),
            shutil.copy(var_anti_stutter_sh2, select_folder)
            )
        )
        
        # Graphics Preset
        handle_prompt(
        'Graphics Preset',
        'Do you want to install the Graphics Preset? Check the ReShade guide in the Hogwarts Legacy guide to complete the installation (look for the Silent hill dark.ini file after viewing the guide, it will be in the folder selected in the Utility)',
        lambda _: (
            shutil.copy(preset_sh2, select_folder)
            )
        )

        # Intro Skip
        if os.path.exists(os.path.join(root_path_sh2, 'SHProto.exe')):
            handle_prompt(
                'Intro Skip',
                'Do you want to install the intro Skip?',
                lambda _: copy_if_exists(intro_skip_sh2, root_path_sh2,message_not_found_exe_sh2)
            )
        else:
            messagebox.showinfo('Not Found', 'Select the .exe path to install the Intro Skip mod, the .exe path is SHProto\\Binaries\\Win64.')

        # Ray Reconstruction
        dlss_path_sh2 = os.path.join(root_path_sh2, 'SHProto\\Plugins\\DLSS\\Binaries\\ThirdParty\\Win64')
        if os.path.exists(path_engine_ini_sh2):
            handle_prompt(
                'Ray Reconstruction',
                'Do you want to install Ray Reconstruction? It improves the quality of Ray Tracing by removing all graphical glitches in RT. (recommended only for RTX)',
                lambda _: (copy_if_exists(ray_reconstruction_dll_sh2, dlss_path_sh2,message_not_found_exe_sh2,False),
                           copy_if_exists(ray_reconstruction_ini_sh2, path_folder_engine_ini_sh2,message_not_found_exe_sh2,False))
            )
        else:
            messagebox.showinfo('Not Found', f'Exe and .ini not found. Select the .exe path SHProto\\Binaries\\Win64 and check if the Engine.ini file is located in {path_folder_engine_ini_sh2}. If it\'s not there, open the game for a few seconds and try installing again.')

        # Post Processing Effects
        if os.path.exists(path_engine_ini_sh2):
            handle_prompt(
                'Remove Post Processing',
                'Do you want to remove Post Processing Effects, such as Motion Blur, Distortion, etc.?',
                lambda _: (Remove_ini_effect('SystemSettings', post_processing_sh2, path_engine_ini_sh2, not_found_message_sh2,'Post Processing Effects successfully removed'),
                copy_if_exists(var_post_processing_sh2, path_folder_engine_ini_sh2,not_found_message_sh2,False))
            )

            # Unlock Cutscene FPS
            handle_prompt(
                'Unlock Cutscene FPS',
                'Do you want to install the Unlock Cutscene FPS? Select the SHProto\\Binaries\\Win64 path for the mod to work correctly.',
                lambda _: copy_if_exists(unlock_cutscene_fps_sh2,select_folder,message_not_found_exe_sh2)
            )
        else:
            messagebox.showinfo('Not Found', f'Engine.ini file not found. Please check the path {path_engine_ini_sh2} and see if the file exists. If it doesn\'t, open the game for a few seconds and try reinstalling the mod.')

    # FSR 3.1/DLSS Custom / Optiscaler
    if select_mod in ['FSR 3.1.2/DLSS FG Custom', 'FSR 3.1.1/DLSS Optiscaler', 'FSR 3.1.3/DLSS FG (Only Optiscaler)']:
        if os.path.exists(os.path.join(path_folder_engine_ini_sh2, 'NativeFSR3.txt')):
            Remove_ini_effect('SystemSettings', remove_fsr3_sh2_value, path_engine_ini_sh2, not_found_message_sh2,'The Native FSR3 has been removed, it is necessary for the FSR3.1/DLSS mod to work.')      

    # Ultra Plus
    if select_mod in ['Ultra Plus Optimized', 'Ultra Plus Complete']:
        
        if os.path.exists(path_engine_ini_sh2):
            if select_mod == 'Ultra Plus Optimized':
                source_path_sh2 = path_ultra_plus_optimized
            elif select_mod == 'Ultra Plus Complete':
                source_path_sh2 = path_ultra_plus_complete
   
            shutil.copytree(source_path_sh2, root_path_sh2, dirs_exist_ok=True)
            shutil.copy(path_engine_ultra_plus, path_folder_engine_ini_sh2)
            
            messagebox.showinfo('Guide', 'Check the Silent Hill 2 guide to see how to activate Ultra Plus')

    # Native FSR3 FG and Optimized
    if select_mod in ['FSR3 FG Native SH2','FSR3 FG Native SH2 + Optimization']:
        
        if os.path.exists(path_engine_ini_sh2):
            if select_mod == 'FSR3 FG Native SH2':
                Remove_ini_effect('SystemSettings', fsr3_sh2_value, path_engine_ini_sh2, not_found_message_sh2,'FSR3 Frame Generation successfully enabled')
                shutil.copy(var_native_fsr3_sh2, path_folder_engine_ini_sh2)
            else:
                shutil.copy(path_fsr3_fg_optimized,path_folder_engine_ini_sh2)
                shutil.copy(var_native_fsr3_opt_sh2, path_folder_engine_ini_sh2)

            handle_prompt(
                'GPU',
                'Do you have an RX 500/5000 or GTX GPU?',
                lambda _: copy_if_exists(dx12_dll_sh2, select_folder,message_not_found_exe_sh2,False) # The d3d12.dll file is required for the Native FSR3 mod to work on the RX 500/5000 and GTX series
            )
        else:
            messagebox.showinfo('Not Found', f'Engine.ini file not found. Please check the path {path_engine_ini_sh2} and see if the file exists. If it doesn\'t, open the game for a few seconds and try reinstalling the mod.')

def fsr3_until():
    CSIDL_PERSONAL = 5
    path_buffer_ud = ctypes.create_unicode_buffer(260)
    result_doc_ud = ctypes.windll.shell32.SHGetFolderPathW(0, CSIDL_PERSONAL, 0, 0, path_buffer_ud)
    anti_sutter_ud = 'mods\\FSR3_UD\\Anti Stutter\\Install UD High CPU Priority.reg'
    var_anti_stutter_ud = 'mods\\FSR3_SH2\\Anti_Stutter\\AntiStutter.txt'
    var_post_processing_ud = 'mods\\FSR3_SH2\\Var\\PostProcessing.txt'
    not_found_message_ud = 'Path not found. The path to the Engine.ini file is something like this: Documents\\My Games\\Bates\\Saved\\Config\\Windows.'
    remove_depth_field_ud = {'r.DepthOfFieldQuality':'0'}

    if select_mod == 'Others Mods UD':

        # Anti Stutter
        handle_prompt(
            'Anti Stutter',
            'Do you want to install the Anti Stutter?',
            lambda _: (runReg(anti_sutter_ud),
            copy_if_exists(var_anti_stutter_ud, select_folder,not_found_message_ud,False))
        )

        #Post Processing Effects
        if result_doc_ud == 0:
            path_documents_ud = path_buffer_ud.value      
            path_folder_engine_ini_ud = os.path.join(path_documents_ud, 'My Games', 'Bates', 'Saved', 'Config', 'Windows', 'Engine.ini')
            
            if os.path.exists(path_folder_engine_ini_ud):
                handle_prompt(
                        'Disable Depth of Field',
                        'Do you want to disable Depth of Field?',
                        lambda _: (Remove_ini_effect('SystemSettings', remove_depth_field_ud, path_folder_engine_ini_ud, not_found_message_ud,'Depth of field successfully removed'),
                        copy_if_exists(var_post_processing_ud, select_folder, not_found_message_ud,False))
                    )  
            else:
                messagebox.showinfo('Not Found',not_found_message_ud)
        else:
            messagebox('Documents','Documents folder not found, please check if there are permissions for the Utility to access the folder')

def fsr3_hog_legacy():
    hl_preset = 'mods\\FSR3_HL\\Preset\\Hogwarts Legacy Real Life DARKER HOGWARTS Reshade.txt'
    hl_anti_stutter = 'mods\\FSR3_HL\\Anti Stutter\\Install Hogwarts Legacy CPU Priority.reg'
    hl_var_anti_stutter = 'mods\\FSR3_SH2\\Anti_Stutter\\AntiStutter.txt'
    hl_d3d12_dll = 'd3d12.dll'
    hl_d3d12_dll_path = os.path.join(select_folder, hl_d3d12_dll)
    hl_dxgi_dll_path = os.path.join(select_folder,'dxgi.dll')

    if select_mod == 'Others Mods HL':
    
        # Graphics Preset
        if messagebox.askyesno('Graphics Preset',' Do you want to install the Graphics Preset? See the guide to learn how to complete the installation.'):
            shutil.copy(hl_preset,select_folder)
            
            if os.path.exists(hl_dxgi_dll_path):
                shutil.copyfile(hl_dxgi_dll_path, hl_d3d12_dll_path)
                os.rename(hl_dxgi_dll_path, os.path.join(select_folder,'dxgi.txt'))
        
        # Anti Stutter
        handle_prompt(
            'Anti Stutter',
            'Do you want to install the Anti Stutter?',
            lambda _: (runReg(hl_anti_stutter),
            shutil.copy(hl_var_anti_stutter,select_folder))
        )

def fsr3_rdr1():
    anti_stutter_rdr1 = 'mods\\FSR3_RDR1\\Anti Stutter\\RDR_PerformanceBoostENABLE.reg'
    var_anti_stutter_rdr1 = 'mods\\FSR3_SH2\\Anti_Stutter\\AntiStutter.txt'
    texture_rdr1 = 'mods\\FSR3_RDR1\\4x Texture\\vfx.rpf'
    preset_rdr1 = 'mods\\FSR3_RDR1\\Preset\\Red Dead Redemption.ini'
    intro_skip_rdr1 =  'mods\\FSR3_RDR1\\Intro Skip' 
    ds4_buttons_rdr1 = 'mods\\FSR3_RDR1\\DS4'
    unlock_fps_rdr1 = 'mods\\FSR3_RDR1\\Unlock FPS'

    if select_mod in ['FSR 3.1.2/DLSS FG Custom', 'FSR 3.1.1/DLSS Optiscaler', 'FSR 3.1.3/DLSS FG (Only Optiscaler)']:
        
        runReg('mods\\Temp\\NvidiaChecks\\DisableNvidiaSignatureChecks.reg')

        if messagebox.askyesno('Enable', 'Do you want to enable Nvidia Signature Checks? Select "Yes" only if the mod does not work'):
            runReg('mods\\Temp\\NvidiaChecks\\RestoreNvidiaSignatureChecks.reg')
    
    if select_mod == 'Others Mods RDR1':

        # Anti Stutter
        handle_prompt(
            'Anti Stutter',
            'Do you want to install the Anti Stutter?',
            lambda _: (runReg(anti_stutter_rdr1),
            shutil.copy(var_anti_stutter_rdr1,select_folder))
        )

        # 4x Texture
        handle_prompt(
            '4x Texture',
            'Do you want to install the 4x Texture? Improves the texture to 4x its resolution.',
            lambda _: (os.rename(os.path.join(select_folder, 'game\\vfx.rpf'), os.path.join(select_folder, 'game\\vfx.txt')) if os.path.exists(os.path.join(select_folder, 'game\\vfx.rpf')) else None) or copy_if_exists(texture_rdr1, os.path.join(select_folder, 'game'), 'Folder not found. Select the correct path if you want to install the 4x texture mod. The path is similar to common\\Red Dead Redemption.', False) # Create a backup of the vfx.rpf file and copy the vfx.rpf from the mod.
        )

        # Preset
        handle_prompt(
            'Preset',
            'Do you want to install the Graphics Preset? ReShade is required to complete the mod installation. See the guide for instructions on how to install it.',
            lambda _: (shutil.copy(preset_rdr1, select_folder))
        )

        # Unlock FPS
        handle_prompt(
                'Unlock FPS',
                'Do you want to install the Unlock FPS?',
                lambda _: (shutil.copytree(unlock_fps_rdr1, select_folder,dirs_exist_ok=True))
            )

        if os.path.exists(os.path.join(select_folder, 'game')):
            # Intro Skip
            handle_prompt(
                'Intro Skip',
                'Do you want to install the Intro Skip?',
                lambda _: (shutil.copytree(intro_skip_rdr1, select_folder,dirs_exist_ok=True))
            )

            # DS4 Buttons
            handle_prompt(
                'DS4 Buttons',
                'Would you like to install DS4 Buttons? It changes the in-game buttons to DualShock 4 buttons.',
                lambda _: (shutil.copytree(ds4_buttons_rdr1, select_folder,dirs_exist_ok=True))
            )
        else:
            messagebox.showinfo('Not Found', 'To install the other mods (Intro Skip and DS4 Buttons), select the correct path to the .exe file, and look for the .exe in the path "Red Dead Redemption\\RDR.exe".')

def fsr3_stalker():
    root_folder_stalker = os.path.abspath(os.path.join(select_folder, '..\\..'))
    anti_stutter_stalker = 'mods\\FSR3_Stalker2\\Anti Stutter'
    preset_stalker = 'mods\\FSR3_Stalker2\\Preset'
    update_upscalers_stalker = 'mods\\FSR3_Stalker2\\Update_Upscalers'
    dlss_fg_stalker = 'mods\\FSR3_Stalker2\\FG DLSS'

    if select_mod == 'Others Mods Stalker 2':
        if os.path.exists(os.path.join(root_folder_stalker, 'Content\\Paks')):
            # Anti Stutter
            try:
                handle_prompt(
                    'Anti Stutter',
                    'Do you want to install the Anti Stutter?',
                    lambda _: (
                        os.makedirs(os.path.join(root_folder_stalker, 'Content\\Paks\\~mods'), exist_ok=True),
                        shutil.copytree(anti_stutter_stalker, os.path.join(root_folder_stalker, 'Content\\Paks\\~mods'), dirs_exist_ok=True)
                    )
                )
            except Exception as e:
                print(e)
        else:
            messagebox.showinfo('Not Found', 'To install the Anti Stutter, select the path to the .exe file. The path looks like Stalker2\\Binaries\\Win64".')

        # Preset
        handle_prompt(
            'Preset',
            'Do you want to install the Graphics Preset? Check the guide in FSR Guide to see how to perform the complete installation',
            lambda _: (shutil.copytree(preset_stalker, select_folder,dirs_exist_ok=True))
        )

        # Update Upscalers
        handle_prompt(
            'Update',
            'Do you want to update the upscalers? The latest version of all upscalers will be installed',
            lambda _: (shutil.copytree(update_upscalers_stalker, select_folder,dirs_exist_ok=True))
        )
    
    if select_mod == 'DLSS FG (Only Nvidia)':
        shutil.copytree(dlss_fg_stalker, select_folder)
        runReg('mods\\Temp\\NvidiaChecks\\DisableNvidiaSignatureChecks.reg')

def fsr3_drr():
    dlss_to_fg_drr = 'mods\\FSR3_DRR\\FSR3FG\\Dlss_to_Fsr'
    dinput_drr = 'mods\\FSR3_DRR\\FSR3FG\\Dinput'
    dlss_drr = 'mods\\Temp\\nvngx_global\\nvngx\\Dlss\\nvngx_dlss.dll'

    if select_mod == 'Dinput8 DRR':
        shutil.copytree(dinput_drr, select_folder, dirs_exist_ok=True)

    if select_mod == 'FSR 3.1 FG DRR':
        if os.path.exists(os.path.join(select_folder,'reframework\\plugins')) and os.path.exists(os.path.join(select_folder,'dinput8.dll')):
            shutil.copytree(dlss_to_fg_drr, os.path.join(select_folder,'reframework\\plugins'), dirs_exist_ok=True)
            shutil.copy(dlss_drr, select_folder)

        else:
            messagebox.showinfo('Not Found', 'First, install the "Dinput8 DRR" before installing the main mod. See the DRR guide in the FSR Guide to learn how to install the mod.')
            return False
    return True

def fsr3_di2():
    path_tcp_di2 = 'mods\\FSR3_DI2\\TCP'

    if select_mod == 'FSR 3.1.3/DLSS FG (Only Optiscaler)':
        shutil.copytree(path_tcp_di2, select_folder, dirs_exist_ok=True)

        runReg('mods\\FSR3_DI2\\TCP\\EnableNvidiaSigOverride.reg')

def fsr3_re4():
    fsr_dlss_re4 = 'mods\\FSR3_RE4Remake\\FSR_DLSS'

    if select_mod == 'FSR 3.1.3/DLSS RE4':
        shutil.copytree(fsr_dlss_re4, select_folder, dirs_exist_ok=True)

        # Enable DLSS Overlay
        dlss_overlay()

def fsr3_sskjl():
    root_path_sskjl = os.path.abspath(os.path.join(select_folder, '..\\..\\..'))
    path_dxgi_sskjl = os.path.join(select_folder, 'dxgi.dll')
    path_nvngx_sskjl = os.path.join(select_folder, 'nvngx.dll')
    path_folder_dlss_sskjl = os.path.join(root_path_sskjl, 'Engine\\Plugins\\Runtime\\Nvidia\\DLSS\\Binaries\\ThirdParty\\Win64')
    path_disable_eac = 'mods\\FSR3_SSKJL\\Disable_EAC\\EAC Bypass'
    gpu_name = get_active_gpu()

    try:
        if select_mod == 'Others Mods SSKJL':
            if os.path.exists(path_folder_dlss_sskjl):
                update_upscalers(path_folder_dlss_sskjl, True)
            else:
                messagebox.showinfo('DLSS', 'To update DLSS, select the path to the .exe (Stones\\Binaries\\Win64).')
        
        if select_mod == 'FSR 3.1.3/DLSS FG (Only Optiscaler)':
            if os.path.exists(path_dxgi_sskjl):
                os.replace(path_dxgi_sskjl, os.path.join(select_folder, 'winmm.dll')) ## Necessary to rename the file so it won't be replaced by the Disable EAC files.

            if os.path.exists(path_nvngx_sskjl) and 'rtx' in gpu_name:
                os.remove(path_nvngx_sskjl)

                ## Backup EAC
                if os.path.exists(os.path.join(root_path_sskjl,'EasyAntiCheat')):
                    shutil.copytree(os.path.join(root_path_sskjl,'EasyAntiCheat'), os.path.join(root_path_sskjl, 'Backup EAC\\EasyAntiCheat'), dirs_exist_ok=True)
                    shutil.copy(os.path.join(root_path_sskjl, 'start_protected_game.exe'), os.path.join(root_path_sskjl, 'Backup EAC'))

            ## Disable EAC
            shutil.copytree(path_disable_eac, root_path_sskjl, dirs_exist_ok=True)
    except Exception as e:
        print(e)

def fsr3_ac_mirage():
    intro_skip_ac_mirage = 'mods\\FSR3_Ac_Mirage\\Intro_skip'
    preset_ac_mirage = 'mods\\FSR3_Ac_Mirage\\ReShade\\ACMirage lighting and package.ini'
    
    if select_mod == 'Others Mods Mirage':
        if os.path.exists(os.path.join(select_folder,'videos')):
            try:
                # Intro Skip
                handle_prompt(
                    'Intro Skip',
                    'Do you want to install the Intro Skip?',
                    lambda _: (
                        os.makedirs(os.path.join(select_folder, "Backup Ac Mirage"), exist_ok=True),
                        shutil.copytree(os.path.join(select_folder, "videos"), os.path.join(select_folder, "Backup Ac Mirage"), dirs_exist_ok=True),
                        shutil.copytree(intro_skip_ac_mirage, select_folder, dirs_exist_ok=True)
                    )
                )

                # Preset
                handle_prompt(
                    'Graphics Preset',
                    'Do you want to install the Graphics Preset?',
                    lambda _: (shutil.copy(preset_ac_mirage, select_folder),
                    messagebox.showinfo('Guide', 'See the game guide in FSR Guide to see how to complete the installation of the Preset'))
                )
            except Exception as e:
                print(e)
        else:
            messagebox.showinfo('Not Found','If you want to install the Intro Skip, select the game\'s .exe folder')

def fsr3_lego_horizon():
    intro_skip_lego_hzd = 'mods\\FSR3_Lego_HZD\\Intro_Skip'
    root_path_lego_hzd = os.path.abspath(os.path.join(select_folder,'..\\..\\..'))

    if select_mod == 'Others Mods Lego HZD':
        try:
            if os.path.exists(os.path.join(root_path_lego_hzd, 'Glow\\Content\\Movies')):
                handle_prompt(
                            'Intro Skip',
                            'Do you want to install the Intro Skip?',
                            lambda _: (
                                os.makedirs(os.path.join(root_path_lego_hzd, "Backup Lego HZD\\Movies"), exist_ok=True),
                                shutil.copytree(os.path.join(root_path_lego_hzd, "Glow\\Content\\Movies"), os.path.join(root_path_lego_hzd, "Backup Lego HZD\\Movies"), dirs_exist_ok=True),
                                shutil.copytree(intro_skip_lego_hzd, os.path.join(root_path_lego_hzd, "Glow\\Content"), dirs_exist_ok=True)
                            )
                        )
            else:
                messagebox.showinfo('Exe','To install the Intro Skip, select the folder containing the .exe file. The .exe file name is similar to "game name-Win64-Shipping.exe".')
        except Exception as e:
             print(e)

def fsr3_returnal():
    root_path_returnal = os.path.abspath(os.path.join(select_folder, '..\\..\\..'))
    path_default_folder_dlss_returnal = os.path.join(root_path_returnal, 'Engine\\Binaries\\ThirdParty\\NVIDIA\\NGX\\Win64')
    path_default_dlss_returnal = os.path.join(path_default_folder_dlss_returnal, 'nvngx_dlss.dll')
    path_dlss_returnal = 'mods\\Temp\\nvngx_global\\nvngx\\Dlss\\nvngx_dlss.dll'
    path_nvapi_returnal = 'mods\\FSR3_Flight_Simulator24\\Amd'

    try:
        if os.path.exists(path_default_folder_dlss_returnal):
            
            if select_mod == 'FSR 3.1.3/DLSS FG (Only Optiscaler)':
                shutil.copy(os.path.join(path_default_folder_dlss_returnal, 'nvngx_dlss.dll'), os.path.join(select_folder, 'nvngx.dll'))

            if select_mod == 'FSR 3.1.3/DLSS FG (Only Optiscaler)' and messagebox.askyesno('Nvapi', 'Do you want to install nvapi.dll? Select "Yes" only if you are an AMD user and DLSS does not appear in the game after installing the mod.'):
                shutil.copytree(path_nvapi_returnal, select_folder, dirs_exist_ok=True)

        if select_mod == 'Others Mods Returnal':
            if os.path.exists(path_default_folder_dlss_returnal):
                handle_prompt(
                'Update DLSS',
                'Do you want to update DLSS? DLSS 4 will be installed',
                lambda _: (
                    shutil.copy(path_dlss_returnal, path_default_folder_dlss_returnal)
                    )
                )
            else:
                messagebox.showinfo('Exe', 'If you want to install the other Returnal mods, select the .exe folder; it should be something like "Returnal\\Binaries\\Win64".')
    except Exception as e:
        print(e)

def fsr3_indy():
    smooth_reshade_indy = 'mods\\FSR3_Indy\\Others Mods\\Reshade\\Smooth\\TheGreatCircle .ini'
    normal_reshade_indy = 'mods\\FSR3_Indy\\Others Mods\\Reshade\\Normal\\TheGreatCircle smooth.ini'
    intro_skip_indy = 'mods\\FSR3_Indy\\Others Mods\\Intro Skip'
    fg_indy = 'mods\\FSR3_Indy\\FG\\Mod'
    config_file_path_indy = os.path.join(os.environ['USERPROFILE'], 'Saved Games\\MachineGames\\TheGreatCircle\\base')
    config_file_indy = 'mods\\FSR3_Indy\\FG\\Config File\\TheGreatCircleConfig.local'
    old_config_file_indy = os.path.join(config_file_path_indy,'TheGreatCircleConfig.local')

    if select_mod == 'Indy FG (Only RTX)':
        shutil.copytree(fg_indy, select_folder, dirs_exist_ok=True)

        if os.path.exists(old_config_file_indy):
            os.rename(old_config_file_indy, os.path.join(config_file_path_indy,'TheGreatCircleConfig.txt'))
            shutil.copy(config_file_indy, config_file_path_indy)
        else:
            shutil.copy(config_file_indy, select_folder)
            messagebox.showinfo('Not Found','The file TheGreatCircleConfig.local was not found. Please check if it exists (C:\\Users\\YourName\\Saved Games\\MachineGames\\TheGreatCircle\\base). If it doesn\'t exist, open the game to have the file created. You can also manually copy the file to this path. The TheGreatCircleConfig.local file is in the folder selected in the Utility.')

    if select_mod == 'Others Mods Indy':
        
        if os.path.exists(os.path.join(select_folder, 'streamline')):
            update_upscalers(os.path.join(select_folder, 'streamline'),True)
        else:
            messagebox.showinfo('DLSS','If you want to update the DLSS, select the game\'s root folder.')

        # Intro Skip
        handle_prompt(
        'intro Skip',
        'Do you want to install the Intro Skip? Select the root folder of the game, Indiana Jones and the Great Circle.',
        lambda _: (
            shutil.copytree(intro_skip_indy, select_folder, dirs_exist_ok=True)
            )
        )

        # Reshade
        handle_prompt(
        'Smooth',
        'Do you want to install Reshade (this is the smooth version; to install the full version, select "No" and choose "Yes" in the next window)? Check the FSR Guide for the full installation instructions.',
        lambda _: (
            shutil.copy(smooth_reshade_indy, select_folder)
            )
        )

        handle_prompt(
        'Full',
        'Do you want to install the full version Reshade?',
        lambda _: (
            shutil.copy(normal_reshade_indy, select_folder)
            )
        )

def fsr3_quiet_place():
    optiscaler_quiet_place = 'mods\\Addons_mods\\OptiScaler'

    if select_mod == 'FSR 3.1.1/DLSS Quiet Place':
        shutil.copytree(optiscaler_quiet_place, select_folder, dirs_exist_ok=True)
        runReg('mods\\Temp\\enable signature override\\EnableSignatureOverride.reg')

def fsr3_jedi():
    path_uni_jedi = 'mods\\FSR2FSR3_Miles\\Uni_Custom_miles'
    jedi_preset = 'mods\\FSR3_Jedi\\Mods\\Jedi Preset\\STARWAR-ULTRA-REALISTA.ini'
    jedi_fix_rt = 'mods\\FSR3_Jedi\\Mods\\Jedi Fix RT\\pakchunk99-Mods_CustomMod_P.pak'
    jedi_anti_stutter = 'mods\\FSR3_Jedi\\Mods\\Jedi Anti Stutter\\SWJS - FAI\\SWJSFAI.pak'
    jedi_intro_skip = 'mods\\FSR3_Jedi\\Mods\\Jedi Intro Skip\\Content'
    origin_folder_jedi = os.path.abspath(os.path.join(select_folder,'..\\..\\..\\SwGame'))

    if select_mod == 'Dlss Jedi':
        shutil.copytree(path_uni_jedi,select_folder,dirs_exist_ok=True)

    if messagebox.askyesno('Graphics Preset','Do you want to install Graphics Preset?'):
        shutil.copy(jedi_preset,select_folder)
    
    if os.path.exists(origin_folder_jedi + '\\Content\\Paks'):
        if messagebox.askyesno('Fix RT','Do you want to install fix Ray Tracing?'):
            shutil.copy(jedi_fix_rt,origin_folder_jedi + '\\Content\\Paks')
        
        if messagebox.askyesno('Anti Stutter','Do you want to install Anti Stutter?'):
            shutil.copy(jedi_anti_stutter,origin_folder_jedi + '\\Content\\Paks')
    
        if messagebox.askyesno('Intro Skip','Do you want to skip the game\'s initial intro?'):
            shutil.copytree(jedi_intro_skip,origin_folder_jedi + '\\Content',dirs_exist_ok=True)
    else:
        messagebox.showinfo('Path Not Found','If you want to install the other mods (Anti Stutter, Fix Rt, and Intro Skip), select the path to the game\'s .exe file. The path should look like: Jedi Survivor\\SwGame\\Binaries\\Win64')

async def fsr3_cyber():
    path_mods = {
        "mods\\FSR3_CYBER2077\\mods\\Cyberpunk 2077 HD Reworked",
        "mods\\FSR3_CYBER2077\\mods\\nova_LUT_2-1",
        "mods\\FSR3_CYBER2077\\mods\\CET",
        "mods\\FSR3_CYBER2077\\mods\\Cyberpunk UltraPlus",
    }

    path_reshade_2077 = "mods\\FSR3_CYBER2077\\mods\\V2.0 Real Life Reshade"
    path_ghost_fix_2077 = "mods\\FSR3_CYBER2077\\mods\\FrameGen Ghosting Fix"
    path_disable_vignette = "mods\\FSR3_CYBER2077\\mods\\Disable Vignette and Sharpening"
    path_xess_nvngx = "mods\\FSR3_CYBER2077\\Xess_FSR_FG\\XESS Upscaler\\nvngx.ini"
    path_fg_amd = "mods\\FSR3_CYBER2077\\Xess_FSR_FG\\AMD"
    path_fg_nvidia = "mods\\FSR3_CYBER2077\\Xess_FSR_FG\\Nvidia"
    path_rtx_dlss = "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal"
    cb2077_reg = "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal\\DisableNvidiaSignatureChecks.reg"
    origin_path_cb2077 = os.path.abspath(os.path.join(select_folder, '..\\..'))
    gpu_name = get_active_gpu()
    
    try:
        if select_mod == "RTX DLSS FG":
            await asyncio.to_thread(shutil.copytree, path_rtx_dlss, select_folder, dirs_exist_ok=True)
            await asyncio.to_thread(runReg(cb2077_reg))
        
        if select_mod == "FSR 3.1.3/XESS FG 2077":
            if 'amd' in gpu_name or 'intel' in gpu_name:
                shutil.copytree(path_fg_amd, select_folder, dirs_exist_ok=True)
            else:
                shutil.copytree(path_fg_nvidia, select_folder, dirs_exist_ok=True)
            
            if messagebox.askyesno('FSR/XESS', 'Do you want to use XESS as the upscaler? The default is FSR 3.1.3.'):
                shutil.copy(path_xess_nvngx, select_folder)

        if select_mod == 'Others Mods 2077':

            update_upscalers(select_folder, False, True)

            if os.path.exists(origin_path_cb2077 + '\\bin'):
                if messagebox.askyesno("Mods", "Would you like to install the Nova Lut and Cyberpunk 2077 HD Reworked mods?"):
                    for path_cb2077 in path_mods:
                        await asyncio.to_thread(shutil.copytree, path_cb2077, origin_path_cb2077, dirs_exist_ok=True)
                
                if messagebox.askyesno('Reshade', 'Do you want to install Reshade Real Life 2.0? (It is necessary to install Reshade for this mod to work. Please refer to the FSR Guide for installation instructions.)'):
                    await asyncio.to_thread(shutil.copytree, path_reshade_2077, origin_path_cb2077, dirs_exist_ok=True)
                
                # FG Ghost Fix
                handle_prompt(
                'FG Ghost Fix',
                'Do you want to install the FG Ghost Fix? Only if you are using the FSR 3.1.3/XESS FG 2077 mod.',
                lambda _: (
                    shutil.copytree(path_ghost_fix_2077, origin_path_cb2077, dirs_exist_ok=True)
                    )
                )

                # Disable Vignette
                handle_prompt(
                'Disable Vignette',
                'Do you want to remove the vignette from the game? This mod removes the black vignette that appears in the corners of the screen.',
                lambda _: (
                    shutil.copytree(path_disable_vignette, origin_path_cb2077, dirs_exist_ok=True)
                    )
                )

            else:
                messagebox.showinfo('Others Mods','If you want to install the other mods (Nova Lut, Real Life and Ultra Realistic Textures), select the path to the .exe, it should be something like: Cyberpunk 2077/bin/x64') 
    except Exception as e:
        messagebox.showinfo('Error','Failed to install the mod. Please try again.')
        return

def optiscaler_fsr3():
    path_optiscaler_custom = 'mods\\Optiscaler FSR 3.1 Custom'
    path_ini_optiscaler_custom = 'mods\\Temp\\Optiscaler FG 3.1\\nvngx.ini'
    shutil.copytree(path_optiscaler_custom,select_folder,dirs_exist_ok=True)
    shutil.copy2(path_ini_optiscaler_custom,select_folder)
    
install_contr = None
fsr_2_2_opt = ['Achilles Legends Untold','Alan Wake 2','A Plague Tale Requiem','Assassin\'s Creed Mirage',
               'Atomic Heart','Banishers: Ghosts of New Eden','Black Myth: Wukong','Blacktail','Bright Memory: Infinite','Cod Black Ops Cold War','Control','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Death Stranding Director\'s Cut','Dragon Age: Veilguard','Dying Light 2','Everspace 2','Evil West','F1 2022','F1 2023','Final Fantsy XVI','FIST: Forged In Shadow Torch',
               'Fort Solis','Ghostwire: Tokyo','God of War Ragnarök','Hellblade 2','Hogwarts Legacy','Horizon Zero Dawn Remastered','Kena: Bridge of Spirits','Lies of P','Loopmancer','Manor Lords','Marvel\'s Avengers','Metro Exodus Enhanced Edition','Monster Hunter Rise','Nobody Wants To Die','Outpost: Infinity Siege',
               'Palworld','Ready or Not','Red Dead Redemption','Remnant II','RoboCop: Rogue City','Satisfactory','Sackboy: A Big Adventure','Smalland','Shadow Warrior 3','Starfield','STAR WARS Jedi: Survivor','Star Wars Outlaws','Steelrising','TEKKEN 8','Test Drive Ultimate Solar Crown','The Ascent','The Casting Of Frank Stone','The Chant','The Invincible','The Medium','Until Dawn','Wanted: Dead','Warhammer: Space Marine 2', 'Watch Dogs Legion']

fsr_2_1_opt=['Chernobylite','Dead Space (2023)','Hellblade: Senua\'s Sacrifice','Hitman 3','Horizon Zero Dawn','Judgment','Martha Is Dead','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man Miles Morales','Returnal','Ripout','Saints Row','The Callisto Protocol','Uncharted Legacy of Thieves Collection']

fsr_2_0_opt = ['Alone in the Dark','Deathloop','Crime Boss Rockay City','Dying Light 2','Brothers: A Tale of Two Sons Remake','Ghostrunner 2','High On Life','Jusant','Layers of Fear','Marvel\'s Guardians of the Galaxy','Nightingale','Rise of The Tomb Raider','Shadow of the Tomb Raider','The Outer Worlds: Spacer\'s Choice Edition','The Witcher 3']

fsr_sdk_opt = ['Ratchet & Clank - Rift Apart','Pacific Drive','MOTO GP 24']

fsr_sct_2_2 = ['2.2']
fsr_sct_2_1 = ['2.1']
fsr_sct_2_0 = ['2.0']
fsr_sct_SDK = ['SDK']

nvngx_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
nvngx_label_guide.place_forget()

def guide_nvngx(event=None):
    nvngx_label_guide.config(text="Files that can help the mod to work in some specific games.\n(We recommend copying these files only if the default mod doesn't work.")
    nvngx_label_guide.place(x=0,y=440)
    
def close_nvngx_guide(event=None):
    nvngx_label_guide.config(text="")
    nvngx_label_guide.place_forget()

dxgi_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
dxgi_label_guide.place_forget()

def guide_dxgi(event=None):
    dxgi_label_guide.config(text="Files that can help the mod to work in some specific games.\n(We recommend copying these files only if the default mod doesn't work.")
    dxgi_label_guide.place(x=210,y=440)
     
def close_dxgi_guide(event=None):
    dxgi_label_guide.config(text="")
    dxgi_label_guide.place_forget()

fk_gpu_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=250)
fk_gpu_label_guide.place_forget()

def guide_fk_gpu(event=None):
    fk_gpu_label_guide.config(text="Enable GPU proxy/spoof, show as Nvidia 40-series, default = false.")
    fk_gpu_label_guide.place(x=0,y=168)

def close_fk_gpu_guide(event=None):
    fk_gpu_label_guide.config(text="")
    fk_gpu_label_guide.place_forget()
    
nvapi_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
nvapi_label_guide.place_forget()

def guide_nvapi(event=None):
    nvapi_label_guide.config(text="Only relevant for GTX users who had issues with DLSS/FG not being selectable, default = false.")
    nvapi_label_guide.place(x=0,y=200)

def close_nvapiguide(event=None):
    nvapi_label_guide.config(text="")
    nvapi_label_guide.place_forget()

ue_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=190)
ue_label_guide.place_forget()

def guide_ue(event=None):
    ue_label_guide.config(text="Workaround for xmas/disco graphical artifacts in Unreal Engine games when selecting DLSS, default = false")
    ue_label_guide.place(x=200,y=170)

def close_ueguide(event=None):
    ue_label_guide.config(text="")
    ue_label_guide.place_forget()

mcos_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=190)
mcos_label_guide.place_forget()

def guide_mcos(event=None):
    mcos_label_guide.config(text="Enable macOS-specific compatibility tweaks, default = false")
    mcos_label_guide.place(x=200,y=200)

def close_mcosguide(event=None):
    mcos_label_guide.config(text="")
    mcos_label_guide.place_forget()
    
sharp_over_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
sharp_over_label_guide.place_forget()

def guide_sharp_over(event=None):
    sharp_over_label_guide.config(text="Default value is -1.0, override disabled, uses game sharpening\n"
    "values 0.0-1.0, 0.0 disables sharpening completely, 1.0 max sharpening")
    sharp_over_label_guide.place(x=420,y=118)

def close_sharp_overguide(event=None):
    sharp_over_label_guide.config(text="")
    sharp_over_label_guide.place_forget()
    
mod_op_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
mod_op_label_guide.place_forget()

def guide_mod_op(event=None):
    mod_op_label_guide.config(text="Default: How the mod used to operate. DLSS/FSR inputs used for FSR3 Upscaling and FSR3 Frame Generation.\n\n"
    "Enable Upscaling Only: Same as default mode, but enables only FSR3 upscaling, FSR3 FG is disabled\n\n"
    "Use Game Upscaling: Same as replace_dlss_fg, but for games WITHOUT Native DLSS3FG, there will be HUD ghosting\n\n"
    "Replace Dlss-FG: For mixing other upscalers like DLSS or XeSS with FSR3 Frame Generation in games that have NATIVE DLSS3 Frame Generation, no HUD ghosting\n\n"
    "FSR3: Default option, FSR3 from the game will be used.\n"
    "DLSS: Replaces FSR3 with DLSS if the game supports it.\n"
    "XESS: Replaces FSR3 with XESS if the game supports it.\n")
    mod_op_label_guide.place(x=420,y=60)

def close_mod_opguide(event=None):
    mod_op_label_guide.config(text="")
    mod_op_label_guide.place_forget()

fg_mode_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
fg_mode_label_guide.place_forget()

def guide_fg_mode(event=None):
    fg_mode_label_guide.config(text="Define which frame generator will be used, FSR 3.1 or FSR3")
    fg_mode_label_guide.place(x=420,y=90)

def close_fg_modeguide(event=None):
    fg_mode_label_guide.config(text="")
    fg_mode_label_guide.place_forget()

dis_con_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
dis_con_label_guide.place_forget()

def guide_dis_con_op (event=None):
    dis_con_label_guide.config(text="Disable the CMD that autostarts on game boot, default = false")
    dis_con_label_guide.place(x=0,y=320)
    
def close_dis_conguide(event=None):
    dis_con_label_guide.config(text="")
    dis_con_label_guide.place_forget()

debug_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
debug_label_guide.place_forget()

def guide_debug_op (event=None):
    debug_label_guide.config(text="For enabling FSR3FG debug overlay, default = false")
    debug_label_guide.place(x=200,y=320)
    
def close_debugguide(event=None):
    debug_label_guide.config(text="")
    debug_label_guide.place_forget()

debug_view_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
debug_view_label_guide.place_forget()

def guide_debug_view_op (event=None):
    debug_view_label_guide.config(text="For enabling FSR3FG debug overlay, default = false")
    debug_view_label_guide.place(x=200,y=290)
    
def close_debug_viewguide(event=None):
    debug_view_label_guide.config(text="")
    debug_view_label_guide.place_forget()

en_sig_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
en_sig_label_guide.place_forget()

def guide_en_sig (event=None):
    en_sig_label_guide.config(text="Enable Signature Override can help some games to work, it is also recommended to activate in older versions of the mod")
    en_sig_label_guide.place(x=0,y=410)
    
def close_en_sigguide(event=None):
    en_sig_label_guide.config(text="")
    en_sig_label_guide.place_forget()

addon_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
addon_label_guide.place_forget()

def guide_addon_mods(event=None):
    addon_label_guide.config(text="Addon Mods to assist the performance of FSR 3 mods, check the guide on FSR Guide for more information.")
    addon_label_guide.place(x=420,y=415)

def close_addon_guide(event=None):
    addon_label_guide.config(text="")
    addon_label_guide.place_forget()

addon_dx12_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
addon_dx12_guide.place_forget()

def guide_addon_dx12(event=None):
    addon_dx12_guide.config(text="Select the upscaler that the mod will use")
    addon_dx12_guide.place(x=420,y=480)
 
def close_addon_dx12(event=None):
    addon_dx12_guide.config(text="")
    addon_dx12_guide.place_forget()

ignore_ingame_fg_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
ignore_ingame_fg_guide.place_forget()

def guide_ignore_ingame_fg(event=None):
    ignore_ingame_fg_guide.config(text="Enables Frame Gen regardless of the ingame DLSS-FG/FSR3-FG setting.")
    ignore_ingame_fg_guide.place(x=0,y=350)

def close_guide_ignore_ingame_fg(event=None):
    ignore_ingame_fg_guide.config(text="")
    ignore_ingame_fg_guide.place_forget()

ignore_ingame_fg_resources_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
ignore_ingame_fg_resources_guide.place_forget()

def guide_ignore_ingame_fg_resources(event=None):
    ignore_ingame_fg_resources_guide.config(text="Disables the use of game provided HUD less and UI resources. Will only cause more graphical issues in most games, so you should leave this turned off in most cases.")
    ignore_ingame_fg_resources_guide.place(x=0,y=380)

def close_guide_ignore_ingame_fg_resources(event=None):
    ignore_ingame_fg_resources_guide.config(text="")
    ignore_ingame_fg_resources_guide.place_forget()

continue_install = None 
def get_mod_version_canvas():
    global continue_install
    option_mod_version = None
    for opt_mod in mod_version_canvas.find_all():
        if mod_version_canvas.type(opt_mod) == "text":
            option_mod_version = mod_version_canvas.itemcget(opt_mod, "text")
            continue_install = True
            break
    if not option_mod_version:
        continue_install = False
  
def install(event=None):
    global install_contr,continue_install,replace_flag,var_method
    try:
        install_contr = True       
        get_mod_version_canvas()
        if not continue_install:
            messagebox.showinfo('Mod Version','Please select a mod version.')
            return

        if select_option in fsr_2_2_opt or select_fsr in fsr_sct_2_2 and install_contr:
            fsr_2_2()
        elif select_option in fsr_2_1_opt or select_fsr in fsr_sct_2_1 and install_contr:
            fsr_2_1()
        elif select_option in fsr_2_0_opt or select_fsr in fsr_sct_2_0 and install_contr:
            fsr_2_0()
        elif select_option in fsr_sdk_opt or select_fsr in fsr_sct_SDK and install_contr:
            fsr_sdk()
        elif select_mod in er_origins or select_mod == 'Unlock FPS Elden':
            elden_fsr3()
        elif select_mod == 'Fallout 4 FSR3':
            fallout_fsr()
        elif select_mod  == 'Forza Horizon 5 FSR3':
            fh_fsr3()
        elif select_option == 'Icarus':
            icarus_fsr3()
        elif select_option == 'Lords of the Fallen':
            lotf_fsr3()
        elif select_option == 'Horizon Forbidden West':
            hfw_fsr3()

        if select_mod == "FSR 3.1.1/DLSS Optiscaler":
            optiscaler_fsr3()
        if select_mod == 'FSR 3.1.2/DLSS FG Custom':
            global_dlss()
        if select_mod in mods_to_install_optiscaler_fsr_dlss:
            optiscaler_fsr_dlss()
            
        if select_option == 'Cod Black Ops Cold War':
            cod_fsr()
        if select_option == 'COD MW3':
            cod_mw3_fsr3()
        
        if select_option == 'GTA V':
            var_dinput_gtav = gtav_fsr3()
            if not var_dinput_gtav:
                return
        
        if select_option == 'Dead Rising Remaster':
            if not fsr3_drr():
                return

        if select_option == "Cyberpunk 2077":
            asyncio.run(fsr3_cyber())
        if select_option == 'Black Myth: Wukong':
            wukong_fsr3()
        if select_mod == 'Baldur\'s Gate 3':
            bdg_fsr3()
        if select_option == 'Palworld':
            pw_fsr3()
        if select_option == 'Silent Hill 2':
            fsr3_silent2()
        if select_option == 'Until Dawn':
            fsr3_until()
        if select_option == 'Suicide Squad: Kill the Justice League':
            fsr3_sskjl()
        if select_option == 'Resident Evil 4 Remake':
            fsr3_re4()
        if select_option == 'Dead Island 2':
            fsr3_di2()
        if select_option == 'Returnal':
            fsr3_returnal()
        if select_option == 'S.T.A.L.K.E.R. 2':
            fsr3_stalker()
        if select_option == 'Red Dead Redemption 2':
            fsr3_rdr2()
        if select_option == 'Lego Horizon Adventures':
            fsr3_lego_horizon()
        if select_option == 'Dragons Dogma 2':
            fsr3_dd2()
        if select_option == 'Assassin\'s Creed Mirage':
            fsr3_ac_mirage()
        if select_option == 'Dragon Age: Veilguard':
            fsr3_dg_veil()
        if select_option == 'A Quiet Place: The Road Ahead':
            fsr3_quiet_place()
        if select_option == 'Indiana Jones and the Great Circle':
            fsr3_indy()
        if select_option == 'Red Dead Redemption':
            fsr3_rdr1()
        if select_option == 'Hogwarts Legacy':
            fsr3_hog_legacy()
        if select_option == 'Metro Exodus Enhanced Edition':
            metro_fsr3()
        if select_option == 'STAR WARS Jedi: Survivor':
            fsr3_jedi()
        if select_option == 'Warhammer: Space Marine 2':
            fsr3_space_marine()
        if select_option == 'The Callisto Protocol':
            callisto_fsr()
        if select_option == 'God of War Ragnarök':
            fsr3_gow_rag()
        if select_option == 'Hellblade 2':
            fsr3_hellblade_2()
        if select_option == 'Assassin\'s Creed Valhalla':
            fsr3_ac_valhalla()
        if select_option == 'Control':
            fsr3_control()
        if select_option == 'MOTO GP 24':
            fsr3_motogp()
        if select_option == 'Final Fantasy XVI':
            fsr3_ffvxi()
        if select_option == 'Star Wars Outlaws':
            fsr3_outlaws()
        if select_option == 'Ghost of Tsushima':
            fsr3_got()
        if select_option == 'The Medium':
            fsr3_the_medium()
        if select_option == 'Chernobylite':
            chernobylite_short_cut()
        if select_option == 'Alan Wake 2':
            fsr3_aw2()
        if select_mod == 'Unlock Fps Tekken 8':
            ulck_fps_tekken()
        if select_mod == 'Uniscaler' and select_mod_operates != None and select_nvngx != 'XESS 1.3.1' or select_mod == 'Uniscaler' and select_mod_operates != None and not nvngx_contr:
            xess_fsr()
        if select_mod == 'Uniscaler' and select_mod_operates != None and select_nvngx != 'DLSS 3.8.10' or select_mod == 'Uniscaler' and select_mod_operates != None and not nvngx_contr:
            dlss_fsr()
        
        games_to_update_upscalers()

        if addon_contr:
            addon_mods()
        if select_addon_mods == 'OptiScaler':
            update_optiscaler_dx11_dx12()
            update_optiscaler_ini()

            if select_mod != 'FSR 3.1.1/DLSS Optiscaler':
                if var_method is None:
                    messagebox.showinfo('Install Method','Select an Optiscaler installation method before proceeding with the mod installation.')
                    return
                else:
                    update_install_method()
            var_method = None #Display the Optiscaler Method screen again

        if nvngx_contr:
            copy_nvngx()
            if select_mod not in nvngx_folders:
                return
        if dxgi_contr:
            copy_dxgi()
        if install_contr:
            replace_ini()
            backup_cbox.deselect()
        if install_contr and select_fsr != None or install_contr and select_option != 'Select FSR version':
            copy_fake_gpu()
        elif install_contr and select_option == 'Select FSR version' and select_fsr == None:
            messagebox.showwarning('Select FSR Version','Please select the FSR version')
            return
        
        if select_mod != None and select_folder != None and select_option != None:           
            messagebox.showinfo('Successful','Successful installation')
        else:
            messagebox.showinfo('Error','Please fill out the first 3 options, Select Game, Select Folder, and Mod Options.')
            return
        
        fps_limit()
        replace_flag = True
        replace_clean_file()
        replace_flag = False

        install_label.configure(fg='black')
        screen.after(100,install_false)
        
    except Exception as e: 
        messagebox.showwarning('Error',f'Installation error')
        return
        
def install_false(event=None):
    global install_contr
    install_label.configure(fg='#E6E6FA')
    
game_folder_canvas = Canvas(screen,width=200,height=15,bg='white')
game_folder_canvas.place(x=101,y=75)

game_folder_label = tk.Label(screen,text = 'Game folder:',font=font_select,bg='black',fg='#C0C0C0')
game_folder_label.place(x=0,y=70)

mod_version_label = tk.Label(screen,text='Mod version:',font=font_select,bg='black',fg='#C0C0C0')
mod_version_label.place(x=0,y=108)

mod_version_canvas = Canvas(screen,width=200,height=15,bg='white')
mod_version_canvas.place(x=101,y=113)

mod_version_listbox = tk.Listbox(screen,bg='white',width=34,height=0)
mod_version_listbox.pack(side=tk.RIGHT,expand=True,padx=(0,170),pady=(0,480))
mod_version_listbox.pack_forget()
scroll_mod_listbox = tk.Scrollbar(mod_version_listbox,orient=tk.VERTICAL,command=mod_version_listbox.yview)
scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(6,26))
mod_version_listbox.config(yscrollcommand=scroll_mod_listbox.set)
scroll_mod_listbox.config(command=mod_version_listbox.yview)

mod_listbox_visible = False
def mod_listbox_view(event):
    global mod_listbox_visible
    if mod_listbox_visible:
        mod_version_listbox.place_forget()
        mod_listbox_visible = False
    else:
        mod_version_listbox.place(x=101,y=135)
        mod_listbox_visible = True

def select_game_listbox_view(event):
    global game_options_listbox_visible
    if game_options_listbox_visible:
        game_options_listbox.place_forget()
        game_options_listbox_visible = False
    else:
        game_options_listbox.place(x=101,y=58)
        game_options_listbox_visible = True
        
game_options_listbox_visible = False
game_options_listbox = tk.Listbox(screen,bg='white',selectbackground='white',width=30,height=0)
game_options_listbox.pack(side=tk.RIGHT,expand=True,padx=(0,115),pady=(0,500))
game_options_listbox.pack_forget()
scroll_listbox = tk.Scrollbar(game_options_listbox,orient=tk.VERTICAL,command=game_options_listbox.yview)
scroll_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(13,50))
game_options_listbox.config(yscrollcommand=scroll_listbox.set)
scroll_listbox.config(command=game_options_listbox.yview)

def fsr_listbox_view():
    if color_rec_bool:
        fsr_canvas.config(bg='white')
    else:
        fsr_canvas.config(bg='#C0C0C0')
     
fsr_canvas= Canvas(screen,width=50,height=19,bg='#C0C0C0',highlightthickness=0)
fsr_canvas.place(x=350,y=37)
color_rec_bool = False
fsr_listbox = tk.Listbox(screen,bg='white',width=8,height=0,highlightthickness=0)
fsr_listbox.pack(side=tk.RIGHT,expand=True,padx=(280,0),pady=(0,610))
fsr_listbox.pack_forget()

fsr_visible = False
fsr_view_listbox = False

change_font_var = IntVar()
def cbox_change_font():
    path_act = os.getcwd()
    path_font = "Fonts\\CustomTkinter_shapes_font.otf"
    dest_font= path_act+"\\lib\\customtkinter\\assets\\fonts"
    
    if change_font_var.get() == 1:
        if os.path.exists(os.path.join("Fonts\\CustomTkinter_shapes_font.otf")):
            var_copy_font = messagebox.askyesno("Change font",'Do you want to copy the file from the original Utility font? This may make the original font work. Currently, the font being used is Arial.')
            try:
                if var_copy_font:
                    shutil.copy(path_font,dest_font)
                    messagebox.showinfo('Sucess','Original font file copied successfully, restart the application. If the font is still not applied even after the restart, try installing the font manually. Follow this path: FSR3\\lib\\customtkinter\\assets\\fonts, open the CustomTkinter_shapes_font file, and click on \'Install\'.')
            except Exception:
                messagebox.showinfo('Error','The original font file could not be copied, perhaps your system is not compatible with this font. If you want to install manually, follow this path: FSR3\\lib\\customtkinter\\assets\\fonts, open the CustomTkinter_shapes_font file, and click on \'Install\'.')
                return
    
def fsr_listbox_visible(event):
    global fsr_visible
    if fsr_view_listbox:
        if fsr_visible:
            fsr_listbox.place_forget()
            fsr_visible = False
        else:
            fsr_listbox.place(x=350,y=58)
            fsr_visible = True

fsr_game_version={
    'The Last of Us':'2.1',
    'Uncharted: Legacy of Thievs':'2.1',
    'A Plague Tale Requiem':'2.2',
    'A Quiet Place: The Road Ahead':'2.2',
    'Achilles Legends Untold':'2.2',
    'Alan Wake Remastered':'2.2',
    'Alan Wake 2':'2.2',
    'Alone in the Dark':'2.0',
    'Assassin\'s Creed Mirage':'2.2',
    'Assassin\'s Creed Valhalla':'DLSS',
    'Assetto Corsa Evo':'2.2',
    'Atomic Heart':'2.2',
    'Baldur\'s Gate 3':'PD',
    'Back 4 Blood':'2.2',
    'Banishers: Ghosts of New Eden':'2.2',
    'Black Myth: Wukong':'2.2',
    'Blacktail':'2.2',
    'Bright Memory: Infinite':'2.2',
    'Brothers: A Tale of Two Sons Remake':'2.0',
    'Chernobylite':'2.1',
    'Cod Black Ops Cold War':'2.2',
    'Cod MW3':'3.0',
    'Control':'2.2',
    'Crime Boss Rockay City':'2.0',
    'Crysis 3 Remastered':'2.2',
    'Cyberpunk 2077':'2.2',
    'Dakar Desert Rally':'2.2',
    'Deathloop':'2.0',
    'Dead Island 2':'2.2',
    'Dead Rising Remaster':'2.2',
    'Death Stranding Director\'s Cut':'2.2',
    'Dead Space (2023)':'2.1',
    'Dragon Age: Veilguard':'2.2',
    'Dragons Dogma 2':'US',
    'Dying Light 2':'2.0',
    'Dynasty Warriors: Origins':'2.2',
    'Elden Ring':'PD',
    'Empire of the Ants':'2.2',
    'Eternal Strands':'2.2',
    'Everspace 2':'2.2',
    'Evil West':'2.2',
    'Fallout 4':'PD',
    'Final Fantasy VII Rebirth' :'2.2',
    'Final Fantasy XVI':'2.2',
    'F1 2022':'2.2',
    'F1 2023':'2.2',
    'FIST: Forged In Shadow Torch':'2.2',
    'Flintlock: The Siege of Dawn':'3.1',
    'Fort Solis':'2.2',
    'Forza Horizon 5':'FH',
    'Ghost of Tsushima':'DLSS',
    'Ghostrunner 2':'2.0',
    'Ghostwire: Tokyo':'2.2',
    'God Of War 4':'2.2',
    'God of War Ragnarök':'2.2',
    'Gotham Knights':'2.2',
    'GTA Trilogy':'2.2',
    'GTA V':'PD',
    'Martha Is Dead':'2.1',
    'Marvel\'s Avengers':'2.2',
    'Marvel\'s Guardians of the Galaxy':'2.0',
    'Marvel\'s Midnight Suns':'.2.2',
    'Hellblade: Senua\'s Sacrifice':'2.1',
    'Hellblade 2':'2.2',
    'High On Life':'2.0',
    'Hitman 3':'2.1',
    'Hogwarts Legacy':'2.2',
    'Horizon Zero Dawn/Remastered':'2.2',
    'Horizon Forbidden West':'2.2',
    'Hot Wheels Unleashed':'2.2',
    'Icarus':'ICR',
    'Indiana Jones and the Great Circle':'2.2',
    'Judgment':'2.1',
    'Jusant':'2.0',
    'Kena: Bridge of Spirits':'2.2',
    'Kingdom Come: Deliverance II':'2.2',
    'Layers of Fear':'2.0',
    'Lego Horizon Adventures':'2.2',
    'Lies of P':'2.2',
    'Lords of the Fallen':'2.2',
    'Loopmancer':'2.2',
    'Manor Lords':'2.2',
    'Marvel\'s Spider-Man Remastered':'2.1',
    'Marvel\'s Spider-Man 2':'2.2',
    'Marvel\'s Spider-Man Miles Morales':'2.1',
    'Metro Exodus Enhanced Edition': '2.2',
    'Microsoft Flight Simulator 2024':'2.2',
    'Monster Hunter Rise':'2.2',
    'Mortal Shell':'2.2',
    'MOTO GP 24':'SDK',
    'Nightingale':'2.0',
    'Ninja Gaiden 2 Black':'2.2',
    'Nobody Wants To Die':'3.0',
    'Orcs Must Die! Deathtrap':'2.2',
    'Outpost: Infinity Siege':'2.2',
    'Pacific Drive':'SDK',
    'Palworld':'2.2',
    'Path of Exile II':'2.2',
    'Ratchet & Clank - Rift Apart':'SDK',
    'Red Dead Redemption':'2.2',
    'Red Dead Redemption 2':'2.2',
    'Ready or Not':'2.2',
    'Remnant II':'2.2',
    'Resident Evil 4 Remake':'2.2',
    'Returnal':'2.1',
    'Rise of The Tomb Raider':'2.0',
    'Ripout':'2.1',
    'RoboCop: Rogue City':'2.2',
    'Saints Row':'2.1',
    'Satisfactory':'2.2',
    'Sackboy: A Big Adventure':'2.2',
    'Scorn':'2.2.',
    'Sengoku Dynasty' : '2.2',
    'Shadow of the Tomb Raider':'2.0',
    'Shadow Warrior 3':'2.2',
    'Sifu':'2.2',
    'Silent Hill 2':'2.2',
    'Six Days in Fallujah':'2.2',
    'Smalland':'2.2',
    'Soulslinger Envoy of Death':'2.2',
    'Soulstice':'2.2',
    'S.T.A.L.K.E.R. 2':'2.2',
    'Starfield':'2.2',
    'STAR WARS Jedi: Survivor':'2.2',
    'Star Wars Outlaws':'2.2',
    'Steelrising':'2.2',
    'Suicide Squad: Kill the Justice League':'2.2',
    'TEKKEN 8':'2.2',
    'Test Drive Ultimate Solar Crown':'2.2',
    'The Ascent':'2.2',
    'The Callisto Protocol':'2.1',
    'The Casting Of Frank Stone':'2.2',
    'The Chant':'2.2',
    'The First Berserker: Khazan':'2.2',
    'The Invincible':'2.2',
    'The Last Of Us Part I':'US',
    'The Medium':'2.2',
    'The Talos Principle 2':'2.2',
    'The Thaumaturge':'2.2',
    'The Outer Worlds: Spacer\'s Choice Edition':'2.0',
    'Thymesia':'2.2',
    'The Witcher 3':'2.0',
    'Uncharted Legacy of Thieves Collection':'2.1',
    'Unknown 9: Awakening':'2.2',
    'Until Dawn':'2.2',
    'Wanted: Dead':'2.2',
    'Warhammer: Space Marine 2':'2.2',
    'Watch Dogs Legion':'2.2',
    'Way Of The Hunter':'2.2',
    'Wayfinder':'2.2'
}

select_option = None
select_fsr = None
select_mod = None
select_asi = None
option_asi = None
select_mod_operates = None
select_nvngx = None
select_dxgi = None

x=0
y=0
def update_canvas(event=None): #game_options_canvas text configuration
    global mod_options,x,y,select_fsr,fsr_visible,fsr_game_version,color_rec_bool,select_option,fsr_view_listbox,game_options_listbox_visible
    
    default_mods = '0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4'
    uniscaler_mods = 'Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss'
    fsr_31_dlss_mods = 'FSR 3.1.1/DLSS Optiscaler','FSR 3.1.2/DLSS FG Custom', 'FSR 3.1.3/DLSS FG (Only Optiscaler)', 'FSR 3.1.3/DLSSG FG (Only Optiscaler)'

    game_mods_config = {
        'A Plague Tale Requiem': [*fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'A Quiet Place: The Road Ahead': ['FSR 3.1.1/DLSS Quiet Place', *fsr_31_dlss_mods],
        'Alan Wake 2': ['Others Mods AW2','Alan Wake 2 FG RTX', 'Alan Wake 2 Uniscaler Custom', *fsr_31_dlss_mods, '0.9.0', '0.10.0', '0.10.1', '0.10.1h1', '0.10.2h1', '0.10.3', '0.10.4', *uniscaler_mods],
        'Alan Wake Remastered': [*fsr_31_dlss_mods],
        'Alone in the Dark' : ['Others Mods AITD',*fsr_31_dlss_mods, *default_mods, *uniscaler_mods ],
        'Assassin\'s Creed Mirage': ['Others Mods Mirage', *fsr_31_dlss_mods],
        'Assassin\'s Creed Valhalla': ['Ac Valhalla DLSS3 (Only RTX)', 'Ac Valhalla FSR3 All GPU'],
        'Assetto Corsa EVO': ['Others Mods ACE', *fsr_31_dlss_mods],
        'Atomic Heart' : ['Others Mods ATH', *fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Back 4 Blood' : ['Others Mods B4B', *fsr_31_dlss_mods],
        'Baldur\'s Gate 3': ['Baldur\'s Gate 3 FSR3', 'Baldur\'s Gate 3 FSR3 V2', 'Baldur\'s Gate 3 FSR3 V3'],
        'Black Myth: Wukong': ['Others Mods Wukong','DLSS FG (ALL GPUs) Wukong', 'FSR 3.1 Custom Wukong', *default_mods, *uniscaler_mods, *fsr_31_dlss_mods],
        'COD MW3': ['COD MW3 FSR3'],
        'Control': ['Others Mods Control', *fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Cyberpunk 2077': ['Others Mods 2077',*fsr_31_dlss_mods,'RTX DLSS FG', 'FSR 3.1.3/XESS FG 2077', *default_mods, *uniscaler_mods],
        'Dead Rising Remaster': ['FSR 3.1 FG DRR', 'Dinput8 DRR'],
        'Dragon Age: Veilguard' : ['Others Mods DG Veil','FSR 3.1.3/DLSS DG Veil',*fsr_31_dlss_mods,*default_mods,*uniscaler_mods],
        'Dragons Dogma 2': ['Dinput8 DD2', *fsr_31_dlss_mods],
        'Dying Light 2': [*fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Elden Ring': ['Disable_Anti-Cheat', 'Elden_Ring_FSR3', 'Elden_Ring_FSR3 V2', 'FSR 3.1.3/DLSS FG Custom Elden', 'Unlock FPS Elden'],
        'Evil West' : ['Others Mods EW', *fsr_31_dlss_mods],
        'Fallout 4': ['Fallout 4 FSR3'],
        'Final Fantasy VII Rebirth' : ['Others Mods FF7RBT', *fsr_31_dlss_mods],
        'Final Fantasy XVI': ['FFXVI DLSS RTX', 'Others Mods FFXVI', *default_mods, *uniscaler_mods, *fsr_31_dlss_mods],
        'Flintlock: The Siege of Dawn': [*fsr_31_dlss_mods],
        'FIST: Forged In Shadow Torch' : [ 'Others Mods Fist', *fsr_31_dlss_mods,*default_mods, *uniscaler_mods],
        'Forza Horizon 5': ['Forza Horizon 5 FSR3'],
        'Ghost of Tsushima': ['Ghost of Tsushima FG DLSS', 'Uniscaler FSR 3.1'],
        'Ghostrunner 2' : ['Others Mods GR2', *fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Gotham Knights': ['Others Mods GK', *fsr_31_dlss_mods],
        'GTA Trilogy' : ['Others GTA Trilogy',*fsr_31_dlss_mods],
        'GTA V': ['Dinput 8', 'GTA V FSR3/DLSS4', 'GTA V FiveM', 'GTA Online', 'GTA V Epic', 'GTA V Epic V2'],
        'God Of War 4': ['FSR 3.1.3/DLSS Gow4'],
        'God of War Ragnarök': ['Others Mods Gow Rag',*fsr_31_dlss_mods ,'Uniscaler FSR 3.1'],
        'Hellblade 2': ['Others Mods HB2', 'Hellblade 2 FSR3 (Only RTX)', *fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Hitman 3' : ['Others Mods Hitman 3',*fsr_31_dlss_mods ],
        'Hogwarts Legacy': ['Others Mods HL', *fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Horizon Forbidden West': ['Horizon Forbidden West FSR3', 'Uniscaler FSR 3.1', *fsr_31_dlss_mods],
        'Horizon Zero Dawn/Remastered': ['Others Mods HZD',*fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Icarus': ['Icarus FSR3 AMD/GTX', 'Icarus FSR3 RTX'],
        'Indiana Jones and the Great Circle' : ['Others Mods Indy','Indy FG (Only RTX)'],
        'Kingdom Come: Deliverance II' : ['Others Mods KCD2',*fsr_31_dlss_mods],
        'Kena: Bridge of Spirits': [*fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Lego Horizon Adventures': [*fsr_31_dlss_mods, 'Others Mods Lego HZD'],
        'Lies of P': ['Others Mods LOP',*fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Lords of the Fallen': ['Lords of The Fallen FSR3'],
        'Marvel\'s Spider-Man Miles Morales': ['Others Mods Spider',*default_mods, *uniscaler_mods, *fsr_31_dlss_mods],
        'Marvel\'s Spider-Man Remastered': ['Others Mods Spider', *default_mods, *uniscaler_mods, *fsr_31_dlss_mods],
        'Marvel\'s Spider-Man 2': ['Others Mods Spider',*fsr_31_dlss_mods],
        'Marvel\'s Midnight Suns' : [*fsr_31_dlss_mods],
        'Metro Exodus Enhanced Edition': ['Others Mods Metro', *fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Microsoft Flight Simulator 2024': ['FSR 3.1 Custom MSFS', *fsr_31_dlss_mods],
        'Mortal Shell': ['Others Mods MShell', *fsr_31_dlss_mods],
        'Palworld': ['Others Mods PW', *fsr_31_dlss_mods,'Palworld Build03', '0.10.0', '0.10.1', '0.10.1h1', '0.10.2h1', '0.10.3', '0.10.4', *uniscaler_mods],
        'Path of Exile II': ['Others Mods POEII', *fsr_31_dlss_mods],
        'Red Dead Redemption' : ['Others Mods RDR1',*fsr_31_dlss_mods,*default_mods,*uniscaler_mods],
        'Red Dead Redemption 2': ['FSR 3.1.3/DLSS FG Custom RDR2', 'RDR2 Mix', 'RDR2 FG Custom', *fsr_31_dlss_mods],
        'Resident Evil 4 Remake': ['FSR 3.1.3/DLSS RE4'],
        'Returnal': [*fsr_31_dlss_mods, 'Others Mods Returnal', *uniscaler_mods],
        'Saints Row': [*fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Soulstice': ['Others Mods STC',*fsr_31_dlss_mods],
        'Shadow of the Tomb Raider' : ['Others Mods Shadow Tomb',*fsr_31_dlss_mods,*uniscaler_mods],
        'Sifu': ['Others Mods Sifu',*fsr_31_dlss_mods],
        'Silent Hill 2': [*fsr_31_dlss_mods, 'Ultra Plus Complete', 'Ultra Plus Optimized', 'DLSS FG RTX', 'FSR3 FG Native SH2', 'FSR3 FG Native SH2 + Optimization', 'FSR 3.1.1/DLSS FG RTX Custom', 'Others Mods Sh2'],
        'Six Days in Fallujah' : ['Others Mods 6Days', *fsr_31_dlss_mods],
        'STAR WARS Jedi: Survivor': ['Dlss Jedi', *default_mods, *uniscaler_mods, *fsr_31_dlss_mods],
        'Star Wars Outlaws': ['Outlaws DLSS RTX', *fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'S.T.A.L.K.E.R. 2': ['Others Mods Stalker 2', *fsr_31_dlss_mods, 'DLSS FG (Only Nvidia)'],
        'Steelrising' : ['Others Mods Steel',*fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Suicide Squad: Kill the Justice League' : ['Others Mods SSKJL', *fsr_31_dlss_mods],
        'TEKKEN 8': ['Unlock Fps Tekken 8', *default_mods, *uniscaler_mods],
        'The Callisto Protocol': ['FSR 3.1.3/DLSS FG (Only Optiscaler)','The Callisto Protocol FSR3','FSR 3.1.3/DLSS Custom Callisto', '0.10.4', 'Uniscaler V3', 'Uniscaler V4'],
        'The Casting Of Frank Stone': ['0.10.4', *fsr_31_dlss_mods],
        'The First Berserker: Khazan' : ['Others Mods TFBK', *fsr_31_dlss_mods],
        'The Last Of Us Part I': ['Others Mods Tlou', *fsr_31_dlss_mods],
        'The Witcher 3': [*fsr_31_dlss_mods, '0.9.0', '0.10.0', '0.10.1', '0.10.1h1', '0.10.2h1', '0.10.3', '0.10.4', *uniscaler_mods],
        'Until Dawn': ['Others Mods UD', *fsr_31_dlss_mods, *default_mods, *uniscaler_mods],
        'Warhammer: Space Marine 2': ['Others Mods Space Marine','FSR 3.1.3/DLSS FG Marine','Uniscaler FSR 3.1', *fsr_31_dlss_mods],
        'Watch Dogs Legion': ['Others Mods Legion', *fsr_31_dlss_mods],
        'Way Of The Hunter' : ['Others Mods WOTH', *fsr_31_dlss_mods]
    }

    def mod_text():
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    
    if fsr_view_listbox == True:
        game_options_canvas.delete('text')
        
    index = game_options_listbox.curselection()
    if index:
        select_option = game_options_listbox.get(index)
        game_options_listbox.place_forget()
        game_options_listbox_visible = False
        x = 2
        y = 8
        fsr_canvas.delete('text')
        if select_option != 'Select FSR version': 
            color_rec_bool = False
            fsr_view_listbox = False
            game_options_canvas.delete('text')  
            game_options_canvas.create_text(x, y, anchor='w', text=select_option, fill='black', tag='text')
            fsr_canvas.create_text(2, 8, anchor='w', text=fsr_game_version.get(select_option, ''), fill='black', tag='text')
            fsr_listbox.place_forget()
    
    if select_option == 'Select FSR version':
        fsr_view_listbox = True
        color_rec_bool = True
        game_options_canvas.delete('text')
        game_options_canvas.create_text(x, y, anchor='w', text='Select FSR version', fill='black', tag='text')
    
    if select_option in game_mods_config:
        mod_text()
        mod_version_listbox.insert(tk.END, *game_mods_config[select_option])
        scroll_mod_listbox.pack(side=tk.RIGHT, fill=tk.Y, padx=(184, 0), pady=(30, 0))
    else:
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        for mod_op in mod_options:
            mod_version_listbox.insert(tk.END,mod_op)    
    fsr_listbox_view()

def change_cursor(event=None):
    event.widget.config(cursor="hand2")

def revert_cursor(event=None):
    event.widget.config(cursor="")
    
options = ['Select FSR version','Achilles Legends Untold','Alan Wake 2','Alan Wake Remastered','Alone in the Dark','A Plague Tale Requiem', 'A Quiet Place: The Road Ahead','Assassin\'s Creed Mirage','Assassin\'s Creed Valhalla','Assetto Corsa Evo','Atomic Heart','Back 4 Blood','Baldur\'s Gate 3','Banishers: Ghosts of New Eden','Black Myth: Wukong','Blacktail','Bright Memory: Infinite','Brothers: A Tale of Two Sons Remake','Chernobylite','Cod Black Ops Cold War','COD MW3','Control','Crime Boss Rockay City', 'Crysis 3 Remastered','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Dead Rising Remaster','Deathloop','Death Stranding Director\'s Cut','Dead Space (2023)','Dragon Age: Veilguard','Dragons Dogma 2','Dying Light 2','Dynasty Warriors: Origins','Elden Ring','Empire of the Ants','Everspace 2','Eternal Strands','Evil West','Fallout 4','F1 2022','F1 2023','Final Fantasy VII Rebirth','Final Fantasy XVI','FIST: Forged In Shadow Torch','Flintlock: The Siege of Dawn','Fort Solis',
        'Forza Horizon 5','Ghost of Tsushima','Ghostrunner 2','Ghostwire: Tokyo','God Of War 4','God of War Ragnarök','Gotham Knights','GTA Trilogy','GTA V','Hellblade: Senua\'s Sacrifice','Hellblade 2','High On Life','Hitman 3','Hogwarts Legacy','Horizon Zero Dawn/Remastered','Horizon Forbidden West','Hot Wheels Unleashed','Icarus','Indiana Jones and the Great Circle','Judgment','Jusant','Kingdom Come: Deliverance II','Kena: Bridge of Spirits','Layers of Fear','Lego Horizon Adventures','Lies of P','Lords of the Fallen','Loopmancer','Manor Lords','Martha Is Dead','Marvel\'s Avengers','Marvel\'s Guardians of the Galaxy','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man 2','Marvel\'s Spider-Man Miles Morales','Marvel\'s Midnight Suns','Metro Exodus Enhanced Edition','Microsoft Flight Simulator 2024','Monster Hunter Rise','Mortal Shell','MOTO GP 24','Nightingale','Ninja Gaiden 2 Black','Nobody Wants To Die','Orcs Must Die! Deathtrap','Outpost: Infinity Siege','Pacific Drive','Palworld','Path of Exile II','Ratchet & Clank - Rift Apart',
        'Red Dead Redemption','Red Dead Redemption 2','Ready or Not','Remnant II','Resident Evil 4 Remake','Returnal','Rise of The Tomb Raider','Ripout','RoboCop: Rogue City','Saints Row','Satisfactory','Sackboy: A Big Adventure','Scorn','Sengoku Dynasty','Shadow Warrior 3','Shadow of the Tomb Raider','Sifu','Silent Hill 2','Smalland','Soulslinger Envoy of Death','Soulstice','S.T.A.L.K.E.R. 2','Starfield','STAR WARS Jedi: Survivor','Star Wars Outlaws','Steelrising','Suicide Squad: Kill the Justice League','TEKKEN 8','Test Drive Ultimate Solar Crown','The Ascent','The Callisto Protocol','The Casting Of Frank Stone','The Chant','The First Berserker: Khazan','The Invincible','The Last Of Us Part I','The Medium','The Outer Worlds: Spacer\'s Choice Edition','The Talos Principle 2','The Thaumaturge','Thymesia','The Witcher 3','Uncharted Legacy of Thieves Collection','Unknown 9: Awakening','Until Dawn','Wanted: Dead','Warhammer: Space Marine 2', 'Watch Dogs Legion', 'Way Of The Hunter','Wayfinder']# Add Games
for option in options:
    game_options_listbox.insert(tk.END,option)

def fsr_canvas_emp():
    return not fsr_canvas.find_all()
    
def update_fsr_v(event=None):
    global select_fsr,select_option
    index_fsr = fsr_listbox.curselection()
    if index_fsr:
        select_fsr = fsr_listbox.get(index_fsr) 
        fsr_canvas.delete('text')
        fsr_canvas.create_text(2,8,anchor='w',text=select_fsr,fill='black',tag='text')
    fsr_canvas.update()
    
fsr_options = ['SDK','2.0','2.1','2.2']
for fsr_op in fsr_options:
    fsr_listbox.insert(tk.END,fsr_op)
    
def update_mod_version(event=None):
    global select_mod,select_folder
    index_mod = mod_version_listbox.curselection()
    if index_mod:
        select_mod = mod_version_listbox.get(index_mod)
        mod_version_canvas.delete('text')
        mod_version_canvas.create_text(2,8,anchor='w',text=select_mod,fill='black',tag='text')
    select_mod_op_lock()
    unlock_fps_limit()
    unlock_sharp()
    update_nvngx()
    unlock_fg_mode()
    unlock_uni_custom()
    
    if select_mod == 'Hellblade 2 FSR3 (Only RTX)':
        path_inihb2 = os.getenv("LOCALAPPDATA") + '\\Hellblade2\\Saved\\Config\\Windows'
        alt_path_hb2 = os.getenv("LOCALAPPDATA") + '\\Hellblade2\\Saved\\Config\\WinGDK'
             
        if select_folder == path_inihb2 or select_folder == alt_path_hb2:
            game_folder_canvas.delete('text')
            select_folder = None                   
    mod_version_canvas.update()

mod_options = ['FSR 3.1.1/DLSS Optiscaler','FSR 3.1.2/DLSS FG Custom', 'FSR 3.1.3/DLSS FG (Only Optiscaler)','FSR 3.1.3/DLSSG FG (Only Optiscaler)','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler V4','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss']
for mod_op in mod_options:
    mod_version_listbox.insert(tk.END,mod_op)
  
def update_mod_operates(event=None):
    global select_mod_operates
    index_select_mod_op = mod_operates_listbox.curselection()
    if index_select_mod_op:
        select_mod_operates = mod_operates_listbox.get(index_select_mod_op)
        mod_operates_canvas.delete('text')
        mod_operates_canvas.create_text(2,8,anchor='w',text=select_mod_operates,fill='black',tags='text')
    edit_mod_operates()
    mod_operates_canvas.update()
    
unlock_mod_operates_list = ['0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4']
unlock_listbox_mod_op = False
def select_mod_op_lock():
    global unlock_listbox_mod_op
    
    mod_op_list = []
    if select_mod in unlock_mod_operates_list:
        mod_op_list = ['Default','Enable Upscaling Only','Use Game Upscaling','Replace dlss fg']
        mod_operates_listbox.delete(0,tk.END)
        unlock_listbox_mod_op = True
        mod_operates_canvas.config(bg='white')
        
    elif select_mod == '0.9.0':
        mod_op_list = ['Default','Enable Upscaling Only']
        mod_operates_listbox.delete(0,tk.END)
        unlock_listbox_mod_op = True
        mod_operates_canvas.config(bg='white')
        
    elif select_mod in list_uni and select_mod != 'Uniscaler V3' and select_mod  != 'Uniscaler V4' and select_mod != 'Uniscaler FSR 3.1' or select_mod == 'Uni Custom Miles' or select_mod == 'Dlss Jedi':
        mod_op_list = ['FSR3','DLSS','XESS']
        mod_operates_listbox.delete(0,tk.END)
        unlock_listbox_mod_op = True
        mod_operates_canvas.config(bg='white')
    elif select_mod == 'Uniscaler V3':
        mod_op_list = ['None','FSR3','DLSS','XESS']
        mod_operates_listbox.delete(0,tk.END)
        unlock_listbox_mod_op = True
        mod_operates_canvas.config(bg='white') 
    elif select_mod == 'Uniscaler FSR 3.1' or select_mod == 'Uniscaler V4':
        mod_op_list = ['None','FSR3','FSR3_1','DLSS','XESS']
        mod_operates_listbox.delete(0,tk.END)
        unlock_listbox_mod_op = True
        mod_operates_canvas.config(bg='white')                                                              
    else:
        mod_operates_listbox.place_forget()
        mod_operates_canvas.delete('text')
        mod_operates_canvas.config(bg='#C0C0C0')
        unlock_listbox_mod_op = False
        
    for mod_operates_ins in mod_op_list:
        mod_operates_listbox.insert(tk.END,mod_operates_ins)

def update_fg_mode(event=None):
    global select_fg_mode
    index_fg_mode = fg_mode_listbox.curselection()
    if index_fg_mode:
        select_fg_mode = fg_mode_listbox.get(index_fg_mode)
        fg_mode_canvas.delete('text')
        fg_mode_canvas.create_text(2,8,anchor='w',text=select_fg_mode,fill='black',tags='text')
    edit_fg_mode()
    fg_mode_canvas.update()

fg_mode_options =  ['FSR3.1','FSR3']
for fg_mode_opts in fg_mode_options:
    fg_mode_listbox.insert(tk.END,fg_mode_opts)
     
def update_nvngx(event=None):
    global select_nvngx,nvngx_op
    index_nvngx_op = nvngx_listbox.curselection()
    
    if select_mod == 'Uniscaler + Xess + Dlss':
        nvngx_op = ['Default', 'NVNGX Version 1']
    else:
        nvngx_op = ['Default', 'NVNGX Version 1', 'XESS 1.3.1','DLSS 3.8.10','DLSSD 3.8.1','DLSS 4','DLSSG 4','DLSSD 4']

    nvngx_listbox.delete(0, tk.END) 
    for nvngx_options in nvngx_op:
        nvngx_listbox.insert(tk.END, nvngx_options)
    
    if index_nvngx_op:
        select_nvngx = nvngx_listbox.get(index_nvngx_op)
        nvngx_canvas.delete('text')   
    nvngx_canvas.delete('text')  
    get_canvas = nvngx_canvas.create_text(2, 8, anchor='w', text=select_nvngx, fill='black', tags='text')

    text_canvas_nvngx = nvngx_canvas.itemcget(get_canvas, "text")
    
    if select_mod == 'Uniscaler + Xess + Dlss' and text_canvas_nvngx == 'XESS 1.3.1' or select_mod == 'Uniscaler + Xess + Dlss' and text_canvas_nvngx == 'DLSS 3.8.10':
        nvngx_canvas.delete('text')
    
    nvngx_canvas.update()

nvngx_op = ['Default', 'NVNGX Version 1', 'XESS 1.3.1', 'DLSS 3.8.10','DLSSG 3.7.0 FG','DLSS 4','DLSSG 4','DLSSD 4']
for nvngx_options in nvngx_op:
    nvngx_listbox.insert(tk.END, nvngx_options)
    
def update_dxgi(event=None):
    global select_dxgi
    index_dxgi = dxgi_listbox.curselection()
    if index_dxgi:
        select_dxgi = dxgi_listbox.get(index_dxgi)
        dxgi_canvas.delete('text')
        dxgi_canvas.create_text(2,8,anchor='w',text=select_dxgi,fill='black',tags='text')
    dxgi_canvas.update()

dxgi_op = ['DXGI DLL','D3D12 DLL']
for dxgi_options in dxgi_op:
    dxgi_listbox.insert(tk.END,dxgi_options)

def update_addon_mods(event=None):
    global select_addon_mods

    index_addon_mods = addon_mods_listbox.curselection()
    if index_addon_mods:
        select_addon_mods = addon_mods_listbox.get(index_addon_mods)
        addon_mods_canvas.delete('text')
        addon_mods_canvas.create_text(2,8,anchor='w',text=select_addon_mods,fill='black',tags='text')
    
    if select_addon_mods == 'OptiScaler':
        install_method()
        addon_ups_dx12_canvas.config(bg='white')
        options_optiscaler_canvas.config(bg='white')

    elif select_addon_mods != 'OptiScaler' or not addon_contr:
        addon_ups_dx12_canvas.config(bg='#C0C0C0')
        addon_ups_dx12_listbox.place_forget()
        options_optiscaler_canvas.config(bg='#C0C0C0')
        options_optiscaler_listbox.place_forget()
    addon_mods_canvas.update()

addon_op = ['OptiScaler','Tweak']
for addon_options in addon_op:
    addon_mods_listbox.insert(tk.END,addon_options)

def update_addon_dx12(event=None):
    global select_addon_dx12
    index_addon_dx12 = addon_ups_dx12_listbox.curselection()
    if index_addon_dx12:
        select_addon_dx12 = addon_ups_dx12_listbox.get(index_addon_dx12)
        addon_ups_dx12_canvas.delete('text')
        addon_ups_dx12_canvas.create_text(2,8,anchor='w',text=select_addon_dx12,fill='black',tags='text')
    
    if select_addon_dx12 in addon_dx12:
        update_optiscaler_dx11_dx12()

    addon_ups_dx12_canvas.update()

addon_dx12 = ['fsr2.1 DX11','fsr2.2 DX11 - DX12','fsr3.1 DX11','xess DX11','fsr2.2 DX11','xess DX12','dlss DX11','fsr2.2 DX12','fsr2.1 DX12', 'fsr3.1 DX12','dlss DX12','fsr2.1 Vulkan','fsr2.2 Vulkan ','fsr3.1 Vulkan','dlss Vulkan']

for addon_dx12_op in addon_dx12:
    addon_ups_dx12_listbox.insert(tk.END,addon_dx12_op)

def update_options_optiscaler(event=None):
    global select_options_optiscaler
    index_options_optiscaler = options_optiscaler_listbox.curselection()
    if index_options_optiscaler:
        select_options_optiscaler = options_optiscaler_listbox.get(index_options_optiscaler)
        options_optiscaler_canvas.delete('text')
        options_optiscaler_canvas.create_text(2,8,anchor='w',text=select_options_optiscaler,fill='black',tags='text')
    
    if select_options_optiscaler in options_optiscaler_opt:
        update_optiscaler_ini()

    options_optiscaler_canvas.update()
    
options_optiscaler_opt = ['Enable overlay menu','CAS sharpening for XeSS','Override DLSS sharpness','Force INVERTED_DEPTH','Force HDR_INPUT_COLOR','Force ENABLE_AUTOEXPOSURE','Enable Output Scaling','Hook SLDevice','Hook SLProxy','Sharpening Amplifier','Fake Nvidia GPU for DXGI','Fake Nvidia GPU for Vulkan','Dxgi Xess No Spoof','Override Nvapi Dll','Restore Default']
for options_optiscaler_op in options_optiscaler_opt:
    options_optiscaler_listbox.insert(tk.END,options_optiscaler_op)

def update_uni_custom(event=None):
    global select_uni_custom
    index_uni_custom = uni_custom_listbox.curselection()
    if index_uni_custom:
        select_uni_custom = uni_custom_listbox.get(index_uni_custom)
        uni_custom_canvas.delete('text')
        uni_custom_canvas.create_text(2,8,anchor='w',text=select_uni_custom,fill='black',tags='text')
    
    if select_mod in list_uni:
        uni_custom_canvas.config(bg='white')
        uni_custom_preset()
    elif select_mod not in list_uni or not uni_custom_contr:
        uni_custom_canvas.config(bg='#C0C0C0')
        uni_custom_listbox.place_forget()
        uni_custom_cbox.deselect()

    uni_custom_canvas.update()

uni_custom_options = ['1080p' ,'1440p','2160p']
for uni_custom_op in uni_custom_options:
    uni_custom_listbox.insert(tk.END,uni_custom_op)

game_options_canvas.bind('<Button-1>',select_game_listbox_view)
game_options_canvas.bind('<Enter>',change_cursor)
game_options_canvas.bind('<Leave>',revert_cursor)
game_options_listbox.bind("<<ListboxSelect>>",update_canvas)
fsr_canvas.bind('<Button-1>',fsr_listbox_visible)
fsr_listbox.bind("<<ListboxSelect>>",update_fsr_v)
fakegpu_label.bind('<Enter>',guide_fk_gpu)
fakegpu_label.bind('<Leave>',close_fk_gpu_guide)
select_folder_canvas.bind('<Button-1>',open_explorer)
select_folder_canvas.bind('<Enter>',change_cursor)
select_folder_canvas.bind('<Leave>',revert_cursor)
epic_over_browser_canvas.bind('<Button-1>',epic_explorer)
epic_over_browser_canvas.bind('<Enter>',change_cursor)
epic_over_browser_canvas.bind('<Leave>',revert_cursor)
epic_over_enable_label.bind('<Button-1>',enable_epic_over)
epic_over_disable_label.bind('<Button-1>',disable_epic_over)
epic_over_auto_label.bind('<Button-1>',epic_dis_over)
mod_version_canvas.bind('<Button-1>',mod_listbox_view)
mod_version_canvas.bind('<Enter>',change_cursor)
mod_version_canvas.bind('<Leave>',revert_cursor)
mod_version_listbox.bind("<<ListboxSelect>>",update_mod_version)
sharpness_value_label_up.bind('<Button-1>',cont_sharpness_value_up)
sharpness_value_label_up.bind('<ButtonRelease-1>',color_sharpness_value_up)
sharpness_value_label_down.bind('<Button-1>',cont_sharpness_value_down)
sharpness_value_label_down.bind('<ButtonRelease-1>',color_sharpness_value_down)
sharpness_label.bind('<Enter>',guide_sharp_over)
sharpness_label.bind('<Leave>',close_sharp_overguide)
mod_operates_listbox.bind('<<ListboxSelect>>',update_mod_operates)
mod_operates_canvas.bind('<Button-1>',mod_operates_view)
fg_mode_listbox.bind('<<ListboxSelect>>',update_fg_mode)
fg_mode_canvas.bind('<Button-1>',fg_mode_view)
fsr_ultraq_label_up.bind('<Button-1>',fsr_ultraq_up_custom)
fsr_ultraq_label_up.bind('<ButtonRelease-1>',color_fsr_ultraq_up)
fsr_ultraq_label_down.bind('<Button-1>',fsr_ultraq_down_custom)
fsr_ultraq_label_down.bind('<ButtonRelease-1>',color_fsr_ultraq_down)
fsr_quality_label_up.bind('<Button-1>',fsr_quality_up_custom)
fsr_quality_label_up.bind('<ButtonRelease-1>',color_fsr_quality_up)
fsr_quality_label_down.bind('<Button-1>',fsr_quality_down_custom)
fsr_quality_label_down.bind('<ButtonRelease-1>',color_fsr_quality_down)
fsr_balanced_label_up.bind('<Button-1>',fsr_balanced_up_custom)
fsr_balanced_label_up.bind('<ButtonRelease-1>',color_fsr_balanced_up)
fsr_balanced_label_down.bind('<Button-1>',fsr_balanced_down_custom)
fsr_balanced_label_down.bind('<ButtonRelease-1>',color_fsr_balanced_down)
fsr_performance_label_up.bind('<Button-1>',fsr_perf_up_custom)
fsr_performance_label_up.bind('<ButtonRelease-1>',color_fsr_perf_up)
fsr_performance_label_down.bind('<Button-1>',fsr_perf_down_custom)
fsr_performance_label_down.bind('<ButtonRelease-1>',color_fsr_perf_down)
fsr_ultrap_label_up.bind('<Button-1>',fsr_ultrap_up_custom)
fsr_ultrap_label_up.bind('<ButtonRelease-1>',color_fsr_ultrap_up)
fsr_ultrap_label_down.bind('<Button-1>',fsr_ultrap_down_custom)
fsr_ultrap_label_down.bind('<ButtonRelease-1>',color_fsr_ultrap_down)
native_res_label_up.bind('<Button-1>',native_res_up_custom)
native_res_label_up.bind('<ButtonRelease-1>',color_native_up)
native_res_label_down.bind('<Button-1>',native_res_down_custom)
native_res_label_down.bind('<ButtonRelease-1>',color_native_down)
nvngx_canvas.bind('<Button-1>',nvngx_cbox_view)
nvngx_listbox.bind('<<ListboxSelect>>',update_nvngx)
nvapi_label.bind('<Enter>',guide_nvapi)
nvapi_label.bind('<Leave>',close_nvapiguide)
dxgi_canvas.bind('<Button-1>',dxgi_cbox_view)
dxgi_listbox.bind('<<ListboxSelect>>',update_dxgi)
dxgi_label.bind('<Enter>',guide_dxgi)
dxgi_label.bind('<Leave>',close_dxgi_guide)
nvngx_label.bind('<Enter>',guide_nvngx)
nvngx_label.bind('<Leave>',close_nvngx_guide)
addon_mods_canvas.bind('<Button-1>',addon_mods_view)
addon_mods_listbox.bind('<<ListboxSelect>>',update_addon_mods)
addon_ups_dx12_canvas.bind('<Button-1>',addon_dx12_view)
addon_ups_dx12_listbox.bind('<<ListboxSelect>>',update_addon_dx12)
options_optiscaler_canvas.bind('<Button-1>',options_optiscaler_view)
options_optiscaler_listbox.bind('<<ListboxSelect>>',update_options_optiscaler)
uni_custom_canvas.bind('<Button-1>',uni_custom_res_view)
uni_custom_listbox.bind('<<ListboxSelect>>',update_uni_custom)
ue_label.bind('<Enter>',guide_ue)
ue_label.bind('<Leave>',close_ueguide)
macos_sup_label.bind('<Enter>',guide_mcos)
macos_sup_label.bind('<Leave>',close_mcosguide)
mod_operates_label.bind('<Enter>',guide_mod_op)
mod_operates_label.bind('<Leave>',close_mod_opguide)
fg_mode_label.bind('<Enter>',guide_fg_mode)
fg_mode_label.bind('<Leave>',close_fg_modeguide)
disable_console_label.bind('<Enter>',guide_dis_con_op)
disable_console_label.bind('<Leave>',close_dis_conguide)
debug_tear_lines_label.bind('<Enter>',guide_debug_op)
debug_tear_lines_label.bind('<Leave>',close_debugguide)
debug_view_label.bind('<Enter>',guide_debug_view_op)
debug_view_label.bind('<Leave>',close_debug_viewguide)
enable_sigover_label.bind('<Enter>',guide_en_sig)
enable_sigover_label.bind('<Leave>',close_en_sigguide)
epic_over_label.bind('<Enter>',guide_epic)
epic_over_label.bind('<Leave>',close_guide_epic)
fsr_guide_label.bind('<Enter>',guide_fsr_guide)
fsr_guide_label.bind('<Leave>',close_guide_fsr)
addon_mods_label.bind('<Enter>',guide_addon_mods)
addon_mods_label.bind('<Leave>',close_addon_guide)
addon_ups_dx12_label.bind('<Enter>',guide_addon_dx12)
addon_ups_dx12_label.bind('<Leave>',close_addon_dx12)
ignore_ingame_fg_label.bind('<Enter>',guide_ignore_ingame_fg)
ignore_ingame_fg_label.bind('<Leave>',close_guide_ignore_ingame_fg)
ignore_ingame_fg_resources_label.bind('<Enter>',guide_ignore_ingame_fg_resources)
ignore_ingame_fg_resources_label.bind('<Leave>',close_guide_ignore_ingame_fg_resources)
fps_user_entry.bind("<Key>", fps_isdigit)
install_label.bind('<Button-1>',install)
install_label.bind('<ButtonRelease-1>', install_false)

exit_label.bind('<Button-1>',exit_screen)

screen.mainloop()