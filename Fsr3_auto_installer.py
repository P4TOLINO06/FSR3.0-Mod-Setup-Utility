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

def uac():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

unlock_screen = True
def run_as_admin():
    global unlock_screen
    if uac():
        unlock_screen = True
    else:
        unlock_screen = False
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 1)

run_as_admin()

screen = tk.Tk()
screen.title("FSR3.0 Mod Setup Utility - 2.6.12v")
screen.geometry("700x620")
screen.resizable(0,0)
screen.configure(bg='black')
def exit_screen(event=None):
    sys.exit()
screen.protocol('WM_DELETE_WINDOW',exit_screen)
if not unlock_screen:
    sys.exit()

icon_image = tk.PhotoImage(file="images\FSR-3-Supported-GPUs-Games.gif")
screen.iconphoto(True, icon_image)

change_text = False
try:
    font_select = ("Segoe UI", 11,'bold')

    var_font = tk.Label(screen,text=".", font=font_select,fg="black", bg="black")
except tk.TclError:
    font_select = tkFont.Font(family="Arial",size=10)
    change_text = True

title_page = tk.Label(screen, text="FSR 3 Mods", font=("Arial", 11, "bold"), fg="#778899", bg="black") 
title_page.pack(anchor='w',pady=0)

select_label = tk.Label(screen, text="Game select:",font=font_select,bg='black',fg='#C0C0C0')
select_label.place(x=0,y=33)

fsr_label = tk.Label(screen,text='FSR:',font=font_select,bg='black',fg='#C0C0C0')
fsr_label.place(x=313,y=33)
canvas_options = Canvas(screen,width=200,height=15,bg='white')
canvas_options.place(x=101,y=37)

exit_label = tk.Label(screen,text='Exit',font=font_select,bg='black',fg='#E6E6FA')
exit_label.place(x=355,y=515)

install_label = tk.Label(screen,text='Install',font=font_select,bg='black',fg='#E6E6FA')
install_label.place(x=295,y=515)

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
        default_path = os.path.join(disk_name, r'Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay')
        if os.path.exists(default_path):
            for root, dirs, files in os.walk(default_path):
                if exe_name in files or txt_name in files:
                    path_over = os.path.join(root)
                    break
            if path_over:
                break
        
        alt_path = os.path.join(disk_name, r'Epic Games\Launcher\Portal\Extras\Overlay')
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
    epic_label_guide.place(x=0,y=480)
    epic_label_guide.lift()

def close_guide_epic(event=None):
    epic_label_guide.place_forget()

epic_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
epic_label_guide.place_forget()

epic_over_label = tk.Label(screen,text='Epic Games Overlay:',font=font_select,bg='black',fg='#C0C0C0')
epic_over_label.place(x=0,y=455)

epic_over_canvas = tk.Canvas(screen,width=162,height=19,bg='white',highlightthickness=0)
epic_over_canvas.place(x=152,y=460)

epic_over_browser_canvas = tk.Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
epic_over_browser_canvas.create_text(0,8,anchor='w',font=(font_select,9,'bold'),text='Browser',fill='black')
epic_over_browser_canvas.place(x=340,y=460)

epic_over_marc_label = tk.Label(screen,text='–',font=font_select,bg='black',fg='#C0C0C0')
epic_over_marc_label.place(x=319,y=455)

epic_over_disable_label = tk.Label(screen,text='Disable',font=font_select,bg='black',fg='#E6E6FA')
epic_over_disable_label.place(x=330,y=485)

epic_over_enable_label = tk.Label(screen,text='Enable',font=font_select,bg='black',fg='#E6E6FA')
epic_over_enable_label.place(x=270,y=485)

epic_over_auto_label = tk.Label(screen,text='Auto Search',font=font_select,bg='black',fg='#E6E6FA')
epic_over_auto_label.place(x=175,y=485)

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
fsr_guide_label.place(x=260,y=393)
fsr_guide_var = tk.IntVar()
fsr_guide_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=fsr_guide_var,command=fsr_guide)
fsr_guide_cbox.place(x=347,y=395)

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
    
    s_games_op = ['Initial Information','Add-on Mods','Optiscaler Method','Achilles Legends Untold','Alan Wake 2','Alone in the Dark','A Plague Tale Requiem','Assassin\'s Creed Valhalla','Atomic Heart','Baldur\'s Gate 3','Black Myth: Wukong','Blacktail','Banishers Ghost of New Eden','Bright Memory: Infinite','Brothers a Tale of Two Sons','Chernobylite','Cod Black Ops Cold War','Cod MW3','Control','Crime Boss Rockay City','Cyberpunk 2077',
                'Dakar Desert Rally','Dead Space Remake','Dead Island 2','Death Stranding Director\'s Cut','Deathloop','Dragons Dogma 2','Dying Light 2','Elden Ring','Everspace 2','Evil West','Fallout 4','Final Fantasy XVI','Fist Forged in Shadow Torch','Flintlock: The Siege of Dawn','Fort Solis','Forza Horizon 5','F1 2022','F1 2023','GTA V','Ghost of Tsushima','Ghostrunner 2','Ghostwire: Tokyo','Hellblade: Senua\'s Sacrifice','Hellblade 2','High On Life','Hitman 3','Hogwarts legacy','Horizon Forbidden West','Icarus','Judgment','Jusant',
                'Kena: Bridge of Spirits','Layers of Fear','Lies of P','Loopmancer','Lords of the Fallen','Manor Lords','Martha Is Dead','Marvel\'s Guardians of the Galaxy','Metro Exodus Enhanced','Monster Hunter Rise','Nobody Wants To Die','Outpost Infinity Siege','Pacific Drive','Palworld','Ratchet and Clank','Rise of The Tomb Raider','Ready or Not','Red Dead Redemption 2','Red Dead Redemption 2 MIX','Red Dead Redemption Mix 2','Red Dead Redemption V2','RDR2 Non Steam',
                'Returnal','Ripout','Saints Row','Sackboy: A Big Adventure','Shadow of the Tomb Raider','Shadow Warrior 3','Smalland','Spider Man/Miles','Star Wars: Jedi Survivor','Star Wars Outlaws','Steelrising','TEKKEN 8','The Chant','The Callisto Protocol','The Invicible','The Medium',"The Outer Worlds: Spacer's Choice Edition",'The Thaumaturge','The Witcher 3','Uncharted','Wanted Dead','Uniscaler','XESS/DLSS']
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
'1 - When selecting the game folder, look for the game\'s .exe file. Some games have the full name .exe or abbreviated,\n while others have the .exe file in the game folder but within subfolders with the ending\nBinaries\Win64, and the .exe usually ends with Win64-Shipping, for example: TheCallistoProtocol-Win64-Shipping.\n'
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

'Achilles Legends Untold':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Check the box for Fake Nvidia GPU (AMD/GTX only).\n'
'3 - If the mod doesn\'t work, check the Nvapi Results box and\nselect Default in NVNGX.dll.\n'
'4 - In-game, select DLSS.'    
),

'Alan Wake 2':(
'RTX\n'
'1 - Select Alan Wake 2 FG RTX and install it.\n'
'2 - In the game, select DLSS and enable Frame Generation.\n'
'3 - It is also possible to use other versions of the mod.\n\n'

'AMD/GTX\n'
'1 - Select Alan Wake 2 Uniscaler Custom and install it.\n'
'2 - In the game, select DLSS and enable Frame Generation\nif it is not enabled by default.\n'
'3 - Do not switch to FSR as the game will crash.\n'
'4 - It is also possible to use other versions of the mod,\nexcept Alan Wake 2 FG RTX.\n'    
),

'Alone in the Dark':(
"1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n"
"2 - Enable the 'Enable Signature Override' checkbox.\n"
"3 - Enable Fake Nvidia GPU, if you want to use DLSS (Only\nfor AMD GPUs).\n"
"4 - Set FSR in the game settings.\n"
"5 - If the mod doesn't work, elect 'Default' in Nvngx.dll."
),

'A Plague Tale Requiem':(
'1 - Select a mod of your choice (0.10.3 is recommended).\n'
'2 - Check the box for Fake Nvidia GPU (AMD/GTX) and\nNvapi Results (GTX). (If the mod doesn\'t work for AMD, also\ncheck Nvapi Results)\n'
'3 - To fix hub flickering, enable DLSS and Frame Generation\nand play for a few seconds, then disable DLSS and leave\nonly Frame Generation enabled.'  
),

'Assassin\'s Creed Valhalla':(
'1 - Press the "End" key to open the Frame Gen menu or the\n"Home" key to open the main menu.\n'
'2 - Select AC Valhalla DLSS3\n'
'3 - In the game, enable Motion Blur and disable FSR'   
),

'Atomic Heart':(
'1 - Select a mod of your choice (0.10.3 is recommended).\n'
'2 - In the game, select FSR.'   
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
'1 - Select \'RTX DLSS FG Wukong\' and install.\n'
'2 - In the game, select DLSS and Frame Generation.\n\n'
'AMD/GTX DLSS FG\n'
'1 - Select Optiscaler FSR 3.1/DLSS and install it.\n'
'2 - In the game, press the \'Insert\' key to open\nthe menu, and in the menu, select the upscaler you want to use.\n\n'

'Graphic Preset\n'
'1 - Install the mod and the ReShade application\n'
'2 - In ReShade, select b1.exe, DirectX 10/11/12,\nclick on \'Browser\', and find the file Black Myth Wukong.ini (the path should\nlook something like BlackMythWukong\Black Myth Wukong.ini) and select it, then click on \'Uncheck All\' and \'Next\'.\n'
'3 - In the game, press the \'Insert\' key to open\nthe menu and check the options you want.\n\n'

'Optimized Wukong\n'
'Faster Loading Times - By tweaking async-related settings:\n' 
'AsyncLoadingThread\n' 
'the mod allows assets to load in the background, reducing loading times\n' 
'and potentially eliminating loading pauses during gameplay.\n' 

'Optimized CPU and GPU Utilization - by tweaking multi-core rendering:\n' 
'MultiCoreRendering\nand multi-threaded shader compilation:\n' 
'MultiThreadedShaderCompile*\n' 
'allows the game to utilize the full potential of modern CPUs and GPUs.\n' 
'This can result in improved performance, higher frame\n' 
'rates, and more stable gameplay.\n' 

'Enhanced Streaming and Level Loading - By tweaking various streaming\nvariables:\n' 
'r.Streaming.\n s.LevelStreamingComponents*\n' 
'the mod improves the efficiency of streaming assets and\n' 
'level loading. This can lead to faster streaming and reduced stuttering\n' 
'when moving through different areas of the game world.\n' 

'Optimized Memory Management - By adjusting memory-related settings:\n' 
'MinBulkDataSizeForAsyncLoading & ForceGCAfterLevelStreamedOut*\n' 
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
  '2 -  To make the mod work, run it in DX12. To run it in DX12, right-click the game\'s\nexe and create a shortcut, then right-click the shortcut again,\ngo to \"Properties,\" and at the end of \"Target\" (outside the\nquotes), add -dx12 or go to your Steam library, select the\ngame, go to Settings > Properties > Startup options, and\nenter -dx12.'
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
'1 - Select the game path: CallofDuty\Content\sp23\n'
'2 - Select the COD MW3 FSR3 mod and install it\n'
'3 - In the game, select DLSS Frame Generation\n'
),

'Control':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Check the Fake Nvidia Gpu box. (Amd/Gtx).\n'
'3 - Check the Enable Signature Override box.\n'
'4 - Before installing, configure the game as you wish, do not\nchange the settings or turn off DLSS after the mod is\ninstalled, as the game will crash.'    
),

'Crime Boss Rockay City':(
'1 - Select a mod of your choice (0.10.4 is recommended).\n'
'2 - Check the Fake Nvidia GPU box for AMD/GTX users.\nIf you can\'t see DLSS in the game, check the Nvapi Results\nand UE Compatibility Mode boxes.\n'
'3 - In the game, turn off Anti-Aliasing and select DLSS as\nthe upscaler.'  
),

'Cyberpunk 2077':(
'1 - Select a mod of your choice (Uniscaler is recommended).\n'
'2 - Select Default in Nvngx.dll.\n'
'3 - Check the box Enable Signature Override.\n'
'4 - In-game, turn off Vsync, select DLSS (do not select auto\nas the game will crash), and turn on Frame Generation.\n\n'    

'ReShade\n'
'1 - Download and install ReShade.\n'
'2 - Select Cyberpunk 2077 and check all effects (you can also\nuse \'Uncheck all\' and \'Check all\' to select everything at once).\n' 
'3 - Install the mod using the Utility.\n'
'4 - In the game, press the Home key.\n'
'5 - Skip the tutorial if needed, select the preset from the top\nbar of the interface, and click \'Select\'.'
),

'Dakar Desert Rally':(
'1- Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Check the box Fake Nvidia GPU and Nvapi Results\n(AMD/GTX).\n'
'In-game, select DLSS and Frame Generation.'    
),

'Dead Island 2':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - If it doesn\'t work with the default files, enable\nEnable Signature Override. If it still doesn\'t work, check the\nbox lfz.sl.dlss.\n'
'3 - It\'s not necessary to activate an upscaler for this game\nfor the mod to work, so enable it if you want.'
),

'Death Stranding Director\'s Cut':(
'1 - Select a mod of your preference (0.10.3 or Uniscaler is\nrecommended).\n'
'2 - Check the box for Fake Nvidia GPU (AMD/GTX).\n'
'3 - Inside the game, select DLSS or FSR.\n'
'4 - If you encounter problems related to DX12, select D3D12\nin Dxgi.dll.\n'
'5 - The mod only works on the Director\'s Cut version.'    
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

'Deathloop':(
  '1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n' 
  '2 - Activate Fake Nvidia Gpu and Nvapi Results (Only for\nAMD and GTX) ' 
),

'Dragons Dogma 2':(
'1 - Select Deput8 in Mod Select and install.\n'
'2 - Open the game after Deput8 is installed, a "REFramework" menu will\nappear. Click on it, go to Settings and Menu Key, click on Menu Key,\nand select the preferred key (the key is used to open and close the menu).\n'
'3 - Close the game, in Utility select Uniscaler_DD2 in Mod\nVersion and install (it is recommended to select "Yes" when the message\nto delete the shader file appears).\n'
'4 - Inside the game, select FSR3 to enable the mod.\n\n'
'•It is recommended to turn off any type of upscaler before\nopening the game with the mod.\n'
'•To fix the Hud, select Dynamic Resolution and turn off FSR3\n(after turning it on for the first time), this will slightly decrease the fps.'
),

'Dying Light 2': (      
'Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Enable Fake Nvidia GPU (only for AMD and GTX).\n'
'3 - In the game, select any upscaler and activate Frame\nGeneration.\n'
'4 - If you experience any flickering or ghosting, go to Video >\nAdvanced Settings and decrease the Lod Range Multiplier.'
),

'Elden Ring': (
'1 - Select "Disable AntiCheat" in the Select Mod and choose "Yes" in the anticheat deactivation\nconfirmation window. Select the folder where the game exe is located, otherwise, it will not be\npossible to deactivate the anticheat. (Steam Only)\n'
'2 - Select "Elden Ring FSR3" in Select Mod and install it.\n'
'3 - Inside the game, press the "Home" key to open the mod menu. In "Upscale Type," select the\nUpscaler according to your GPU (DLSS Rtx or FSR3 non-Rtx), then check the box "Enable\nFrame Generation" below.\n'
'• To remove Full Screen borders, select "Full Screen" in the game before installing the mod. If\nthere is screen overflow after mod installation, select full screen -> window -> full screen.\n'
'• Enable AntiAliasing and Motion Blur; this mod will skip the actual rendering of motion blur, so\ndon\'t worry if you don\'t like motion blur. The game only needs it to render motion vectors.'
),

'Everspace 2':(
'1 - Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Check Fake Nvidia Gpu and Nvapi Results.\n'
'3 - Inside the game, select FSR or DLSS'   
),

'Evil West':(
'1 - Select a mod of your preference. (recommended 0.10.3)\n'
'2 - Install, within the game, set post-processing to low and\nactivate FSR.'   
),

'Fallout 4':(
  'Usage of the Sym Link:\n'
'1 - In SymLink, click on add file and navigate to the root folder of the game. In the root folder, look\nfor Data\F4SE\Plugins, within this folder select Fallout4Upscaler.dll.\n'
'2 - In "Destination Path" in the Sym Link, paste the path of the "mods" folder. Simply navigate to\nthe mods folder and copy the path from the address bar of the file explorer, or you can navigate to\nthe folder through the Sym Link itself.\n'
'3 - Click on Create symlinks.\n'
'4 - Go back to the mods folder, go to View (w10) or Options (w11), and uncheck the box "File\nname extensions.\n'
'5 - Rename the file Fallout4Upscaler.dll in the mods folder to RDR2Upscaler.org.\n'
'6 - Run the game launcher located in the root folder of the game, in the launcher set "depth of\nfield" to Low.\n'
'7 - Run the game using the file f4se_loader.exe, also located in the root folder of the game.\n'
'8 - In the game, press the "END" key to open the mod menu, select DLSS for RTX and FSR3 for\nnon-RTX.' 
),

'Fist Forged in Shadow Torch':(
 '1 - Select a mod of your choice. (0.10.3 is recommended)\n'
'2 - Check the Fake Nvidia GPU box (AMD/GTX)'   
),

'Flintlock: The Siege of Dawn':(
'1 - Select the FSR 3.1/DLSS Optiscaler mod and install it.\n'
'2 - In the game, select DLSS, press the Insert key to open\nthe Optiscaler menu, in Upscalers select an upscaler of your\npreference. If you cannot see the menu, after installing the\nmod, select Optiscaler in the Utility and choose an upscaler\nin Upscaler Optiscaler and install.'
),

'Fort Solis':(
'Select a mod of your preference. (0.10.3 is recommended)\n'
'2 - Check the box for Fake Nvidia GPU (AMD/GTX) and the\nbox for Nvapi Results (GTX). If DLSS is not available for AMD,\ncheck the Nvapi Results box.\n'
'3 - In the game, select DLSS and Frame Generation.'    
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

'GTA V':(
"Single Player and Multiplayer\n"
'1 - Select Dinput 8 and install. (only single player)\n'
'2 - Open the game and disable MSAA and TXAA and select\nborderless window. If the mod doesn\'t work, disable FXAA.\n'
'3 - Close the game and select GTA V FSR3 and install\n'
'4 - Turn on Vsync, Nvidia (Vertical Sync), or AMD Adrenalin\n(Wait for Vertical Sync Update)\n'
'5 - Press "Home" to open the menu. If the mod is disabled,\ncheck "Enable Frame Generation".'  
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
'2 - To make the mod work, run it in DX12. To run it in DX12, right-click\nthe game exe and create a shortcut, then right-click the shortcut\nagain, go to \"Properties,\" and at the end of \"Target\" (outside the\nquotes), add -dx12 or go to your Steam library, select the game, go to\nSettings > Properties > Startup options, and enter -dx12.\n'
'3 - Activate Fake Nvidia Gpu (AMD only)\n'
'4 - Inside the game, set the frame limit to unlimited, activate DLSS first\n(disable other upscalers before) and then activate frame generation\n'
'• To fix the flickering of the HUD, activate and deactivate frame\ngeneration again (no need to apply settings).'
),

'Ghostwire: Tokyo':(
'1- Select Uniscaler V3\n'  
'2 - Check the Fake Nvidia GPU box (AMD/GTX). If you can\'t\nsee DLSS in the game, also check the Nvapi Results box.\n'
'3 - Check the Nvngx.dll box and select Default, then check\nthe Enable Signature Override box.\n'
'4 - In the game, select DLSS to enable Frame Generation.\n'  
'5 - To fix the HUD glitch, switch between the upscalers (FSR,\nDLSS, etc.) until the HUD stops flickering.'
),

'Hellblade: Senua\'s Sacrifice':(
'1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n'
'2 - Select Fake Nvidia Gpu and UE Compatibility (AMD only),\nselect Fake Nvidia Gpu and Nvapi Results (GTX only).'
),

'Hellblade 2':(
'Only RTX\n'
'1 - Select Hellblade 2 FSR3 and install it.\n'
'2 - In the game, select Frame Generation.\n'
'3 - This mod only works for RTX.\n\n'
'All GPUs\n'
'1 - Select Uniscaler V2 (you can also test with the other mods)\n'
'2 - Check the box for Fake Nvidia GPU (AMD) and check the\nbox for UE compatibility mode (AMD and Nvidia)\n'
'3 - In-game, select Frame Generation\n'
'• If you can\'t see the DLSS option in the game, select\n"YES" in the "DLSS Fix" window during installation. \n\n'
'• To remove the black bars, select the Engine.ini file folder in\n\'Select Folder\' (if the file is not found automatically), select\n\'Remove Black Bars\' in mod version, and install. (The path to\nthe engine.ini file is something like: C:\\Users\\YourName\\\nAppData\\Local\\Hellblade2\\Saved\\Config\\Windows or\nWinGDK)\n\n' 
'• If the bars are not removed, select \'Remove Black Bars Alt\',\nthe removal of the black bars will be automatically performed if\nthe Engine.ini file is found. If it is not found, you need to select\nthe path in \'Select Folder\' and press \'Install\'.\n\n' 
'• To remove only the main effects, such as Lens Distortion,\nBlack Bars, and Chromatic Aberration, select Remove Post\nProcessing.\n\n'
'• To remove all effects, select Remove All Post Processing\n(includes film grain).\n\n'
'• To restore the Post Processing effects, simply select\n\'Restore Post Processing\', and the Engine.ini file will be replaced\nwith the default file.\n\n'
'• If the Frame Generation is not visible, remove the black bars.'
),

'High On Life':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Enable Fake Nvidia Gpu.(only Amd and Gtx)'
),

'Hogwarts legacy':(
"1 - Select a version of the mod of your choice (versions from 0.9.0\nonwards are recommended to fix UI flickering).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the mod\ndoesn't work.\n"
"3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n"
"4 - Select 'Default' in Nvngx.dll."
),

'Hitman 3':(
'Select a mod of your preference. (0.10.3 is recommended\nbut if it doesn\'t work, try 0.10.2)\n'
'2 - Check the box for Fake Nvidia GPU (AMD/GTX).\n'
'3 - In the game, select FSR and Frame Generation. If Frame\nGeneration is not available, you can check the Nvapi Results\nbox or download the file EnableDLSSFrameGenerationHitma\nnIII.reg and run it. This will activate Frame Generation even if\nit is not available.'  
),

'Horizon Forbidden West':(
'1 - Select Horizon Forbidden West FSR3 and install\n'
'2 - Choose Xess or FSR on the initial setup screen, turn on Frame\nGeneration, and do not select DLSS, otherwise the game will crash\n'
'3 - In-game, select the Low quality preset, then adjust the settings as\ndesired, but do not modify options below Hair Quality\n'
'4 - Select Xess or FSR.'
),

'Icarus':(
'1 - Select Icarus FSR3 in mod version.\n'
'2 - If the option selected is RTX, confirm the window that appears.\n'
'3 - If the option is AMD/GTX and you notice that the mod is not generating FPS, open\nthe file fsr2fsr3.config and replace "mode = default" on the first line with "replace_dlss_fg",\nkeep it inside the quotation marks, it will look like this: mode = "replace_dlss_fg".\n'
'4 - Start the game in DX12, if the game exe is in the destination folder where the mod was\ninstalled, a DX12 shortcut will be created on your Desktop. If the exe is not found, you\nneed to create a shortcut and in the properties, at the end of Target, add -dx12 outside the\nquotes if there are any, don\'t forget to put a space between -dx12 and the path.\n'  
'5 - Run the game through the executable.'
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

'Kena: Bridge of Spirits': (
  '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n'  
  '2 - Activate Fake Nvidia Gpu and Nvapi Results (AMD only).'
),

'Layers of Fear':(
 '1 - Select a mod of your preference (0.10.3 is recommended)\n'   
 '2 - Check the box Fake Nvidia GPU.(AMD/GTX)\n'
 '3 - If you don\'t notice Frame Generation, select Replace\nDLSS FG in \'Mod Operates\'.\n'
 '4 - In the game, select Frame Generation and DLSS or FSR'
),

'Lies of P':(
'1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n'
'2 - Activate Fake Nvidia Gpu and UE Compatibility Mode\n(AMD only).\n'
'3 - To fix the flickering of the Hud, first select DLSS Quality,\nthen select FSR Quality (without disabling DLSS), then\nselect DLSS again.'
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

'Marvel\'s Guardians of the Galaxy':(
 '1 - Select a version of the mod of your choice (it is recommended 0.10.3\nonwards or Uniscaler)\n'
'2 - Select the folder where the game\'s exe is located (something like\ngotg.exe)\n'
'3 - Activate Fake Nvidia GPU (if you don\'t have Rtx 3xxx/4xxx series)\n'
'4 - Inside the game, select DLSS or FSR\n'
'• If you want to use Uniscaler with the DLSS upscaler, select DLSS in\nMod Operates (the default option of Uniscaler uses the FSR upscaler)\n'
'• If the game is on Epic Games, it is necessary to disable the Overlay,\nsimply go to \'Epic Games Overlay\'.'  
),

'Metro Exodus Enhanced':(
'Select Uniscaler.\n'
'2 - Check the boxes for Fake Nvidia GPU (AMD/GTX) and\nNvapi Results (GTX). If the DLSS option is not available for\nAMD GPU, check the Nvapi Results box.\n'
'3 - In Nvngx.dll, select Default and check the box Enable\nSignature Override.\n'
'4 - In the game, select DLSS.'    
),

'Monster Hunter Rise':(
'1 - Select a mod of your choice. (recommended 0.10.3)\n'
'2 - Check the box Fake Nvidia GPU.\n'
'3 - If you don\'t see any differences, check the box\nNvapi Results.\n'
'4 - To fix flickering in the hud, activate DLSS and play for a\nfew seconds, then return to the menu and deactivate DLSS.'
),

'Nobody Wants To Die':(
'1 - Select Uniscaler FSR 3.1\n'
'2 - For AMD/GTX users: Check the boxes for Fake Nvidia\nGPU, Ue compatibility Mode, Nvapi Results and Disable\nSignature Over.'
),

'Outpost Infinity Siege':(
'1 - Select a mod of your preference; (0.10.3 is recommended)\n'
'2 - Check the box Fake Nvidia GPU (AMD/GTX).\n'
'3 - In the game, select DLSS and Frame Generation.\n'
'4 - If you have any issues, in Nvngx.dll, select Default.'   
),

'Pacific Drive':(
'1 - Select a mod of your preference, (0.10.3 is recommended)\n'
'2 - Check the box Fake Nvidia GPU (AMD/GTX).\n'
'3 - If you have any issues, in Nvngx.dll, select Default.'  
),

'Palworld':(
'For standard mods (0.10+ and Uniscaler), simply enable \nthe fake Nvidia GPU (for AMD and GTX) and UE Compatibility\nmode (for AMD) and set the game to DX12. Throughout the\nguide, it will be explained how to do this.\n\n'
'1. Select Palworld Build03 and locate the game folder with the\nending binaries/win64 and see if the executable with the ending\nWin64-shipping.exe is present.\n'
'2. Install, confirm the GPU selection window that will appear.\n'
'3. To run the game in DX12, simply confirm the window that\nappears after confirming the GPU selection. Make sure the\nmentioned exe is in the selected folder. Alternatively, you can\nignore the window and do it manually, by creating a shortcut\nand adding \'-dx12\' after the quotes in the \'Target\' field.\n'
'4. Run the game through the shortcut.\n\n'
'• Currently, the mod only works on Steam versions and \nalternative versions with Steam files.'  
),

'Ratchet and Clank':(
'1 - Select a mod of your preference (0.10.3 is recommended,\nbut you can also try with Uniscaler).\n'
'2 - If you encounter any issues, select Replace DLSS FG in\n\'Mod Operates\'.\n'
'3 - In the initial configuration screen, select Frame\nGeneration and FSR.\n'
'4 - In the game, turn off Frame Generation and then turn it\nback on again.'    
),

'Ready or Not': (
'1 - Select a version of the mod of your choice (version\n0.10.3 is recommended).\n'
'2 - Select the game folder that has the ending\n"\ReadyOrNot\Binaries\Win64".\n'
'3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n'
'4 - Set Anti-Aliasing to High or Epic + FSR2 Quality\n(DLSS won\'t work with UI flickering fix).\n'
'5 - UI flickering fix: Change Anti-Aliasing from Epic or High\nto Medium.\n'
'After launching the game again, you need to set\nAnti-Aliasing back to High or Epic to activate the mod before\nplaying the character.'
),

'Red Dead Redemption 2':(
"● RDR2_Build_2\n"
"1 - Launch the game, go to settings turn off Triple buffering + V-sync, unlock\nadvanced settings, and change API to DX12 Then restart the game, turn\n on dlss (RTX) or fsr2 (non-RTX) (Required settings before playing the game)\n\n"
"•Attention,don't install another version of the Reshade app after using this mod\n\n"
"If your game is still not open after turning Off Afterburner and Rivatuner, try\nsetting Run this program as administrator and Run this program in compatibility\nmode for Windows 7 of the Compatibility tab of the Properties in the right\nmouse menu.\n\n"
"2 -'While playing press the hotkey 'End' to go to the mod menu \n(don't set anything in the lobby (main game menu before playing),\nif you turn frame generation On or Off may cause an ERR_GFX_STATE error),\nset dlss (RTX) or fsr3 (non-RTX), and toggle frame generation Off and On again.\nIf you have a black screen check Upscale Type in the menu mod again,\nchange from dlss to fsr3\n\n"
"3 - Check again with the toggle enable UI Hud Fix On or Off. If you see UI\nflickering when turning Enable UI Hud Fix Off, that means the mod work\n\n"  
"Other versions of the mod install normally, but may experience flickering on the HUD"
),

'Red Dead Redemption 2 MIX':(
 '1 - Set the game to DX12 in advanced options.\n'
'2 - Turn off Triple Buffering and Vsync, and set the game to Full Screen.\n'
'3 - Select the RDR2 Mix mod and install it.\n'
'4 - You don\'t need to use any upscaler, as Frame Generation is automatically activated.\nHowever, if you want to use an upscaler, when installing, check the Addon Mods box,\nselect Optiscaler, and below in DX11 select FSR 2.1 DX11, and in DX12 select FSR 2.1\nDX12.'   
),

'Red Dead Redemption Mix 2':(
'1 - Set the game to DX12.\n'
'2 - Turn off Buffer Triple, Vsync, and disable any upscaler,\nleave it on TAA.\n'
'3 - It\'s not necessary to activate any upscaler for the mod\nto work, but if you want to use one, refer to the RDR2 Mix\nguide.'   
),

'Red Dead Redemption V2':(
'1 - Turn off Vsync, Triple Buffering, and set the game to DX12.\n'
'2 - Install the mod.\n'
'3 - In-game, press the "END" key and select an upscaler.\nIf you want to use native resolution, check the Native\nResolution box below the upscaler, and restart the game.\n(FSR3 Upscaling or FSR 2 is recommended; you can also\ntry others, but they may not work).'  
),

'RDR2 Non Steam':(
'1- Leave the game in DX12 and turn off Vsync/Triple Buffering.\n'
'2- In-game, if you have an RTX card, enable DLSS, if you\ndon\'t have an RTX card, disable any upscaler and turn on\nTAA. Press the "END" key, select FSR3 in Upscaler Type,\nand check the box "Enable Frame Generation.\n'    
'3- If a DLL error occurs, reinstall the mod and click "YES" in\nthe DLL file installation message box'
),

'Returnal':(
"1 - Choose a version of the mod you prefer (version 0.10.3\nis recommended).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the\nmod doesn't work.\n"
"3 - Select 'Default' in Nvngx.dll."
),

'Rise of The Tomb Raider':(
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
'1 - Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Choose the path for the overlay, under Epic Games\nOverlay, and select "Disable".\n'
'3 - Start the game in DX12.\n'
'4 - Inside the game, select FSR.'   
),

'Shadow Warrior 3':(
'Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Inside the game, select FSR. (You can use it with DLSS\nbut there might be flickering).\n'
'3 - Set Ambient Occlusion and Post Processing to Low.' 
),

'Smalland':(
'1 - Select a mod of your choice. (0.10.3 is recommended)\n'
'2 - Check the Fake Nvidia GPU box. (AMD/GTX)\n'
'3 - In the game, select DLSS'    
),

'Spider Man/Miles':(
'1 - Select a mod of your preference\n'
'2 - The Uniscaler Spider does not require any additional\nconfiguration initially, just install it. If you choose another\nmod or the Dlss Frame Generation option is not available,\ncheck the Fake Nvidia Gpu box. (only Amd)\n'
'3 - In-game, select an upscaler and enable Dlss Frame\nGeneration.\n\n'
'Uni Custom Miles\n'
'1 -Check the Fake Nvidia GPU box (if you can\'t see DLSS in\nthe game, check the Nvapi Results box as well).\n'
'2 - On the initial configuration screen, select DLSS or XESS\nand check the Frame Generation box.\n'
'3 - If you have an RTX, you can improve image quality by\nselecting \'DLSS\' in Mode Settings'   
),

'Star Wars: Jedi Survivor':(
'DLSS Jedi (if you have RTX, use this mod if you want to use\nnative DLSS)\n'
'1 - Check the box Fake Nvidia GPU (GTX and AMD), Nvapi\nResults (GTX and AMD), and UE Compatibility (AMD)\n'
'2 - If you can\'t see DLSS in-game, select "DLSS" under\n"Mod Operates"'
'3 - In-game, select DLSS 3 and Frame Gen\n\n'
'For All GPUs\n'
'1 - Select a mod of your preference (recommended 0.10.3\n/0.10.4 or Uniscaler)\n'
'2 - Check the box Fake Nvidia GPU (GTX and AMD), Nvapi\nResults (GTX and AMD), and UE Compatibility (AMD)\n'
'3 - In-game, select FSR and Frame Gen'
),

'Star Wars Outlaws':(
'RTX\n'
'1 - Select Star Wars DLSS RTX and install\n'
'2 - Inside the game, select DLSS and Frame Gen\n\n'

'All GPUs\n'
'1 - Select FSR 3.1/DLSS Optiscaler\n'
'2 - Inside the game, select an upscaler of your choice.\n'
'3 - Press the Insert key to open the menu and select an\nupscaler of your choice.\n\n'

'Graphic Preset\n'
'1 - Install the mod and the ReShade application\n'
'2 - In ReShade, select b1.exe, DirectX 10/11/12,\nclick on \'Browser\', and find the file Outlaws2.ini (the path\nshould look something like Star Wars Outlaws\Outlaws2.ini)\nand select it, then click on \'Uncheck All\' and \'Next\'.\n'
'3 - In the game, press the \'Insert\' key to open\nthe menu and check the options you want.\n\n'
),

'Sackboy: A Big Adventure':(
'1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n'
'2 - Select the game folder that has the ending\n"\GingerBread\Binaries\Win64".\n'
'3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n'
'4 - In "Mod Operates", select "Replace Dlss FG".\n'
'5 - Select \'Default\' in Nvngx.dll\n'
'6 - Enable the "Enable Signature Override" checkbox if the\nmod doesn\'t work.\n'
),

'Shadow of the Tomb Raider':(
'1 - Select the \'Uniscaler\' option under \'Mod Version\'\n'
'2 - AMD GPU users: Select \'XESS\' under \'Mod Operates\' | Nvidia GPU users: Select any of the 3\noptions under \'Mod Operates\' (DLSS is recommended).\n'
'3 - In the configuration window, disable \'AMD FidelityFX CAS\' and select an option in XESS/DLSS.\n'
'4 - Within the game, adjust the options as desired (you can reactivate AMD FidelityFX CAS)\n'
'5 - To activate Frame Generation, select an option in XESS/DLSS, select an Anti-aliasing option if\ndesired (Frame Generation will remain active).\n'
'● Select \'Nvngx: Default\' and enable \'Enable Signature Override\' if the mod doesn\'t work\n(AMD GPU users only).\n\n'

'Uniscaler V3\n'
'1 - Select Uniscaler V3\n'
'2 - In Mod Operates, select XESS, and in Frame Gen Method, select FSR3\n'
'3 - If you don\'t have an RTX GPU, check the Nvngx.dll box and select Default\n'  
'4 - In the game, turn off Anti-Aliasing and set XESS to Quality\n'  
'5 - To fix the HUD error, go to settings after completing the step above, turn off XESS, and select\nSMAA in Anti-Aliasing.'

),

'Steelrising':(
'1 - Choose a version of the mod you prefer (version 0.10.3 is\nrecommended).\n'
'2 - Enable Fake Nvidia GPU (only for AMD and GTX).\n'
'3 - Enable NVAPI Results (only for GTX).\n'
'4 - In Mod Operates, select Enable Upscaling Only.\n\n'
'● To fix the Hub Flickering, do not select any option in Mod\nOperates, open the game, and choose FSR 1.0.'
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

'The Callisto Protocol':(
'The Callisto Protocol Fsr3\n'
'1 - Select The Callisto Protocol Fsr3\n' 
'2 - Check the Fake Nvidia GPU box and install.\n\n'

'Uniscaler V3\n'
'1 - Select Uniscaler V3\n'
'2 - Check the Nvngx box and select Default\n'
'3 - Check the Enable Signature Over box\n\n'

'0.10.4\n'
'1 - Select 0.10.4 and install it.\n'
'2- Inside the game, select FSR 2 and start the campaign.\n'
'3 -If Frame Gen doesn\'t work, check the "Nvngx.dll" box and\nselect "Default," then check the "Enable Signature Override"\nbox. For Epic Games users: if the mod doesn\'t work or some\nbugs appear, check the "Disable Overlay" box.\n\n'

'HUD Correction\n'
'Select FSR2 and start the campaign, play for a few\nseconds, and return to the menu. In the menu, select\nTemporal and return to the campaign.\n\n'

'Real Life\n'
'Adds more detail to the world making them wood effects\nstand out more as well as the ground, lighting, walls and dirt\nmarks, and skin.\n\n'

'TCP\n'
'A ReShade config that implements duller colours,\nnearby sharpness and distant depth of field blur to give a\ngrittier and more cinematic style to emphasise the sci-fi horror\natmosphere.\n\n'

'1 - Install the ReShade application\n'
'2 - Select DirectX 10/11/12, click \'Browse\' and select the\nTCP.ini file that was installed in the destination folder chosen\nin the Utility.\n'
'3 - Click \'Uncheck All\' and then click \'Next\'.\n' 
'4 - Do the same for the Real Life mod.'
),

'The Chant':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Enable Fake Nvidia Gpu, if Frame Generation is not\ndetected, enable Nvapi Results. (only Amd and Gtx)'  
),

'The Invicible':(
'1 - Select a mod of your preference (0.10.3 is recommended,\nbut if it doesn\'t work, try older versions such as 0.7.6 and\ncheck the lfz.sl.dlss box)\n'
'2 - In the game, select FSR or DLSS if the mod is not active.'    
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

'The Thaumaturge':(
'1 - Select a version of the mod of your choice (it is recommended 0.10.3\nonwards or Uniscaler)\n'
'2 - Select the folder where the game\'s exe is located.\n'
'3 - Activate Fake Nvidia GPU (if you don\'t have Rtx 3xxx/4xxx series)\n'
'4 - Inside the game, select DLSS.\n'
'• To use Uniscaler, it is necessary to select the \'DLSS\' option in\nMod Operates\n'
'• If the game is on Epic Games, it is necessary to disable the Overlay,\nsimply go to \'Epic Games Overlay\'.'
),

'The Witcher 3':(
'1 - Select a mod of your choice. (0.10.3 is recommended)\n'
'2 - Check the Fake Nvidia GPU (AMD/GTX) box. If you can\'t\nactivate DLSS on an AMD GPU, also check Nvapi Results.\n'
'3 - In the game, select DLSS and Frame Generation. If you\nwant to use FSR, first enable DLSS and then switch to FSR.\n\n'
'FSR 3.1\n'
'1 - Select Uniscaler FSR 3.1\n'
'2 - For AMD/GTX users: Check the boxes: Fake Nvidia GPU, Nvapi\nResults, and Disable Signature Over.\n'
'3 - Check the Nvngx box and select Default.\n'
'4 - In the game, select DLSS; do not change to FSR as the\ngame will crash.'    
),

'Uncharted':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n' 
'2 - Run the game using the u4-l.exe executable. The game\nmay crash the first time, so just run it again.\n'
'3 - Inside the game, select FSR.'
),

'Wanted Dead':(
'1 - Select a mod of your choice. (0.10.3 is recommended)\n'
'2 - In the game, select FSR.'    
),

'Uniscaler':(
'Enable frame generation in any upscaler the game has, choose\nbetween the 3 options FSR3, DLSS, and XESS. If the game\nsupports one of these 3 upscalers, simply select one of these\noptions in "Mod Operates".\n\n'
'Even if the game does not have support for one of the 3\nupscalers, it is possible to activate them by selecting the\nupscaler in "Mod Operates".\n\n'
'AMD GPU users may need to select the \'Nvngx: Default\'\noption and activate \'Enable Signature Override\'.\nPlease perform these steps if the mod does not work on your\ndefault version.'
),

'XESS/DLSS':(
'1 - Select Uniscaler in Mod Version (you can try using it with other mod versions\nbut you will likely encounter an error)\n'
'2 - Check the NVNGX box and select XESS 1.3 or DLSS 3.7.0. For some games\nlike The Callisto Protocol, for example, it will '
'be necessary to select \'Default\' in\nNVNGX. Then, you can select \'Default\' in NVNGX and choose any option in Mod\nOperates and install. '
'After pressing install, a window will appear to confirm the\ninstallation of XESS/DLSS. This way, you can install the default Nvngx from\nUniscaler and XESS/DLSS together without needing to perform 2 installations.\n'
'3 - If the game has a default Xess/Dlss file, this file is modified to serve as a\nbackup. If you want to remove the installed Xess/Dlss and revert to the old\nversion, just check the \'Cleanup Mod\' checkbox and confirm the deletion window\nthat appears.'  
)
}   
    
    if select_game in list_game:
        guide_text = list_game[select_game]
    else:
        guide_text = ""
    if select_game == 'Red Dead Redemption 2':
        screen_guide.geometry('655x410')
    elif select_game == 'Dead Space Remake':
        screen_guide.geometry('530x260')
    elif select_game == 'Hogwarts legacy':
        screen_guide.geometry('550x260')
    elif select_game == 'Uniscaler':
        screen_guide.geometry('538x260')
    elif select_game == 'Shadow of the Tomb Raider':
        screen_guide.geometry('740x320')
    elif select_game == 'Horizon Forbidden West':
        screen_guide.geometry('573x260')
    elif select_game == 'Rise of The Tomb Raider':
        screen_guide.geometry('590x260')
    elif select_game == 'The Thaumaturge':
        screen_guide.geometry('590x260')
    elif select_game == 'Marvel\'s Guardians of the Galaxy':
        screen_guide.geometry('590x260')
    elif select_game == 'Dragons Dogma 2':
        screen_guide.geometry('600x260')
    elif select_game == 'Ghostrunner 2':
        screen_guide.geometry('580x260')
    elif select_game == 'Martha Is Dead':
        screen_guide.geometry('600x260')
    elif select_game == 'Elden Ring':
        screen_guide.geometry('730x260')
    elif select_game == 'F1 2022' or select_game == 'F1 2023':
        screen_guide.geometry('540x260')
    elif select_game == 'XESS/DLSS':
        screen_guide.geometry('635x260')
    elif select_game == 'Fallout 4':
        screen_guide.geometry('730x280')
    elif select_game == 'Initial Information':
        screen_guide.geometry('850x260')
    elif select_game == 'Palworld':
        screen_guide.geometry('533x325')
    elif select_game == 'TEKKEN 8':
        screen_guide.geometry('520x305')
    elif select_game == 'Icarus':
        screen_guide.geometry('690x260')
    elif select_game == 'Red Dead Redemption 2 MIX':
        screen_guide.geometry('672x260')
    elif select_game == 'Hellblade 2':
        screen_guide.geometry('535x595')
    elif select_game == 'Add-on Mods':
        screen_guide.geometry('620x790')
    elif select_game == 'Spider Man/Miles':
        screen_guide.geometry('520x280')
    elif select_game == "Ghost of Tsushima" or select_game == 'The Witcher 3':
        screen_guide.geometry('520x320')
    elif select_game == 'Cyberpunk 2077':
        screen_guide.geometry('540x260')
    elif select_game == 'Black Myth: Wukong':
        screen_guide.geometry('620x790')
    elif select_game == 'The Callisto Protocol':
        screen_guide.geometry('530x680')
    elif select_game == 'Star Wars Outlaws':
        screen_guide.geometry('520x330')
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
    guide_fsr_label.place(x=260,y=420)

def close_guide_fsr(event=None):
    guide_fsr_label.place_forget()
    
guide_fsr_label = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
guide_fsr_label.place_forget()

var_ignore_fg = False

new_uniscaler_path = {'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.tom',
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

ignore_ingame_fg_label = tk.Label(screen,text='Ignore Ingame Fg',font=font_select,bg='black',fg='#C0C0C0')
ignore_ingame_fg_label.place(x=0,y=365)
ignore_ingame_fg_var = IntVar()
ignore_ingame_fg_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=ignore_ingame_fg_var,command=cbox_ignore_fg)
ignore_ingame_fg_cbox.place(x=130,y=367)

ignore_ingame_fg_resources_label = tk.Label(screen,text='Ignore Fg Resources',font=font_select,bg='black',fg='#C0C0C0')
ignore_ingame_fg_resources_label.place(x=200,y=365)
ignore_ingame_fg_resources_var = IntVar()
ignore_ingame_fg_resources_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=ignore_ingame_fg_resources_var,command=cbox_ignore_fg_resources)
ignore_ingame_fg_resources_cbox.place(x=350,y=367)

path_remove_overlay_uni = {'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
              'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
              'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'}
#Disable the overlay of some launchers, such as Epic Games for example. Overlays can cause conflicts with the mod. Change the disable_overlay_blocker option in the .toml file to True or False
var_remove_over = False
def cbox_remove_overlay():
    global var_remove_over
    var_remove_over = bool(remove_overlay_var.get())
    if select_mod in path_remove_overlay_uni:
        remove_overlay()
    else:
        messagebox.showinfo('Uniscaler','Please select Uniscaler V2/V3 or Uniscaler FSR 3.1 to choose this option')
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
remove_overlay_label.place(x=0,y=305)
remove_overlay_var = IntVar()
remove_overlay_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=remove_overlay_var,command=cbox_remove_overlay)
remove_overlay_cbox.place(x=117,y=308)

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
        
    if select_option == 'Red Dead Redemption 2' and select_mod in rdr2_folder:
        comp_files(rdr2_folder)  
        
        dll_rdr2 = ['ffx_fsr2_api_dx12_x64.dll','ffx_fsr2_api_vk_x64.dll','ffx_fsr2_api_x64.dll']
        backup_folder_rdr2 = os.path.join(select_folder,'Backup')
        
        if select_mod == 'RDR2 Non Steam FSR3':
            for i_dll in os.listdir(select_folder):
                if i_dll in dll_rdr2:
                    dll_path = os.path.join(select_folder, i_dll)
                    shutil.copy(dll_path,backup_folder_rdr2)

        unlock_view_message = False
        
    elif select_option == 'Red Dead Redemption 2' and select_mod in origins_rdr2_folder:
        comp_files(origins_rdr2_folder)
        unlock_view_message = False
    
    if select_option == 'Baldurs Gate 3':
        comp_files(bdg_origins)
        unlock_view_message = False  
        
    if select_option == 'The Callisto Protocol':
        comp_files(callisto_origins)
        unlock_view_message = False
        
    if select_option == 'Dragons Dogma 2' and select_mod != 'FSR 3.1/DLSS DD2 ALL GPU' and select_mod != 'FSR 3.1/DLSS DD2 NVIDIA':
        comp_files(dd2_folder)
        unlock_view_message = False
        
    if select_option == 'Elden Ring':
        comp_files(er_origins)
        unlock_view_message = False
    
    origins_gtav = {'GTA V FSR3':'mods\\FSR3_GTAV\\GtaV_B02_FSR3',
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
    
    select_tlou_file = ['winmm.ini','winmm.dll','nvngx_dlssg.dll','nvngx_dlss.dll','nvngx.dll','libxess.dll']
    search_tlou = select_mod
    select_tlou_name = 'Uniscaler Tlou'
    
    search_spider = select_mod
    select_spider_name = 'Uniscaler Spider'
     
    select_miles_file = ['winmm.dll','winmm.ini']
    select_miles_name = 'Uni Custom Miles'
    
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
        
        if select_mod == 'Uniscaler Tlou':
            for tlou_file in select_tlou_file:
                sucess_message = search_dll_files(select_tlou_name,tlou_file,search_tlou)
        
        if select_mod == 'Uniscaler Spider':
            for spider_file in select_tlou_file:
                sucess_message = search_dll_files (select_spider_name,spider_file,search_spider) 
        
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
        
        if select_mod == 'Uni Custom Miles':
            for miles_files in select_miles_file:
                sucess_message = search_dll_files(select_miles_name,miles_files,search_spider) 
        
        if select_mod == "Dlss Jedi":
            for jedi_files in  select_miles_file:
                sucess_message = search_dll_files(select_jedi_name,jedi_files,search_spider) 
        
        if select_option == "Cyberpunk 2077" and select_mod == "RTX DLSS FG":
            for cb2077_files in select_cb2077_file:
                sucess_message = search_dll_files(select_cb2077_name,cb2077_files,search_spider)

        if select_option == 'Dragons Dogma 2' and select_mod == 'FSR 3.1/DLSS DD2 ALL GPU':
            for dd2_all_files in select_dd2_file:
                sucess_message = search_dll_files(select_dd2_name,dd2_all_files,search_spider)

        if select_option == 'Dragons Dogma 2' and select_mod == 'FSR 3.1/DLSS DD2 NVIDIA':
            for dd2_nv_files in select_dd2_nv_file:
                sucess_message = search_dll_files(select_dd2_nv_name,dd2_nv_files,search_spider)

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
                  
backup_label = tk.Label(screen,text='Backup',font=font_select,bg='black',fg='#C0C0C0')
backup_label.place(x=160,y=393)
backup_var = IntVar()
backup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=backup_var,command=cbox_backup)
backup_cbox.place(x=219,y=395)

uni_custom_contr = False
select_uni_custom = ""
unlock_uni_custom_res = False

list_uni = ['Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2', 'Uniscaler V3','Uniscaler FSR 3.1']
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
addon_origins = {'OptiScaler':'mods\\Addons_mods\OptiScaler',
                 'Tweak':'mods\\Addons_mods\\tweak'}
select_addon_dx12 = 'auto'
select_options_optiscaler = None
select_addon_mods = None

def addon_mods():
    path_ini_optiscaler = 'mods\Temp\OptiScaler'
    if select_addon_mods in addon_origins:
        path_addon = addon_origins[select_addon_mods]
    
    try:
        if select_addon_mods == 'OptiScaler' and select_mod != 'FSR 3.1/DLSS Optiscaler':
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
            addon_mods_listbox.place(x=548,y=480)
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
            addon_ups_dx12_listbox.place(x=570,y=539)
            addon_ups_dx12_scroll.place(x=657,y=539, height=66)

def options_optiscaler_view(event=None):
    global addon_view,addon_contr
    
    if addon_contr and select_addon_mods == 'OptiScaler':
        if addon_view:
            options_optiscaler_listbox.place_forget()
            options_optiscaler_scroll.place_forget()
            addon_view = False
        else:
            addon_view = True
            options_optiscaler_listbox.place(x=537,y=511)
            options_optiscaler_scroll.place(x=680, y=511, height=98)

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
        var_method = 'Method Default (For test)'
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
        
        if method == 'Method Default (For test)':
            var_method = 'Method Default (For test)'
        elif method == 'Method 1 (RTX/RX 6000-7000)':
            var_method = 'Method 1 (RTX/RX 6000-7000)'
        elif method == 'Method 2 (GTX/Old AMD)':
            var_method = 'Method 2 (GTX/Old AMD)'
        elif method == 'Method 3 (If none of the others work)':
            var_method = 'Method 3 (If none of the others work)'
        
        screen_method_open = False
        screen_method.destroy()
    
    method0 = ttk.Button(screen_method, text='Method Default (For test)', command=lambda: method_selected('Method Default (For test)'))
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
    optiscaler_reg = ['regedit.exe', '/s', "mods\\Addons_mods\\OptiScaler\\EnableSignatureOverride.reg"]
    os.makedirs(backup_dir, exist_ok=True) 

    if var_method == 'Method Default (For test)': #Default installation 
        pass

    if var_method == 'Method 1 (RTX/RX 6000-7000)': #Default installation 
       pass
    
    elif var_method == 'Method 2 (GTX/Old AMD)':
        shutil.copy2("mods\Addons_mods\Optiscaler dxgi\dxgi.dll", select_folder)

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
    subprocess.run(optiscaler_reg, check=True)
            
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
    if select_mod == 'FSR 3.1/DLSS Optiscaler':
        path_ini_dx11 = 'mods\\Temp\\Optiscaler FG 3.1\\nvngx.ini'

    elif select_mod != 'FSR 3.1/DLSS Optiscaler':
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

    if select_mod == 'FSR 3.1/DLSS Optiscaler':
        path_ini_dx11 = 'mods\\Temp\\Optiscaler FG 3.1\\nvngx.ini'

    elif select_mod != 'FSR 3.1/DLSS Optiscaler':
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

    if select_mod == 'FSR 3.1/DLSS Optiscaler':
        path_ini = 'mods\\Temp\\Optiscaler FG 3.1\\nvngx.ini'
        path_ini_origin = 'mods\\Optiscaler FSR 3.1 Custom\\nvngx.ini'
        folder_ini = 'mods\\Temp\\Optiscaler FG 3.1'

    elif select_addon_mods == 'OptiScaler':
        path_ini = 'mods\\Temp\\OptiScaler\\nvngx.ini'
        path_ini_origin = 'mods\\Addons_mods\\OptiScaler\\nvngx.ini'
        folder_ini = 'mods\\Temp\\OptiScaler'

    if select_addon_mods == 'OptiScaler' or select_mod == 'FSR 3.1/DLSS Optiscaler':
        os.remove(path_ini)
        shutil.copy2(path_ini_origin,folder_ini)

addon_ups_dx12_label = tk.Label(screen,text='Upscaler Optiscaler',font=font_select,bg='black',fg='#C0C0C0')
addon_ups_dx12_label.place(x=420,y=515)
addon_ups_dx12_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
addon_ups_dx12_canvas.place(x=570,y=519)
addon_ups_dx12_scroll = tk.Scrollbar(screen)
addon_ups_dx12_listbox = tk.Listbox(screen, width=14,height=4, bg='white', highlightthickness=0, yscrollcommand=addon_ups_dx12_scroll.set)
addon_ups_dx12_scroll.config(command=addon_ups_dx12_listbox.yview)

options_optiscaler_label = tk.Label(screen,text='Optiscaler Opts',font=font_select,bg='black',fg='#C0C0C0')
options_optiscaler_label.place(x=420,y=485)
options_optiscaler_canvas = tk.Canvas(width=150,height=19,bg='#C0C0C0',highlightthickness=0)
options_optiscaler_canvas.place(x=537,y=489)
options_optiscaler_scroll = tk.Scrollbar(screen)
options_optiscaler_listbox = tk.Listbox(screen, width=24, height=6, bg='white', highlightthickness=0, yscrollcommand=options_optiscaler_scroll.set)
options_optiscaler_scroll.config(command=options_optiscaler_listbox.yview)

addon_mods_label = tk.Label(screen,text='Add-on Mods',font=font_select,bg='black',fg='#C0C0C0')   
addon_mods_label.place(x=420,y=455)
addon_mods_var = tk.IntVar()
addon_mods_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=addon_mods_var,command=cbox_addon_mods)
addon_mods_cbox.place(x=522,y=457)
addon_mods_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
addon_mods_canvas.place(x=548,y=459)
addon_mods_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)
addon_mods_listbox.place(x=548,y=480)
addon_mods_listbox.place_forget()

#Modifies the operation of Auto Exposure in the Uniscaler mods via the .toml file (true/false).
us_origin = {'Uniscaler':r'mods\Temp\Uniscaler\enable_fake_gpu\uniscaler.config.toml',
             'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
             'Uniscaler V2':r'mods\Temp\Uniscaler_V2\enable_fake_gpu\uniscaler.config.toml',
             'Uniscaler V3':r'mods\Temp\Uniscaler_V3\enable_fake_gpu\uniscaler.config.toml',
             'Uniscaler FSR 3.1':r'mods\Temp\Uniscaler_FSR31\enable_fake_gpu\uniscaler.config.toml'}
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
var_auto.place(x=200,y=245)
var_auto_expo_var = tk.IntVar()
var_expo_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=var_auto_expo_var,command=cbox_var_auto_expo)
var_expo_cbox.place(x=310,y=248)

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
var_frame_gen_label.place(x=0,y=276)
var_frame_gen_var = tk.IntVar()
var_frame_gen_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=var_frame_gen_var,command=cbox_var_frame_gen)
var_frame_gen_cbox.place(x=110,y=279)

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
fps_user_label.place(x=0,y=245)
fps_user_entry =  tk.Entry(screen,width=5,bg='#C0C0C0',state= 'readonly',borderwidth=0)
fps_user_entry.place(x=80,y=250)
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
del_dxgi_label.place(x=0,y=515)
del_dxgi_var = IntVar()
del_dxgi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=del_dxgi_var,command=cbox_del_dxgi)
del_dxgi_cbox.place(x=120,y=517) 

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
        
#Execution def 
def clean_mod():
    global select_folder
    mod_clean_list = ['fsr2fsr3.config.toml','winmm.ini','winmm.dll',
                      'lfz.sl.dlss.dll','FSR2FSR3.asi','EnableSignatureOverride.reg',
                      'DisableSignatureOverride.reg','nvngx.dll','_nvngx.dll','dxgi.dll','fsr2fsr3.log',
                      'd3d12.dll','nvngx.ini','fsr2fsr3.log','Uniscaler.asi','uniscaler.config.toml','uniscaler.log','dinput8.dll']
   
    del_uni = ['winmm.ini','winmm.dll','uniscaler.config.toml','Uniscaler.asi','nvngx.dll']
   
    del_winmm = 'winmm.dll'
    
    del_elden_fsr3 =['_steam_appid.txt','_winhttp.dll','anti_cheat_toggler_config.ini','anti_cheat_toggler_mod_list.txt',
                     'start_game_in_offline_mode.exe','toggle_anti_cheat.exe','ReShade.ini','EldenRingUpscalerPreset.ini',
                     'dxgi.dll','d3dcompiler_47.dll','']
    
    del_elden_fsr3_v3 = ['ERSS2.dll','dxgi.dll']
    
    del_bdg_fsr3 = ['nvngx.dll','version.dll','version.org']
    
    del_fl4_fsr3 = ['f4se_whatsnew.txt','f4se_steam_loader.dll','f4se_readme.txt','f4se_loader.exe','f4se_1_10_163.dll',
                    'CustomControlMap.txt']
    
    del_fh_fsr3 = ['DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','nvngx.dll','RestoreNvidiaSignatureChecks.reg',
                   'dinput8.dll','dlssg_to_fsr3.asi','nvapi64.asi','winmm.dll','winmm.ini']
    
    del_rdr2_fsr3 = ['ReShade.ini','RDR2UpscalerPreset.ini','d3dcompiler_47.dll','d3d12.dll','dinput8.dll','ScriptHookRDR2.dll','NVNGX_Loader.asi',
                     'd3dcompiler_47.dll','nvngx.dll','winmm.ini','winmm.dll','fsr2fsr3.config.toml','FSR2FSR3.asi','fsr2fsr3.log']
    
    del_icarus_otgpu_fsr3 = ['nvngx.dll', 'FSR2FSR3.asi','fsr2fsr3.config.toml','winmm.dll','winmm.ini']
    del_icarus_rtx_fsr3 = ['RestoreNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg']
                       
    del_tekken_fsr3 = ['TekkenOverlay.exe','Tekken8OverlaySettings.yaml','Tekken8Overlay.dll','Tekken7Overlay.dll']

    del_tlou_fsr3 = ['winmm.ini','winmm.dll','nvngx_dlssg.dll','nvngx_dlss.dll','nvngx.dll','libxess.dll','uniscaler.asi','uniscaler.config.toml','uniscaler.log']
    
    del_gtav_fsr3 = ['GTAVUpscaler.org.asi','GTAVUpscaler.asi','d3d12.dll','GTAVUpscaler.dll','GTAVUpscaler.org.dll','dinput8.dll']
    
    del_lotf_fsr3 = ['version.dll','RestoreNvidiaSignatureChecks.reg','nvngx.dll','launch.bat','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg',
                        'Uniscaler.asi','DisableEasyAntiCheat.bat','winmm.dll','winmm.ini']
    
    del_cb2077 = ['nvngx.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll']
    
    del_got = ['version.dll','RestoreNvidiaSignatureChecks.reg','dxgi.dll','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg','d3d12core.dll','d3d12.dll','no-filmgrain.reg']
    
    del_hfw_fsr = ['version.dll','nvngx.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','fsr2fsr3.config.toml','FSR2FSR3.asi','','lfz.sl.dlss.dll','winmm.dll','winmm.ini','libxess.dll']
    
    del_valhalla_fsr3 = ['ReShade.ini','dxgi.dll','ACVUpscalerPreset.ini']
    
    del_hb2 = ['version.dll','RestoreNvidiaSignatureChecks.reg','DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll']
    
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

    del_optiscaler = ['nvngx.ini','nvngx.dll','libxess.dll','EnableSignatureOverride.reg','DisableSignatureOverride.reg','amd_fidelityfx_vk.dll','amd_fidelityfx_dx12.dll']

    del_optiscaler_custom = [
    'amd_fidelityfx_dx12.dll', 'amd_fidelityfx_vk.dll', 'DisableNvidiaSignatureChecks.reg', 'DisableSignatureOverride.reg', 'dlss-enabler-upscaler.dll', 'dlss-enabler.log', 'dlss-finder.exe', 'dlssg_to_fsr3.ini', 'dlssg_to_fsr3.log', 'dlssg_to_fsr3_amd_is_better.dll', 
    'dxgi.dll', 'EnableSignatureOverride.reg', 'libxess.dll', 'licenses', 'nvapi64-proxy.dll', 'nvngx-wrapper.dll', 'nvngx.dll', 'nvngx.ini', 'RestoreNvidiaSignatureChecks.reg', 'unins000.dat', 'unins000.exe', 'version.dll', '_nvngx.dll'
    ]

    del_dlss_rtx =[ 
    'dlss-enabler-upscaler.dll', 'dlss-enabler.log', 'dlssg_to_fsr3.log', 'dlssg_to_fsr3_amd_is_better.dll',
    'libxess.dll', 'nvngx-wrapper.dll', 'nvngx.ini', 'unins000.dat',
    'version.dll','dlss_rtx.txt'
    ]
    del_dlss_amd = [
    'DisableNvidiaSignatureChecks.reg', 'dlss-enabler-upscaler.dll', 'dlss-enabler.log', 'dlss-finder.exe',
    'dlssg_to_fsr3.log', 'dlssg_to_fsr3_amd_is_better.dll', 'dxgi.dll', 'libxess.dll',
    'nvapi64-proxy.dll', 'nvngx-wrapper.dll', 'nvngx.ini', 'RestoreNvidiaSignatureChecks.reg',
    'unins000.dat', 'unins000.exe', 'winmm.dll', '_nvngx.dll','dlss_amd.txt'
    ]

    del_dlss_to_fg = ['dlssg_to_fsr3_amd_is_better.dll','version.dll']


    def ask_and_remove(file_path,message):
        if os.path.exists(file_path):
            if messagebox.askyesno('Remove',message):
                os.remove(file_path)

    try:
        path_dd2_w = os.path.join(select_folder,'_storage_')
        if select_option == 'Dragons Dogma 2' and select_mod != 'FSR 3.1/DLSS DD2 ALL GPU' and select_mod != 'FSR 3.1/DLSS DD2 NVIDIA':
            if os.path.exists(path_dd2_w):
                try:
                    os.remove(os.path.join(path_dd2_w,del_winmm)) 
                except FileNotFoundError:
                    pass 
    
            storage_folder = os.path.join(select_folder, '_storage_')
            var_storage = messagebox.askyesno('Storage','Would you like to delete the _storage_ folder? (folder created by the dinput8 file.')
            if var_storage:
                if os.path.exists(storage_folder):
                    shutil.rmtree(storage_folder)
        
        elif select_mod == 'FSR 3.1/DLSS DD2 ALL GPU':
            for all_gpu_dd2 in os.listdir(select_folder):
                if all_gpu_dd2 in  del_dd2_all_gpu:
                    os.remove(os.path.join(select_folder,all_gpu_dd2))
            
            shutil.rmtree(os.path.join(select_folder,'reframework'))
        
        elif select_mod == 'FSR 3.1/DLSS DD2 NVIDIA':
            for nv_dd2 in os.listdir(select_folder):
                if nv_dd2 in  del_dd2_nv:
                    os.remove(os.path.join(select_folder,nv_dd2))

            shutil.rmtree(os.path.join(select_folder,'reframework'))

        uniscaler_folder = os.path.join(select_folder, 'uniscaler')
        if os.path.exists(uniscaler_folder):
            shutil.rmtree(uniscaler_folder)
            
    except Exception as e:
        messagebox.showinfo('Error','Unable to delete the Uniscaler folder, please close the game or any other folders related to the game.')
     
    try:
        if select_option == 'Elden Ring' and select_mod != 'Elden_Ring_FSR3_V3' and select_mod != 'Unlock FPS Elden':
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


        elif select_option == 'Elden Ring' and select_mod == 'Elden_Ring_FSR3_V3':
            for itemv3 in os.listdir(select_folder):
                if itemv3 in del_elden_fsr3_v3:
                    os.remove(os.path.join(select_folder,itemv3))  
            if os.path.exists(os.path.join(select_folder,'ERSS2')):
                shutil.rmtree(os.path.join(select_folder,'ERSS2'))  
        
            if os.path.exists(os.path.join(select_folder,'mods')):
                if os.path.exists(os.path.join(select_folder,'UnlockFps.txt')):
                    os.remove(os.path.join(select_folder,'mods\\UnlockTheFps.dll'))
                    os.remove(os.path.join(select_folder,'UnlockFps.txt'))
                    shutil.rmtree(os.path.join(select_folder,'mods\\UnlockTheFps'))

    except Exception as e:
        print(e)
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.') 
    
    if select_option == 'Baldur\'s Gate 3':
        del_all_mods(del_bdg_fsr3,'Baldur\'s Gate 3','mods') 
    
    name_xess = os.path.join(select_folder,'libxess.txt')
    new_xess = os.path.join(select_folder,'libxess.dll')
    rename_old_xess = 'libxess.dll'
    
    try:
        if select_option == "Cyberpunk 2077":
            path_mods_cb2077 = os.path.join(select_folder,"archive\\pc\\mod")
            mods_files = ["#####-NovaLUT-2.archive","HD Reworked Project.archive"]
            cb2077_reg = ['regedit.exe', '/s', "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal\\RestoreNvidiaSignatureChecks.reg"]
            reshade_path = '\\bin\\x64\\V2.0 Real Life Reshade.ini'

            if select_mod == "RTX DLSS FG":
                for file_del in os.listdir(select_folder):
                    if file_del in del_cb2077:
                        os.remove(os.path.join(select_folder,file_del)) 
                subprocess.run(cb2077_reg,check=True)
            
            if os.path.exists(path_mods_cb2077 + "\\#####-NovaLUT-2.archive"):
                
                remove_mods_cb2077 = messagebox.askyesno("Mods","Would you like to remove the mods? Nova Lut and Cyberpunk 2077 HD Reworked")
                
                if remove_mods_cb2077:
                    for files in mods_files:
                        full_path_mods = os.path.join(path_mods_cb2077,files)
                        os.remove(full_path_mods)
            
            if os.path.exists(os.path.join(select_folder + reshade_path)):
                os.remove(select_folder + reshade_path)

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
        print(e)
            
    try:
        if select_mod == 'Uniscaler' or select_mod == 'Uniscaler V2' or select_mod == 'Uniscaler V3' or select_mod == 'Uniscaler FSR 3.1':
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
        if select_mod in rdr2_folder or select_option == 'Palworld':
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

        if select_mod == "RDR2 FSR 3.1 FG":
            for optis_rdr2 in os.listdir(select_folder):
                    if optis_rdr2 in del_optiscaler_custom:
                        os.remove(os.path.join(select_folder,optis_rdr2))
            
            optiscaler_rdr2_reg = ['regedit.exe', '/s', "mods\Addons_mods\OptiScaler\EnableSignatureOverride.reg"]
                
            subprocess.run(optiscaler_rdr2_reg,check=True)
                            
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
    
    name_dlss = os.path.join(select_folder,'nvngx_dlss.txt')
    new_dlss = os.path.join(select_folder,'nvngx_dlss.dll')
    rename_old_dlss = 'nvngx_dlss.dll'
    
    try:
        if select_mod == 'Uniscaler' or select_mod == 'Uniscaler V2' or select_mod == 'Uniscaler V3' or select_mod == 'Uniscaler FSR 3.1':
            if os.path.exists(name_dlss):
                old_dlss_rename = messagebox.askyesno('Old DLSS','Do you want to remove DLSS 3.7.0 and revert to the old version?')
                
                if old_dlss_rename:
                    os.remove(new_dlss)
                    os.rename(name_dlss,os.path.join(select_folder,rename_old_dlss))
                
            elif not os.path.exists(name_dlss):
                if os.path.exists(new_dlss):
                    os.remove(new_dlss)

    except Exception as e:
        messagebox.showinfo('DLSS does not exist','DLSS 3.7.0 does not exist or has already been removed previously.')
       
    try:
        if select_option == 'Forza Horizon 5':
            
            if os.path.exists(os.path.join(select_folder,'RestoreNvidiaSignatureChecks.reg')):
                return_rtx_reg = ['regedit.exe', '/s', 'mods\\FSR3_FH\\RTX\\RestoreNvidiaSignatureChecks.reg']

                var_reg_rtx = messagebox.askyesno('Return reg','Do you want to restore NvidiaSignatureChecks values to default? When installing the mod, these values were changed')
                
                if var_reg_rtx:
                    subprocess.run(return_rtx_reg,check=True)
            
            for item_fh in os.listdir(select_folder):
                if item_fh in del_fh_fsr3:
                    os.remove(os.path.join(select_folder,item_fh)) 
                      
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
    
    try:
        icr_en_rtx_reg = ['regedit.exe', '/s', "mods\\FSR3_ICR\\ICARUS_DLSS_3_FOR_RTX\\RestoreNvidiaSignatureChecks.reg"]
        
        if select_mod == 'Icarus FSR3 AMD/GTX': 
            for i_icr in os.listdir(select_folder):
                if i_icr in del_icarus_otgpu_fsr3:
                    os.remove(os.path.join(select_folder,i_icr))
            
            en_rtx_reg = messagebox.askyesno('Enable SigOver','Do you want to re-enable NvidiaSignatureChecks? It was disabled during the mod installation.')
            if en_rtx_reg:
                subprocess.run(icr_en_rtx_reg,check=True) 
                  
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
        path_uni_tlou = os.path.join(select_folder,'uniscaler')
        
        if select_mod == 'Uniscaler Tlou':
            for i_tlou in os.listdir(select_folder):
                if i_tlou in del_tlou_fsr3:
                    os.remove(os.path.join(select_folder,i_tlou))
                    
            if os.path.exists(path_uni_tlou):
                shutil.rmtree(path_uni_tlou)
                
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
        
    try:
        
        if select_mod == 'Horizon Forbidden West FSR3':
            hfw_rtx_reg = ['regedit.exe', '/s', "mods\\FSR3_HFW\\RTX FSR3\\RestoreNvidiaSignatureChecks.reg"]
            hfw_ot_gpu_reg = ['regedit.exe', '/s', "mods\\Temp\\disable signature override\\DisableSignatureOverride.reg"]
            rtx_files = os.path.exists(os.path.join(select_folder,'RestoreNvidiaSignatureChecks.reg'))
            original_exe = os.path.join(select_folder,"HorizonForbiddenWestOriginalEXE.txt")
            
            if rtx_files:
                subprocess.run(hfw_rtx_reg,check=True)
            else:
                subprocess.run(hfw_ot_gpu_reg,check=True)         
                        
            for i_hfw in os.listdir(select_folder):
                if i_hfw in del_hfw_fsr:
                    os.remove(os.path.join(select_folder,i_hfw))
            
            if os.path.exists(original_exe):
                os.remove(os.path.join(select_folder,"HorizonForbiddenWest.exe"))
                os.rename(original_exe,os.path.join(select_folder,"HorizonForbiddenWest.exe"))

    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
    
    if select_option == 'GTA V':
        path_dxgi = os.path.join(select_folder,'dxgi.dll')
        del_all_mods(del_gtav_fsr3,'GTA V','mods')

        if os.path.exists(path_dxgi):
            os.rename(path_dxgi,os.path.join(select_folder,'dxgi.asi'))
    
    if select_option == 'Lords of the Fallen':
        del_all_mods(del_lotf_fsr3,'Lords of the Fallen','uniscaler')
    
    if select_option == 'The Callisto Protocol':
        if select_mod == 'The Callisto Protocol FSR3':
            del_all_mods(del_uni,'The Callisto Protocol','uniscaler')
        
        if os.path.exists(os.path.join(select_folder + '\\The Real Life The Callisto Protocol Reshade BETTER TEXTURES and Realism 2022.ini')):
            del_real_life = messagebox.askyesno('Del Real Life','Do you want to remove the Real Life mod?')

            if del_real_life:
                os.remove(select_folder + '\\The Real Life The Callisto Protocol Reshade BETTER TEXTURES and Realism 2022.ini')
        
        if os.path.exists(os.path.join(select_folder + '\\TCP.ini')):
            del_tcp = messagebox.askyesno('Del TCP','Do you want to remove the TCP mod?')

            if del_tcp:
                os.remove(select_folder + '\\TCP.ini')
    
    if select_option == 'Ghost of Tsushima':
        reg_folder = 'mods\\FSR3_GOT\\Remove_Post_Processing\\restore'
        got_reg = ['regedit.exe', '/s', "mods\\FSR3_GOT\\DLSS FG\\RestoreNvidiaSignatureChecks.reg"]
        
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
             
        subprocess.run(got_reg,check=True)
        del_all_mods(del_got,'Ghost of Tsushima')
             
    if select_option == 'Hellblade 2':
        cpu_reg = ['regedit.exe', '/s', "mods\\FSR3_HB2\\Cpu_Hb2\\Uninstall Hellblade 2 CPU Priority.reg"]
        
        if os.path.exists(os.path.join(select_folder,'DisableNvidiaSignatureChecks.reg')):
            
            del_all_mods(del_hb2,'Hellblade 2')
            hb2_reg = ['regedit.exe', '/s', "mods\\FSR3_GOT\\DLSS FG\\RestoreNvidiaSignatureChecks.reg"]
            
            subprocess.run(hb2_reg,check=True)
        
        if os.path.exists(os.path.join(select_folder,"Install Hellblade 2 CPU Priority.reg")):
            cpu_message = messagebox.askyesno("Anti Stutter","Would you like to remove the Anti Stutter?")
            
            if cpu_message:
                pass
                subprocess.run(cpu_reg,check=True)
            
    if select_option == 'Assassin\'s Creed Valhalla':
        folder_ac = os.path.join(select_folder,'reshade-shaders')
        del_all_mods(del_valhalla_fsr3,'Assassin\'s Creed Valhalla','mods')
        shutil.rmtree(folder_ac)

    try:
        if select_option == 'Alan Wake 2':
            path_old_iniaw2 = os.getenv("LOCALAPPDATA") + '\\Remedy\\AlanWake2\\renderer.ini'
            path_new_iniaw2 = os.path.abspath(os.path.join(path_old_iniaw2,'..','..')) #Look for the backup file renderer.ini in the path C:\Users\YourName\AppData\Local\Remedy

            if os.path.exists(path_new_iniaw2 + '\\renderer.ini'): 
                restore_aw2_ini = messagebox.askyesno('Post-processing','Do you want to restore the post-processing effects?')

                if restore_aw2_ini:
                    shutil.copy2(path_new_iniaw2 + '\\renderer.ini',os.path.abspath(os.path.join(path_old_iniaw2,'..')))
                
                os.remove(path_new_iniaw2 + '\\renderer.ini')
    except Exception as e:
        messagebox.showinfo('Error','Unable to restore the post-processing effects')

    try: 
        if select_addon_mods == "OptiScaler":
            if os.path.exists(os.path.join(select_folder,'amd_fidelityfx_vk.dll')):
                for optis_files in os.listdir(select_folder):
                    if optis_files in del_optiscaler:
                        os.remove(os.path.join(select_folder,optis_files))
            
            if os.path.exists(os.path.join(select_folder,'Backup Dll')):
                shutil.copytree(os.path.join(select_folder,'Backup Dll'),select_folder,dirs_exist_ok=True)
                shutil.rmtree(os.path.join(select_folder,'Backup Dll'))
        optiscaler_reg = ['regedit.exe', '/s', "mods\Addons_mods\OptiScaler\EnableSignatureOverride.reg"]
            
        subprocess.run(optiscaler_reg,check=True)
    except Exception:
        messagebox.showinfo("Optiscaler","Error clearing Optiscaler files, please try again or do it manually")
    
    try: 
        if select_mod == 'FSR 3.1/DLSS Optiscaler':
            if os.path.exists(os.path.join(select_folder,'amd_fidelityfx_vk.dll')):
                for optis_custom_files in os.listdir(select_folder):
                    if optis_custom_files in del_optiscaler_custom:
                        os.remove(os.path.join(select_folder,optis_custom_files))
            
        optiscaler_custom_reg = ['regedit.exe', '/s', "mods\Addons_mods\OptiScaler\EnableSignatureOverride.reg"]
            
        subprocess.run(optiscaler_custom_reg,check=True)
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

        cod_reg = ['regedit.exe', '/s', "mods\Addons_mods\OptiScaler\DisableSignatureOverride.reg"]
            
        subprocess.run(cod_reg,check=True)
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

                wukong_reg = ['regedit.exe', '/s', "mods\Addons_mods\OptiScaler\EnableSignatureOverride.reg"]

                subprocess.run(wukong_reg,check=True)

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
                    wukong_anti_stutter_reg = ['regedit.exe', '/s', r"mods\FSR3_WUKONG\HIGH CPU Priority\Uninstall Black Myth Wukong High Priority Processes.reg"]

                    subprocess.run(wukong_anti_stutter_reg,check=True)

                    os.remove(select_folder + '\\Anti-Stutter - Utility.txt')
                
    except Exception as e:
        messagebox.showinfo('Error','It was not possible to remove the mod files from \'Black Myth: Wukong Bench Tool\'. Please close the game or any other folders related to the game and try again.')

    try:
        if select_option == 'Final Fantasy XVI':
            if os.path.exists(os.path.join(select_folder,'dlssg_to_fsr3_amd_is_better.dll')):
                for ffxvi_rtx in os.listdir(select_folder):
                    if ffxvi_rtx in del_dlss_to_fg:
                        os.remove(os.path.join(select_folder,ffxvi_rtx))

                ffxvi_reg = ['regedit.exe', '/s', "mods\Addons_mods\OptiScaler\EnableSignatureOverride.reg"]

                subprocess.run(ffxvi_reg,check=True) 

        if os.path.exists(os.path.join(select_folder,'dlss_amd.txt')):
            for ffxvi_amd in os.listdir(select_folder):
                if ffxvi_amd in del_dlss_amd:
                    os.remove(os.path.join(select_folder,ffxvi_amd))
        
        elif os.path.exists(os.path.join(select_folder,'dlss_rtx.txt')):
            for ffxvi_rtx in os.listdir(select_folder):
                if ffxvi_rtx in del_dlss_rtx:
                    os.remove(os.path.join(select_folder,ffxvi_rtx))  

        ffxvi_reg_global = ['regedit.exe', '/s', "mods\Addons_mods\OptiScaler\DisableSignatureOverride.reg"]

        if os.path.exists(os.path.join(select_folder,'dlss_amd.txt') or os.path.join(select_folder,'dlss_rtx.txt')):   
            subprocess.run(ffxvi_reg_global ,check=True)

    except Exception as e:
            messagebox.showinfo('Error','It was not possible to remove the mod files from Final Fantasy XVI. Please close the game or any other folders related to the game and try again.')

    try:
        if select_option == 'Star Wars Outlaws':
            remove_anti_stutter_outlaws = ['regedit.exe', '/s', "mods\\FSR3_Outlaws\\Anti_Stutter\\Uninstall Star Wars Outlaws CPU Priority.reg"]
            
            del_all_mods2(del_dlss_to_fg,'Outlaws DLSS RTX')

            if os.path.exists(os.path.join(select_folder,'Anti_Sttuter.txt')):
                outlaws_anti_stutter = messagebox.askyesno('Remove Anti Stutter','Do you want to remove the Anti Stutter?')

                if outlaws_anti_stutter:
                    os.remove(os.path.join(select_folder,'Anti_Sttuter.txt'))
                    subprocess.run(remove_anti_stutter_outlaws,check=True)
    except Exception:   
        messagebox.showinfo('Error','It was not possible to remove the mod files from Star Wars Outlaws. Please close the game or any other folders related to the game and try again.')                             
                                              
cleanup_label = tk.Label(screen,text='Cleanup Mod',font=font_select,bg='black',fg='#E6E6FA')
cleanup_label.place(x=0,y=485) 
cleanup_var = IntVar()
cleanup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=cleanup_var,command=cbox_cleanup)
cleanup_cbox.place(x=100,y=487)       

#Disables the CMD console when starting the game,this function is only available in the mods listed below
disable_var = None
def cbox_disable_console():
   global disable_var
   disable_var = bool(disable_console_var.get())
   edit_disable_console()

def edit_disable_console():
    disable_console_list = {
        '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
        '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
        'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
        'Uniscaler + Xess + Dlss':'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml',
        'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
        'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
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
disable_console_label.place(x=0,y=336)
disable_console_var = IntVar()
disable_console_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=disable_console_var,command=cbox_disable_console)
disable_console_cbox.place(x=117,y=339)

#Copies the lfz file, this file can make old mods work
lfz_list = {
'0.7.4':'mods\Temp\FSR2FSR3_0.7.4\lfz.sl.dlss',
'0.7.5':'mods\Temp\FSR2FSR3_0.7.5_hotfix\lfz.sl.dlss',
'0.7.6':'mods\Temp\FSR2FSR3_0.7.6\lfz.sl.dlss',
'0.8.0':'mods\Temp\FSR2FSR3_0.8.0\lfz.sl.dlssl',
'0.9.0':'mods\Temp\FSR2FSR3_0.9.0\lfz.sl.dlss',
'0.10.0':'mods\Temp\global _lfz',
'0.10.1':'mods\Temp\global _lfz',
'0.10.1h1':'mods\Temp\global _lfz',
'0.10.2h1':'mods\Temp\global _lfz',
'0.10.3':'mods\Temp\global _lfz',
'0.10.4':'mods\Temp\global _lfz',
}

def copy_lfz_sl ():
    global lfz_sl_label_cbox,lfz_list
    lfz_folder = None
    lfz_folder = lfz_list.get(select_mod)
    
    try:
        for item in os.listdir(lfz_folder):
            lfz_path = os.path.join(lfz_folder,item)
            if os.path.isfile(lfz_path):
                shutil.copy2(lfz_path,select_folder)
    except Exception as e:
        pass
    
def var_mod_lfz():
    global lfz_list
    if select_mod not in lfz_list.keys():
        messagebox.showinfo('Error','Please select a version starting from 0.7.4.')
        lfz_sl_label_cbox.deselect()
    elif select_folder is None:
        messagebox.showinfo('Select Folder','Please, select a destination folder')
        lfz_sl_label_cbox.deselect()

def cbox_lfz_sl():
    global lfz_list
    if lfz_sl_var.get() == 1: 
        var_mod_lfz()
    
lfz_sl_label = tk.Label(screen,text='Install lfz.sl.dlss',font=font_select,bg='black',fg='#C0C0C0')
lfz_sl_label.place(x=0,y=393)
lfz_sl_var = IntVar()
lfz_sl_label_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=lfz_sl_var,command=cbox_lfz_sl)
lfz_sl_label_cbox.place(x=120,y=395)
guide_fsr_label.lift(lfz_sl_label)

#For enabling FSR3FG debug overlay, through the .toml file
var_debug_tear = None
def cbox_debug_tear_lines():
    global var_debug_tear
    var_debug_tear = bool(debug_tear_lines_var.get())
    edit_debug_tear_lines()

def edit_debug_tear_lines():
    debug_tear_lines_list = {
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3': 'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
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
debug_tear_lines_label.place(x=200,y=336)
debug_tear_lines_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_tear_lines_var,command=cbox_debug_tear_lines)
debug_tear_lines_cbox.place(x=329,y=339)

var_deb_view = False
def cbox_debug_view():
    global var_deb_view
    var_deb_view = bool(debug_view_var.get())
    edit_debug_view()
    
def edit_debug_view():
    global var_deb_view
    debug_view_mod_list = {
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3': 'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
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
debug_view_label.place(x=200,y=306)
debug_view_var = IntVar()
debug_view_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_view_var,command=cbox_debug_view)
debug_view_cbox.place(x=290,y=309)

#Helps the mod work in some specific games, for example, The Callisto Protocol, 2 values are added to the registry editor, the path is available in the .reg file in the Temp folder
def enable_over():
    global list_over
    folder_en_over = 'mods\Temp\enable signature override\EnableSignatureOverride.reg'
    list_over = ['0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','FSR 3.1 Custom Wukong']

    if select_mod in list_over:
        subprocess.run(['regedit','/s',folder_en_over],capture_output=True)

def disable_over():
    global list_over
    folder_dis_over = 'mods\Temp\disable signature override\DisableSignatureOverride.reg'
    if select_mod in list_over:
        subprocess.run(['regedit','/s',folder_dis_over],capture_output=True)
        
def cbox_enable_sigover():
    if enable_sigover_var.get() == 1:
        enable_over()
    
enable_sigover_label = tk.Label(screen,text='Enable Signature Over',font=font_select,bg='black',fg='#C0C0C0')
enable_sigover_label.place(x=0,y=423)
enable_sigover_var = IntVar()
enable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=enable_sigover_var,command=cbox_enable_sigover)
enable_sigover_cbox.place(x=165,y=425)

def cbox_disable_sigover():
    if disable_sigover_var.get() == 1:
        disable_over()

disable_sigover_label = tk.Label(screen,text='Disable Signature Over',font=font_select,bg='black',fg='#C0C0C0')
disable_sigover_label.place(x=205,y=423)
disable_sigover_var = IntVar()
disable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=disable_sigover_var,command=cbox_disable_sigover)
disable_sigover_cbox.place(x=373,y=425)
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
            dxgi_listbox.place(x=520,y=448)
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
    path_dxgi_global = 'mods\Temp\dxgi_global'
    for dxgi_key in  ['0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1',
                    '0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1']:
    
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
dxgi_label.place(x=420,y=423)
dxgi_var = IntVar()
dxgi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=dxgi_var,command=cbox_dxgi)
dxgi_cbox.place(x=493,y=424)
dxgi_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
dxgi_canvas.place(x=520,y=427)
dxgi_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)
dxgi_listbox.place(x=520,y=448)
dxgi_listbox.place_forget()

#Copy .dll files that can help specific games to function. The Default option includes the default nvngx.dll, and it also has the files DLSS 3.7.0 and XESS 1.3
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
            nvngx_listbox.place(x=520,y=420)
            nvngx_view = True
            
def nvngx_listbox_contr():
    global nvngx_view
    if not nvngx_contr and nvngx_view:
        nvngx_listbox.place_forget()
        nvngx_view = False
    
nvngx_label = tk.Label(screen,text='Nvngx.dll',font=font_select,bg='black',fg='#C0C0C0')
nvngx_label.place(x=420,y=393)
nvngx_var = IntVar()
nvngx_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=nvngx_var,command=cbox_nvngx)
nvngx_cbox.place(x=493,y=395)
nvngx_canvas = tk.Canvas(screen,width=103,height=19,bg='#C0C0C0',highlightthickness=0)
nvngx_canvas.place(x=520,y=398)
nvngx_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)
nvngx_listbox.pack(side=tk.RIGHT,expand=True,padx=(0,15),pady=(0,410))
nvngx_listbox.place(x=520,y=420)
nvngx_listbox.place_forget()
uni_custom_listbox.lift(nvngx_canvas)

nvngx_path_global = 'mods\Temp\\nvngx_global\\nvngx'
nvngx_folders = {}

for nvn_key in [
    '0.7.6', '0.8.0', '0.9.0', '0.10.0', '0.10.1', '0.10.1h1', 
    '0.10.2h1', '0.10.3', '0.10.4', 'RDR2 Build_2', 'RDR2 Build_4', 
    'Uniscaler', 'Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1'
]:
    nvngx_folders[nvn_key] = nvngx_path_global

def copy_nvngx():
    global nvngx_folders
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
                
                elif os.path.isfile(nvn_path) and select_nvngx == 'DLSS 3.7.0':
                    if item == 'nvngx_dlss.dll':
                        name_dlss = os.path.join(select_folder,'nvngx_dlss.dll')
                        name_old_dlss = os.path.join(select_folder,'nvngx_dlss.txt')
                        rename_dlss = 'nvngx_dlss.txt'
                        if os.path.exists(name_dlss) and not os.path.exists(name_old_dlss):
                            os.rename(name_dlss,os.path.join(select_folder,rename_dlss))
                        shutil.copy2(nvn_path, select_folder)
                
                elif os.path.isfile(nvn_path) and select_nvngx == 'DLSS 3.7.0 FG':
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
                
            if select_nvngx == 'DLSS 3.7.2':
                path_dlss_371 = 'mods\\Temp\\nvngx_global\\nvngx\\Dlss_3_7_1\\nvngx_dlss.dll'
                name_dlss_371 = os.path.join(select_folder, 'nvngx_dlss.dll')
                name_old_dlss_371 = os.path.join(select_folder, 'nvngx_dlss.txt')
                rename_dlss_371 = 'nvngx_dlss.txt'
                
                copy_dlss(name_dlss_371,name_old_dlss_371,path_dlss_371,rename_dlss_371)
            
            elif select_nvngx == 'DLSSG 3.7.1 FG':
                path_dlssg_371 = 'mods\\Temp\\nvngx_global\\nvngx\\Dlssg_3_7_1\\nvngx_dlssg.dll'
                name_dlssg_371 = os.path.join(select_folder, 'nvngx_dlssg.dll')
                name_old_dlssg_371 = os.path.join(select_folder, 'nvngx_dlssg.txt')
                rename_dlssg_371 = 'nvngx_dlssg.txt'
                
                copy_dlss(name_dlssg_371,name_old_dlssg_371,path_dlssg_371,rename_dlssg_371)
            
            elif select_nvngx == 'DLSSD 3.7.1':
                path_dlssd_371 = 'mods\\Temp\\nvngx_global\\nvngx\\Dlssd_3_7_1\\nvngx_dlssd.dll'
                name_dlssd_371 = os.path.join(select_folder, 'nvngx_dlssd.dll')
                name_old_dlssd_371 = os.path.join(select_folder, 'nvngx_dlssd.txt')
                rename_dlssd_371 = 'nvngx_dlssd.txt'
                
                copy_dlss(name_dlssd_371,name_old_dlssd_371,path_dlssd_371,rename_dlssd_371)
                                                      
        except Exception as e:
            messagebox.showinfo("Error","Please select the destination folder and the mod version")

#Modify the upscaler resolution through the .toml file, with no default values like the Uniscaler Custom function, users can add values as they wish           
custom_fsr_act = False
def unlock_custom():
    list_custom = ['0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1']
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
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3': 'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
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
    '0.7.4':'mods\Temp\FSR2FSR3_0.7.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.7.5':'mods\Temp\FSR2FSR3_0.7.5_hotfix\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.7.6':'mods\Temp\FSR2FSR3_0.7.6\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.8.0':'mods\Temp\FSR2FSR3_0.8.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3': 'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'The Callisto Protocol FSR3':'mods\\FSR3_Callisto\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uni Custom Miles':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml',
    'Dlss Jedi':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml',
    'FSR 3.1 Custom Wukong':'mods\\Temp\\Wukong_FSR31\\enable_fake_gpu\\uniscaler.config.toml'
}

def fake_gpu_mod():
    global folder_fake_gpu
    
    key_1 = 'compatibility'
    sob_line = 'fake_nvidia_gpu = true'
    
    if select_mod in folder_fake_gpu:
       folder_gpu = folder_fake_gpu[select_mod]  
       
    edit_fake_gpu_list = ['0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uni Custom Miles','Dlss Jedi','FSR 3.1 Custom Wukong']
    
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
        
    edit_fakegpu_list = ['0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uni Custom Miles','Dlss Jedi','FSR 3.1 Custom Wukong']
    
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
    if fakegpu_cbox_var.get() == 1:
        fake_gpu_mod()
        fakegpu_cbox_var.set == 0
    else:
        fakegpu_cbox_var.set == 1
        default_fake_gpu()

fakegpu_label = tk.Label(screen,text='Fake NVIDIA GPU',font=font_select,bg='black',fg='#C0C0C0')
fakegpu_label.place(x=0,y=185)
fakegpu_cbox_var = tk.IntVar()
fakegpu_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=fakegpu_cbox_var,command=cbox_fakegpu)
fakegpu_cbox.place(x=133,y=187)

#Workaround graphical artifacts in Unreal Engine games when selecting DLSS
list_ue = {
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3': 'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
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
ue_label.place(x=200,y=185)
ue_cbox_var = tk.IntVar()
ue_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=ue_cbox_var,command=cbox_ue)
ue_cbox.place(x=367,y=187)

#Fixes issues with DLSS/FG not available on GTX GPUs
list_nvapi = {
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3': 'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'Uni Custom Miles':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml',
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
nvapi_label.place(x=0,y=215)
nvapi_cbox_var = tk.IntVar()
nvapi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=nvapi_cbox_var,command=cbox_nvapi)
nvapi_cbox.place(x=118,y=218)

#Enable macOS-specific compatibility tweak
list_macos = {
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3': 'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
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
macos_sup_label.place(x=200,y=215)
macos_sup_var = tk.IntVar()
macos_sup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=macos_sup_var,command=cbox_macos)
macos_sup_cbox.place(x=387,y=217)

#Deletes the .toml file modified by the user and replaces it with a new one
default_path ={
    '0.7.4':'mods\Temp\FSR2FSR3_0.7.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.7.5':'mods\Temp\FSR2FSR3_0.7.5_hotfix\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.7.6':'mods\Temp\FSR2FSR3_0.7.6\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.8.0':'mods\Temp\FSR2FSR3_0.8.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'The Callisto Protocol FSR3':'mods\\Temp\\FSR3_Callisto\\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3': 'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'Uni Custom Miles':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml',
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
            '0.7.4':'mods\FSR2FSR3_0.7.4\enable_fake_gpu',
            '0.7.5':'mods\FSR2FSR3_0.7.5_hotfix\enable_fake_gpu',
            '0.7.6':'mods\FSR2FSR3_0.7.6\enable_fake_gpu',
            '0.8.0':'mods\FSR2FSR3_0.8.0\enable_fake_gpu',
            '0.9.0':'mods\FSR2FSR3_0.9.0\enable_fake_gpu',
            '0.10.0':'mods\FSR2FSR3_0.10.0\enable_fake_gpu',
            '0.10.1':'mods\FSR2FSR3_0.10.1\enable_fake_gpu',
            '0.10.1h1':'mods\FSR2FSR3_0.10.1h1\enable_fake_gpu',
            '0.10.2h1':'mods\FSR2FSR3_0.10.2h1\enable_fake_gpu',
            '0.10.3':'mods\FSR2FSR3_0.10.3\enable_fake_gpu',
            '0.10.4':'mods\FSR2FSR3_0.10.4\enable_fake_gpu',
            'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\enable_fake_gpu',
            'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu',
            'The Callisto Protocol FSR3':'mods\\FSR3_Callisto\\enable_fake_gpu',
            'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\enable_fake_gpu',
            'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\enable_fake_gpu',
            'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\enable_fake_gpu',
            'Uni Custom Miles':'mods\\FSR2FSR3_Miles\\uni_miles_toml',
            'Dlss Jedi':'mods\\FSR2FSR3_Miles\\uni_miles_toml',
            'FSR 3.1 Custom Wukong':'mods\\FSR3_WUKONG\\WukongFSR31\\enable_fake_gpu'
        }
        
        clean_file_rep = {
            '0.7.4':'mods\Temp\FSR2FSR3_0.7.4\enable_fake_gpu',
            '0.7.5':'mods\Temp\FSR2FSR3_0.7.5_hotfix\enable_fake_gpu',
            '0.7.6':'mods\Temp\FSR2FSR3_0.7.6\enable_fake_gpu',
            '0.8.0':'mods\Temp\FSR2FSR3_0.8.0\enable_fake_gpu',
            '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu',
            '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu',
            '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu',
            '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu',
            '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu',
            '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu',
            '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu',
            'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu',
            'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu',
            'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu',
            'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu',
            'The Callisto Protocol FSR3':'mods\\Temp\\FSR3_Callisto\\enable_fake_gpu',
            'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu',
            'Uni Custom Miles':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu',
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
open_editor_label.place(x=200,y=277)
open_editor_var = tk.IntVar()
open_editor_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=open_editor_var,command=cbox_editor)
open_editor_cbox.place(x=335,y=279)

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
    mod_list_sharp = ['0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1']
    if select_mod in mod_list_sharp:
        unlock_cbox_sharp = True
    else:
        unlock_cbox_sharp = False
        
def edit_sharpeness_up():
    global unlock_cbox_sharp
    list_mod_sharpness={
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
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

fg_mode_list = ['Uniscaler FSR 3.1']
fg_mode_visible = False
unlock_listbox_fg_mode = False
select_fg_mode = None

def unlock_fg_mode():
    global unlock_listbox_fg_mode
    if select_mod == 'Uniscaler FSR 3.1':
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
    path_fg_mode = {'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml'}
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
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml',
    'Uniscaler V2':'mods\\Temp\\Uniscaler_V2\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler V3':'mods\\Temp\\Uniscaler_V3\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler FSR 3.1':'mods\\Temp\\Uniscaler_FSR31\\enable_fake_gpu\\uniscaler.config.toml',
    'Uni Custom Miles':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml',
    'Dlss Jedi':'mods\\Temp\\FSR3_Miles\\enable_fake_gpu\\uniscaler.config.toml'
    }

    list_ignore_uniscaler_custom = ['Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uni Custom Miles','Dlss Jedi']
    
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

asi_label = tk.Label(screen,text='ASI Loader:',font=font_select,bg='black',fg='#C0C0C0')
asi_label.place(x=0,y=146)
asi_optional_label = tk.Label(screen,text='optional',font=(font_select, 7),bg='black',fg='#696969')
asi_optional_label.place(x=10,y=166)
asi_canvas = Canvas(screen,width=205,height=19,bg='white',highlightthickness=0)
asi_canvas.place(x=101,y=150)

asi_listbox = tk.Listbox(screen,bg='white',width=34,height=0,highlightthickness=0)
asi_listbox.pack(side=tk.RIGHT,expand=True,padx=(0,15),pady=(0,410))
asi_listbox.pack_forget()

select_asi_label = tk.Label(screen,text='ASI:',font=font_select,bg='black',fg='#C0C0C0')
select_asi_label.place(x=313,y=145)
select_asi_canvas = tk.Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
select_asi_canvas.place(x=350,y=149)

select_asi_listbox = tk.Listbox(screen,bg='white',width=8,height=0,highlightthickness=0)
select_asi_listbox.pack(side=tk.RIGHT,expand=True,padx=(320,0),pady=(0,413))
select_asi_listbox.pack_forget()

asi_listbox_visible = False
def asi_listbox_view(event):
    global asi_listbox_visible
    if asi_listbox_visible:
        asi_listbox.place_forget()
        asi_listbox_visible = False
    else:
        asi_listbox.place(x=101,y=171)
        asi_listbox_visible = True
        
select_asi_visible = False  
select_asi_notvisible = False      
def select_asi_view(event):
    global select_asi_visible,select_asi_notvisible
    if select_asi_notvisible:
        if select_asi_visible:
            select_asi_listbox.place_forget()
            select_asi_visible = False
        else:
            select_asi_listbox.place(x=350,y=170)
            select_asi_visible = True

select_folder_canvas = Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
select_folder_canvas.place(x=350,y=75)
select_folder_canvas.create_text(0,8,anchor='w',font=('Arial',9,'bold'),text='Browser',fill='black')
select_folder_label = tk.Label(screen,text='–',font=font_select,bg='black',fg='#C0C0C0')
select_folder_label.place(x=318,y=70)
select_folder = None

search_game_exe_canvas = tk.Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
search_game_exe_canvas.place(x=350,y=95)
search_game_exe_canvas.create_text(9,8,anchor='w',font=('Arial',9,'bold'),text='Auto',fill='black')

#Function to select the game folder and create the selected path text on the Canvas
def open_explorer(event=None): 
    global select_folder
    select_folder = filedialog.askdirectory()
    game_folder_canvas.delete('text')
    game_folder_canvas.create_text(2,8, anchor='w',text=select_folder,fill='black',tags='text') 

def auto_search(path_origin,alt_path_origin,exe_name,game_select): #auto search for the exe path
    global select_folder
    user_disk_part = search_un()
    path_over = None
    
    try:
        for disk_name in user_disk_part:
            default_path = os.path.join(disk_name,path_origin)
            if os.path.exists(default_path):
                for root, dirs, files in os.walk(default_path):
                    for file_name in files:
                        if file_name.endswith(exe_name):
                            game_path = os.path.abspath(root)
                            if game_select in game_path:
                                path_over = os.path.join(root, file_name)
                                break
                    if path_over:
                        break
                if path_over:
                    break
            
            alt_path = os.path.join(disk_name, alt_path_origin)
            if os.path.exists(alt_path):
                for root, dirs, files in os.walk(alt_path):
                    for file_name in files:
                        if file_name.endswith(exe_name):
                            game_path = os.path.abspath(root)
                            if game_select in game_path: 
                                path_over = os.path.join(root, file_name)
                                break
                    if path_over:
                        break
                if path_over:
                    break
    except Exception:
            messagebox.showinfo('Error','Error while fetching the path, please verify if you have selected the game correctly and try again.')
            return
    
    if path_over is not None:
        select_folder = os.path.dirname(path_over)
        game_folder_canvas.delete('text')
        game_folder_canvas.create_text(2,8, anchor='w',text=path_over,fill='black',tags='text') 
        messagebox.showinfo('Sucess',f'Path found, please verify if it\'s correct: {path_over}')
    else:
        messagebox.showinfo('Not Found', 'Exe not found, please select the path manually')
    
def search_game_exe(event=None):
        exe_name = "Win64-Shipping.exe"
        if select_option is not None:
            game_select = select_option.replace(":", "").replace(" ", "")
            
        path_steam = 'Program Files (x86)\Steam\steamapps\common'
        alt_path_steam = 'SteamLibrary\steamapps\common'
        
        path_epic = 'Program Files\Epic Games'
        alt_path_epic = 'Epic Games'
        
        game_select_tlou = select_option
        tlou_name = 'tlou-i.exe'
        rdr2_name = 'RDR2.exe'
        hfw_name = 'HorizonForbiddenWest.exe'
        u4_name = 'u4.exe',
        hzd_name = 'HorizonZeroDawn.exe'
        aw2_name = 'AlanWake2.exe'
        bg3_name = 'bg3.exe'
        cyber2077_name = 'Cyberpunk2077.exe'
        er_name = 'eldenring.exe'
        spider_name = 'Spider-Man.exe'
        spider_miles_name = 'MilesMorales.exe'
        dd2_name = 'DD2.exe'
        fl4_name = 'Fallout4.exe',
        hogw_name = 'HogwartsLegacy.exe',
        hellbalde_name = 'HellbladeGame-Win64-Shipping.exe',
        lop_name = 'LOP-Win64-Test.exe',
        ratchet_name = 'RiftApart.exe',
        es2_name  = 'ES2-Win64-Shipping.exe'
        sr_name = 'Steelrising.exe'
        
        game_search_origins = {'The Last of Us Part I':tlou_name,
                                'Red Dead Redemption 2':rdr2_name,
                                'Horizon Forbidden West':hfw_name,
                                'Horizon Zero Dawn':hzd_name,
                                'Uncharted Legacy of Thieves Collection':u4_name,
                                'Alan Wake 2':aw2_name,
                                'Baldur\'s Gate 3':bg3_name,
                                'Cyberpunk 2077':cyber2077_name,
                                'Marvel\'s Spider-Man Remastered':spider_name,
                                'Marvel\'s Spider-Man Miles Morales':spider_miles_name,
                                'Dragons Dogma 2':dd2_name,
                                'Fallout 4':fl4_name,
                                'Ratchet & Clank - Rift Apart':ratchet_name,
                                'Steelrising': sr_name
                               
                               }
        
        if select_option is not None:
            steam_path = messagebox.askyesno('Steam','Is your game on Steam?')
            if steam_path:
                if select_option in game_search_origins:
                    auto_search(path_steam, alt_path_steam, game_search_origins[select_option], game_select_tlou)
                elif select_option == 'Elden Ring':
                    auto_search(path_steam, alt_path_steam,er_name,'ELDEN RING')
                elif select_option == 'Hellblade: Senua\'s Sacrifice':
                    auto_search(path_steam, alt_path_steam,hellbalde_name,'Hellblade')
                elif select_option == 'Hogwarts Legacy':
                    auto_search(path_steam+'\Hogwarts Legacy\Phoenix\Binaries\Win64', alt_path_steam+'\Hogwarts Legacy\Phoenix\Binaries\Win64',hogw_name,'Hogwarts Legacy')
                elif select_option == 'Lies of P':
                    auto_search(path_steam, alt_path_steam,lop_name,'Lies of P')     
                elif select_option == 'Everspace 2':     
                    auto_search(path_steam, alt_path_steam,es2_name,'Everspace 2')  
                else:
                    auto_search(path_steam,alt_path_steam,exe_name,game_select)
            else:
                epic_path = messagebox.askyesno('Epic Games','Is your game on Epic Games?')
                if epic_path:
                    if select_option in game_search_origins:
                        auto_search(path_epic, alt_path_epic, game_search_origins[select_option], game_select_tlou)
                    else:
                        auto_search(path_epic,alt_path_epic,exe_name,game_select)
                else:
                    messagebox.showinfo('Select Folder','Please select the path manually')
        else:            
            messagebox.showinfo('Error','Please select a game')
               
asi_global={
    '0.7.4':{
        '2.0':'mods\ASI\\ASI_0_7_4\\2.0',
        '2.1':'mods\\ASI\\ASI_0_7_4\\2.1',
        '2.2':'mods\\ASI\\ASI_0_7_4\\2.2',
        'SDK':'mods\\ASI\\ASI_0_7_4\\SDK',
    },
    '0.7.5':{
        '2.0':'mods\ASI\\ASI_0_7_5\\2.0',
        '2.1':'mods\\ASI\\ASI_0_7_5\\2.1',
        '2.2':'mods\\ASI\\ASI_0_7_5\\2.2',
        'SDK':'mods\\ASI\\ASI_0_7_5\\SDK',
    },
    '0.7.6':{
        '2.0':'mods\ASI\\ASI_0_7_6\\2.0',
        '2.1':'mods\\ASI\\ASI_0_7_6\\2.1',
        '2.2':'mods\\ASI\\ASI_0_7_6\\2.2',
        'SDK':'mods\\ASI\\ASI_0_7_6\\SDK',
    },
    '0.8.0':{
        '2.0':'mods\ASI\\ASI_0_8_0\\2.0',
        '2.1':'mods\\ASI\\ASI_0_8_0\\2.1',
        '2.2':'mods\\ASI\\ASI_0_8_0\\2.2',
        'SDK':'mods\\ASI\\ASI_0_8_0\\SDK',
    },
    '0.9.0':{
        '2.0':'mods\ASI\\ASI_0_9_0\\2.0',
        '2.1':'mods\\ASI\\ASI_0_9_0\\2.1',
        '2.2':'mods\\ASI\\ASI_0_9_0\\2.2',
        'SDK':'mods\\ASI\\ASI_0_9_0\\SDK',
        'ASI Loader for RDR2':'mods\FSR2FSR3_0.9.0\Red Dead Redemption 2'
    },
    '0.10.0':{
        '2.0':'mods\ASI\\ASI_0_10_0\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_0\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_0\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_0\\SDK',
        'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.0\Red Dead Redemption 2',
    },
    '0.10.1':{
        '2.0':'mods\ASI\\ASI_0_10_1\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_1\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_1\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_1\\SDK',
        'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.1\Red Dead Redemption 2',
    },
    '0.10.1h1':{
        '2.0':'mods\ASI\\ASI_0_10_1h1\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_1h1\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_1h1\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_1h1\\SDK',
        'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.1h1\Red Dead Redemption 2',
    },
    '0.10.2h1':{
        '2.0':'mods\ASI\\ASI_0_10_2h1\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_2h1\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_2h1\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_2h1\\SDK',
        'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.2h1\Red Dead Redemption 2',
    },
    '0.10.3':{
        '2.0':'mods\ASI\\ASI_0_10_3\\2.0',
        '2.1':'mods\\ASI\\ASI_0_10_3\\2.1',
        '2.2':'mods\\ASI\\ASI_0_10_3\\2.2',
        'SDK':'mods\\ASI\\ASI_0_10_3\\SDK',
        'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.3\Red Dead Redemption 2',
    },
    '0.10.4':{
        '2.0':'mods\ASI\\ASI_0_10_4\\2.0',
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
    'Uniscaler FSR 3.1':{
        'Uniscaler FSR 3.1':'mods\\ASI\\ASI_uniscaler_v3'
    },
    'Uniscaler + Xess + Dlss':{
        'Uniscaler + Xess + Dlss':r'mods\ASI\ASI_uniscaler_xess_dlss'
    }
}

origins_2_2 = None
    
origins_2_2_folder = {
    '0.7.4':'mods\FSR2FSR3_0.7.4\FSR2FSR3_220',
    
    '0.7.5':'mods\FSR2FSR3_0.7.5_hotfix\FSR2FSR3_220',
    
    '0.7.6':'mods\FSR2FSR3_0.7.6\FSR2FSR3_220',
    
    '0.8.0':'mods\FSR2FSR3_0.8.0\FSR2FSR3_220',
    
    '0.9.0':['mods\FSR2FSR3_0.9.0\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.9.0\FSR2FSR3_COMMON'],
    
    '0.10.0':['mods\FSR2FSR3_0.10.0\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.0\FSR2FSR3_COMMON'],
    
    '0.10.1':['mods\FSR2FSR3_0.10.1\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.1\FSR2FSR3_COMMON'],
    
    '0.10.1h1':['mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\Generic FSR\\FSR2FSR3_220',
                'mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\FSR2FSR3_COMMON'],
    
    '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON'],
    
    '0.10.3':['mods\FSR2FSR3_0.10.3\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON'],
    
    '0.10.4':['mods\FSR2FSR3_0.10.4\FSR2FSR3_220\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.4\FSR2FSR3_220\FSR2FSR3_COMMON'],
    
    'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
    'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod',
    'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
    'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
    'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\Uniscaler_FSR31'
    }

list_ignore_uniscaler = ['Uniscaler','Uniscaler + Xess + Dlss','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1']

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
            if option_asi == 'ASI Loader for RDR2' and option_asi in asi_global[select_mod]:
                origins_2_2_f = asi_global[select_mod][option_asi]
            elif select_asi in asi_global[select_mod]:
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
        '0.7.4':'mods\FSR2FSR3_0.7.4\FSR2FSR3_212',
        
        '0.7.5':'mods\FSR2FSR3_0.7.5_hotfix\FSR2FSR3_212',
        
        '0.7.6':'mods\FSR2FSR3_0.7.6\FSR2FSR3_212',
        
        '0.8.0':'mods\FSR2FSR3_0.8.0\FSR2FSR3_212',
        
        '0.9.0':['mods\FSR2FSR3_0.9.0\Generic FSR\FSR2FSR3_210',
                 'mods\FSR2FSR3_0.9.0\FSR2FSR3_COMMON'],
        
        '0.10.0':['mods\FSR2FSR3_0.10.0\Generic FSR\FSR2FSR3_210',
                  'mods\FSR2FSR3_0.10.0\FSR2FSR3_COMMON'],
        
        '0.10.1':['mods\FSR2FSR3_0.10.1\Generic FSR\FSR2FSR3_210',
                    'mods\FSR2FSR3_0.10.1\FSR2FSR3_COMMON'],
        
        '0.10.1h1':['mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\Generic FSR\\FSR2FSR3_210',
                    'mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\Generic FSR\FSR2FSR3_210',
                    'mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\FSR2FSR3_0.10.3\Generic FSR\FSR2FSR3_210',
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\FSR2FSR3_0.10.4\FSR2FSR3_210\FSR2FSR3_210',
                  'mods\FSR2FSR3_0.10.4\FSR2FSR3_210\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod',
        'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
        'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
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
            if option_asi == 'ASI Loader for RDR2' and option_asi in asi_global[select_mod]:
                origins_2_1_f = asi_global[select_mod][option_asi]
            elif select_asi in asi_global[select_mod]:
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
        '0.7.4':'mods\FSR2FSR3_0.7.4\FSR2FSR3_201',
        
        '0.7.5':'mods\FSR2FSR3_0.7.5_hotfix\FSR2FSR3_201',
        
        '0.7.6':'mods\FSR2FSR3_0.7.6\FSR2FSR3_201',
        
        '0.8.0':'mods\FSR2FSR3_0.8.0\FSR2FSR3_201',
        
        '0.9.0':['mods\FSR2FSR3_0.9.0\Generic FSR\FSR2FSR3_200',
                 'mods\FSR2FSR3_0.9.0\FSR2FSR3_COMMON'],
        
        '0.10.0':['mods\FSR2FSR3_0.10.0\Generic FSR\FSR2FSR3_200',
                  'mods\FSR2FSR3_0.10.0\FSR2FSR3_COMMON'],
        
        '0.10.1':['mods\FSR2FSR3_0.10.1\Generic FSR\FSR2FSR3_200',
                    'mods\FSR2FSR3_0.10.1\FSR2FSR3_COMMON'],
        
        '0.10.1h1':['mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\Generic FSR\\FSR2FSR3_200',
                    'mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\Generic FSR\FSR2FSR3_200',
                    'mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\FSR2FSR3_0.10.3\Generic FSR\FSR2FSR3_200',
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\FSR2FSR3_0.10.4\FSR2FSR3_200\FSR2FSR3_200',
                  'mods\FSR2FSR3_0.10.4\FSR2FSR3_200\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod',
        'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
        'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
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
            if option_asi == 'ASI Loader for RDR2' and option_asi in asi_global[select_mod]:
                origins_2_0_f = asi_global[select_mod][option_asi]
            elif select_asi in asi_global[select_mod]:
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
        '0.7.4':'mods\FSR2FSR3_0.7.4\FSR2FSR3_SDK',
        
        '0.7.5':'mods\FSR2FSR3_0.7.5_hotfix\FSR2FSR3_SDK',
        
        '0.7.6':'mods\FSR2FSR3_0.7.6\FSR2FSR3_SDK',
        
        '0.8.0':'mods\FSR2FSR3_0.8.0\FSR2FSR3_SDK',
        
        '0.9.0':['mods\FSR2FSR3_0.9.0\Generic FSR\FSR2FSR3_SDK',
                 'mods\FSR2FSR3_0.9.0\FSR2FSR3_COMMON'],
        
        '0.10.0':['mods\FSR2FSR3_0.10.0\Generic FSR\FSR2FSR3_SDK',
                  'mods\FSR2FSR3_0.10.0\FSR2FSR3_COMMON'],
        
        '0.10.1':['mods\FSR2FSR3_0.10.1\Generic FSR\FSR2FSR3_SDK',
                    'mods\FSR2FSR3_0.10.1\FSR2FSR3_COMMON'],
        
        '0.10.1h1':['mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\Generic FSR\\FSR2FSR3_SDK',
                    'mods\\FSR2FSR3_0.10.1h1\\0.10.1h1\\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\Generic FSR\FSR2FSR3_SDK',
                    'mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\FSR2FSR3_0.10.3\Generic FSR\FSR2FSR3_SDK',
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\FSR2FSR3_0.10.4\FSR2FSR3_SDK\FSR2FSR3_SDK',
                  'mods\FSR2FSR3_0.10.4\FSR2FSR3_SDK\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod',
        'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
        'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
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
            if option_asi == 'ASI Loader for RDR2' and option_asi in asi_global[select_mod]:
                origins_sdk_f = asi_global[select_mod][option_asi]
            elif select_asi in asi_global[select_mod]:
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

origins_rdr2_folder = {
        '0.9.0':['mods\FSR2FSR3_0.9.0\Red Dead Redemption 2',
                 'mods\FSR2FSR3_0.9.0\FSR2FSR3_COMMON'],
        
        '0.10.0':['mods\FSR2FSR3_0.10.0\FSR2FSR3_COMMON',
                  'mods\FSR2FSR3_0.10.0\Red Dead Redemption 2'],
        
        '0.10.1':['mods\FSR2FSR3_0.10.1\FSR2FSR3_COMMON',
                    'mods\FSR2FSR3_0.10.1\Red Dead Redemption 2'],
        
        '0.10.1h1':['mods\FSR2FSR3_0.10.1h1\\0.10.1h1\FSR2FSR3_COMMON',
                    'mods\FSR2FSR3_0.10.1h1\\0.10.1h1\Red Dead Redemption 2'],
        
        '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON',
                    'mods\FSR2FSR3_0.10.2h1\Red Dead Redemption 2'],
        
        '0.10.3':['mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON',
                  'mods\FSR2FSR3_0.10.3\Red Dead Redemption 2'],
        
        '0.10.4':['mods\FSR2FSR3_0.10.4\Red Dead Redemption 2\FSR2FSR3_COMMON',
                  'mods\FSR2FSR3_0.10.4\Red Dead Redemption 2\RDR2_FSR'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':'mods\\FSR2FSR3_Uniscaler_Xess_Dlss\\Uniscaler_mod\\Uniscaler_mod',
        'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
        'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
        'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\Uniscaler_FSR31'
    }

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
    path_dlss = r'mods\FSR2FSR3_Uniscaler\nvngx_dlss_3.7.0'
    
    name_dlss = os.path.join(select_folder,'nvngx_dlss.dll')
    name_old_dlss = os.path.join(select_folder,'nvngx_dlss.txt')
    
    rename_dlss = 'nvngx_dlss.txt'
    
    put_dlss = messagebox.askyesno('DLSS 3.7.0','Do you want to enable DLSS 3.7.0?')
    
    if put_dlss and os.path.exists(name_dlss) and not os.path.exists(name_old_dlss) and select_nvngx != 'DLSS 3.7.0':
        os.rename(name_dlss,os.path.join(select_folder,rename_dlss)) 
    
    if put_dlss and select_nvngx != 'DLSS 3.7.0' or put_dlss and not nvngx_contr :
        shutil.copytree(path_dlss,select_folder,dirs_exist_ok=True)

def global_dlss():
    path_dlss_rtx = 'mods\\DLSS_Global\\AMD'
    path_dlss_amd = 'mods\\DLSS_Global\\RTX'
    dlss_global_reg = ['regedit.exe', '/s', "mods\\FSR3_LOTF\\RTX\\LOTF_DLLS_3_RTX\\DisableNvidiaSignatureChecks.reg"]

    var_global_dlss = messagebox.askyesno('GPU','Do you have a GPU starting from GTX 1660?')

    if var_global_dlss:
        shutil.copytree(path_dlss_rtx,select_folder,dirs_exist_ok=True)
    
    else:
        shutil.copytree(path_dlss_amd,select_folder,dirs_exist_ok=True)

    subprocess.run(dlss_global_reg,check=True)

def dlss_to_fsr():
    path_dlss_to_fsr = 'mods\DLSS_TO_FSR'
    dlss_to_fsr_reg = ['regedit.exe', '/s', "mods\\FSR3_LOTF\\RTX\\LOTF_DLLS_3_RTX\\DisableNvidiaSignatureChecks.reg"]

    shutil.copytree(path_dlss_to_fsr,select_folder,dirs_exist_ok=True)

    subprocess.run(dlss_to_fsr_reg,check=True)

def fsr_rdr2():
    global select_fsr,select_mod,origins_rdr2_folder
    
    if select_mod in origins_rdr2_folder:
        origins_rdr2 = origins_rdr2_folder[select_mod]
    
    if select_mod not in list_uni:
        try:
            for origin_folder in origins_rdr2:
                for item in os.listdir(origin_folder):
                    item_path = os.path.join(origin_folder,item)
                    if os.path.isfile(item_path):
                        shutil.copy2(item_path,select_folder)
        except Exception as e:
            print(e)
    else:
        try:
            shutil.copytree(origins_rdr2, select_folder, dirs_exist_ok=True)
        except shutil.Error as e:
            print(e)
            
    asi_rdr2_0_9={
        '0.9.0':{
            '2.0':'mods\ASI\\ASI_0_9_0\\2.0',
            '2.1':'mods\\ASI\\ASI_0_9_0\\2.1',
            '2.2':'mods\\ASI\\ASI_0_9_0\\2.2',
            'SDK':'mods\\ASI\\ASI_0_9_0\\SDK',
            'ASI Loader for RDR2':'mods\FSR2FSR3_0.9.0\Red Dead Redemption 2'
        },
        '0.10.0':{
            '2.0':'mods\ASI\\ASI_0_10_0\\2.0',
            '2.1':'mods\\ASI\\ASI_0_10_0\\2.1',
            '2.2':'mods\\ASI\\ASI_0_10_0\\2.2',
            'SDK':'mods\\ASI\\ASI_0_10_0\\SDK',
            'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.0\Red Dead Redemption 2',
        },
        '0.10.1':{
            '2.0':'mods\ASI\\ASI_0_10_1\\2.0',
            '2.1':'mods\\ASI\\ASI_0_10_1\\2.1',
            '2.2':'mods\\ASI\\ASI_0_10_1\\2.2',
            'SDK':'mods\\ASI\\ASI_0_10_1\\SDK',
            'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.1\Red Dead Redemption 2',
        },
        '0.10.1h1':{
            '2.0':'mods\ASI\\ASI_0_10_1h1\\2.0',
            '2.1':'mods\\ASI\\ASI_0_10_1h1\\2.1',
            '2.2':'mods\\ASI\\ASI_0_10_1h1\\2.2',
            'SDK':'mods\\ASI\\ASI_0_10_1h1\\SDK',
            'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.1h1\Red Dead Redemption 2',
        },
        '0.10.2h1':{
            '2.0':'mods\ASI\\ASI_0_10_2h1\\2.0',
            '2.1':'mods\\ASI\\ASI_0_10_2h1\\2.1',
            '2.2':'mods\\ASI\\ASI_0_10_2h1\\2.2',
            'SDK':'mods\\ASI\\ASI_0_10_2h1\\SDK',
            'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.2h1\Red Dead Redemption 2',
        },
        '0.10.3':{
            '2.0':'mods\ASI\\ASI_0_10_3\\2.0',
            '2.1':'mods\\ASI\\ASI_0_10_3\\2.1',
            '2.2':'mods\\ASI\\ASI_0_10_3\\2.2',
            'SDK':'mods\\ASI\\ASI_0_10_3\\SDK',
            'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.3\Red Dead Redemption 2',
        },
        
        '0.10.4':{
            '2.0':'mods\\ASI\\ASI_0_10_4\\2.0',
            '2.1':'mods\\ASI\\ASI_0_10_4\\2.1',
            '2.2':'mods\\ASI\\ASI_0_10_4\\2.2',
            'SDK':'mods\\ASI\\ASI_0_10_4\\SDK',
            'ASI Loader for RDR2':'mods\FSR2FSR3_0.10.4\Red Dead Redemption 2\RDR2_FSR'
        },
       'Uniscaler':{
            '2.0':'mods\\ASI\ASI_uniscaler',
            '2.1':'mods\\ASI\ASI_uniscaler',
            '2.2':'mods\\ASI\ASI_uniscaler',
            'SDK':'mods\\ASI\ASI_uniscaler',
            'ASI Loader for RDR2':'mods\\ASI\\ASI_uniscaler'
        },
       'Uniscaler + Xess + Dlss':{
            '2.0':r'mods\ASI\ASI_uniscaler_xess_dlss',
            '2.1':r'mods\ASI\ASI_uniscaler_xess_dlss',
            '2.2':r'mods\ASI\ASI_uniscaler_xess_dlss',
            'SDK':r'mods\ASI\ASI_uniscaler_xess_dlss',
            'ASI Loader for RDR2':r'mods\ASI\ASI_uniscaler_xess_dlss'
       },
       'Uniscaler V2':{
            '2.0':r'mods\ASI\ASI_uniscaler_v2',
            '2.1':r'mods\ASI\ASI_uniscaler_v2',
            '2.2':r'mods\ASI\ASI_uniscaler_v2',
            'SDK':r'mods\ASI\ASI_uniscaler_v2',
            'ASI Loader for RDR2':r'mods\ASI\ASI_uniscaler_v2'
       },
       'Uniscaler V3':{
           '2.0':r'mods\ASI\ASI_uniscaler_v3',
            '2.1':r'mods\ASI\ASI_uniscaler_v3',
            '2.2':r'mods\ASI\ASI_uniscaler_v3',
            'SDK':r'mods\ASI\ASI_uniscaler_v3',
            'ASI Loader for RDR2':r'mods\ASI\ASI_uniscaler_v3'
       },
       'Uniscaler FSR 3.1':{
           '2.0':r'mods\ASI\ASI_uniscaler_31',
            '2.1':r'mods\ASI\ASI_uniscaler_31',
            '2.2':r'mods\ASI\ASI_uniscaler_31',
            'SDK':r'mods\ASI\ASI_uniscaler_31',
            'ASI Loader for RDR2':r'mods\ASI\ASI_uniscaler_31'
       }
       
    }

    if select_mod in asi_rdr2_0_9 and (select_asi in asi_rdr2_0_9[select_mod] or option_asi in asi_rdr2_0_9[select_mod]):
        if select_mod in asi_rdr2_0_9[select_mod]:
            asi_origin_rdr2_0_9 = asi_rdr2_0_9[select_mod][select_asi]
        elif select_mod in asi_rdr2_0_9 [select_mod]:
            asi_origin_rdr2_0_9 = asi_rdr2_0_9[select_mod][option_asi]

    try:
        if select_mod in asi_rdr2_0_9:
            if option_asi == 'ASI Loader for RDR2' and option_asi in asi_rdr2_0_9[select_mod]:
                asi_origin_rdr2_0_9 = asi_rdr2_0_9[select_mod][option_asi]
            elif select_asi in asi_rdr2_0_9[select_mod]:
                asi_origin_rdr2_0_9 = asi_rdr2_0_9[select_mod][select_asi]
            else:
                asi_origin_rdr2_0_9 = None
                
            if asi_origin_rdr2_0_9 and os.path.isdir(asi_origin_rdr2_0_9):
                for i_rdr2 in os.listdir(asi_origin_rdr2_0_9):
                    path_rdr_0_9 = os.path.join(asi_origin_rdr2_0_9, i_rdr2)
                    if os.path.isfile(path_rdr_0_9):
                        shutil.copy2(path_rdr_0_9, select_folder)
                    print("Files from directory", asi_origin_rdr2_0_9, "were copied.")
    except Exception as e:
        print(e)  

rdr2_folder = {"RDR2 Build_2":'mods\\Red_Dead_Redemption_2_Build02',
               "RDR2 Build_4":'mods\\RDR2Upscaler-FSR3Build04',
               "RDR2 Mix":'mods\\RDR2_FSR3_mix',
               "RDR2 Mix 2":'mods\\RDR2_FSR3_mix',
               "Red Dead Redemption V2":'mods\\RDR2_FSR3_V2',
               "RDR2 Non Steam FSR3":'mods\\FSR3_RDR2_Non_Steam\\RDR2_FSR3',
               "RDR2 FSR 3.1 FG":"mods\\RDR2_FSR3_1"}
def rdr2_build2():
    global rdr2_folder
    
    if select_mod in rdr2_folder:
        origins_rdr2 = rdr2_folder[select_mod]

        shutil.copytree(origins_rdr2,select_folder,dirs_exist_ok=True)

    if select_mod == 'RDR2 Mix 2':
        ignore_files = ('reshade-shaders','ReShade.ini')
    elif select_mod == 'RDR2 Non Steam FSR3':
        dll_copy = messagebox.askyesno('DLL','Do you want to copy the DLL files? Some users may receive a DLL error when running the game with the mod. (Only select \'Yes\' if you have received the error)')
        
        if dll_copy:
            shutil.copytree("mods\\FSR3_RDR2_Non_Steam\\RDR2_DLL",select_folder,dirs_exist_ok=True)
    
    if select_mod == 'RDR2 Mix 2':
        path_rdr2_ini = 'mods\\Temp\\RDR2_FSR3\\rdr2_mix2_ini\\RDR2Upscaler.ini'
        dest_folder_mods = os.path.join(select_folder,'mods')
    
        for i_rdr2_mx2 in os.listdir(origins_rdr2):
            src_item = os.path.join(origins_rdr2, i_rdr2_mx2)
            dst_item = os.path.join(select_folder, i_rdr2_mx2)
            if os.path.isdir(src_item):
                if not any(pattern in i_rdr2_mx2 for pattern in ignore_files):
                    shutil.copytree(src_item, dst_item, ignore=shutil.ignore_patterns(*ignore_files),dirs_exist_ok=True)
            else:
                if not any(pattern in i_rdr2_mx2 for pattern in ignore_files):
                    shutil.copy2(src_item, dst_item)
        
        config_rdr2_ini = ConfigObj(path_rdr2_ini)

        if 'Settings' not in config_rdr2_ini:
            config_rdr2_ini['Settings'] = {}

        config_rdr2_ini['Settings']['mUpscaleType'] = 1

        config_rdr2_ini.write()
        shutil.copy2(path_rdr2_ini,dest_folder_mods)
    
    if select_mod == "RDR2 FSR 3.1 FG":
        shutil.copytree("mods\\Optiscaler FSR 3.1 Custom",select_folder,dirs_exist_ok=True)

dd2_folder = {'Dinput8':'mods\\FSR3_DD2\\dinput',
              'Uniscaler_DD2':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
              'Uniscaler + Xess + Dlss DD2':'mods\\FSR2FSR3_Uniscaler_Xess_Dlss\\Uniscaler_mod\\Uniscaler_mod',
              'Uniscaler V2':'mods\\FSR2FSR3_Uniscaler_V2\\Uni_V2\\Uni_Mod',
              'Uniscaler V3':'mods\\FSR2FSR3_Uniscaler_V3\\Uni_V3\\Uni_Mod',
              'Uniscaler FSR 3.1':'mods\\FSR2FSR3_Uniscaler_FSR3\\Uniscaler_FSR31',
}
dd2_fsr31_list = ['FSR 3.1/DLSS ALL GPU']

def dd2_fsr():
    global dd2_folder,var_d_put

    dd2_reg = ['regedit.exe', '/s', "mods\Temp\enable signature override\EnableSignatureOverride.reg"]
    dd2_reg2 = ['regedit.exe', '/s', "mods\FSR2FSR3_DD2_FSR31\DD2_DLSS\DisableNvidiaSignatureChecks.reg"]
    
    var_d_put = False
    
    if select_mod in dd2_folder:
        origins_dd2 = dd2_folder[select_mod]
    
    d_put_path = os.path.join(r'mods\FSR3_DD2\dinput\dinput8.dll')
      
    if select_mod == 'Dinput8':  
        shutil.copy2(d_put_path, select_folder)

    for root,dirs,files in os.walk(select_folder):
        for d_put in files:
            if d_put == 'dinput8.dll':
                var_d_put = True
                break
        else:
            continue  
        break 
    else:
        var_d_put = False

    if select_mod == 'FSR 3.1/DLSS DD2 ALL GPU':
        var_d_put = True #Allows the installation of the mod for DD2

        fsr31_dd2 = messagebox.askyesno('FSR 3.1','Would you like to use FSR 3.1? The game might have some graphical bugs')

        if fsr31_dd2:
            update_ini('mods\\Temp\\Optiscaler_DD2\\nvngx.ini','Dx12Upscaler','fsr31')
        else:
            update_ini('mods\\Temp\\Optiscaler_DD2\\nvngx.ini','Dx12Upscaler','xess')

        shutil.copytree('mods\FSR2FSR3_DD2_FSR31\Optiscaler_DD2',select_folder,dirs_exist_ok=True)
        shutil.copytree('mods\FSR2FSR3_DD2_FSR31\Re_Framework',select_folder,dirs_exist_ok=True)
        shutil.copytree('mods\FSR2FSR3_DD2_FSR31\DD2_DLSS',select_folder,dirs_exist_ok=True)
        shutil.copy2('mods\\Temp\\Optiscaler_DD2\\nvngx.ini',select_folder)
        shutil.copy2('mods\\FSR2FSR3_DD2_FSR31\\Optiscaler_DD2\\nvngx.ini','mods\\Temp\\Optiscaler_DD2\\nvngx.ini') #Replace the modified .ini file with a clean .ini file.
        subprocess.run(dd2_reg,check=True)
        subprocess.run(dd2_reg2,check=True)

        if os.path.exists(os.path.join(select_folder,'shader.cache2')):
            os.remove(os.path.join(select_folder,'shader.cache2'))
    
    elif select_mod == 'FSR 3.1/DLSS DD2 NVIDIA':
        var_d_put = True #Allows the installation of the mod for DD2

        shutil.copytree('mods\FSR2FSR3_DD2_FSR31\Optiscaler_DD2',select_folder,dirs_exist_ok=True)
        shutil.copytree('mods\FSR2FSR3_DD2_FSR31\Re_Framework',select_folder,dirs_exist_ok=True)
        shutil.copytree('mods\FSR2FSR3_DD2_FSR31\DD2_NVIDIA',select_folder,dirs_exist_ok=True)
        subprocess.run(dd2_reg,check=True)
        subprocess.run(dd2_reg2,check=True)

        if os.path.exists(os.path.join(select_folder,'shader.cache2')):
            os.remove(os.path.join(select_folder,'shader.cache2'))

    if select_mod == 'Uniscaler_DD2' and var_d_put or select_mod == 'Uniscaler + Xess + Dlss DD2' and var_d_put :
        us_dd2(var_d_put,origins_dd2)
    elif select_mod == 'Uniscaler_DD2' and not var_d_put or select_mod == 'Uniscaler + Xess + Dlss DD2' and not var_d_put:
        messagebox.showinfo('Not Found','Deput8.dll file not found, please select "Deput8" in "Select mod" before installing the mod, we recommend checking out the Dragons Dogmas 2 guide on FSR GUIDE.')
   
def us_dd2(var_d_put,origins_dd2):
    del_shader = ['shader.cache2']
    
    if os.path.exists(os.path.join(select_folder, '_storage_')):
        storage_path = os.path.join(select_folder,'_storage_')
        us_path = os.path.join(r'mods\FSR2FSR3_Uniscaler\Uniscaler_4\Uniscaler mod\winmm.dll')
        all_us_path = os.path.join(r'mods\FSR2FSR3_Uniscaler\Uniscaler_4\Uniscaler mod')
        
        shutil.copy(us_path, storage_path)
        shutil.copytree(all_us_path, select_folder, dirs_exist_ok=True)
        shutil.copytree(origins_dd2, select_folder, dirs_exist_ok=True)

        del_shader_var = messagebox.askyesno('Delete Shader','Do you want to delete the shader.cache2 file? Not deleting this file may result in bugs and game crashes.')
        
        if del_shader_var:
            for shader_c2 in os.listdir(select_folder):
                if shader_c2 in del_shader:
                    os.remove(os.path.join(select_folder,shader_c2))

er_origins = {'Disable_Anti-Cheat':'mods\Elden_Ring_FSR3\ToggleAntiCheat',
              'Elden_Ring_FSR3':'mods\Elden_Ring_FSR3\EldenRing_FSR3',
              'Elden_Ring_FSR3 V2':'mods\Elden_Ring_FSR3\EldenRing_FSR3 v2',
              'Elden_Ring_FSR3_V3':'mods\Elden_Ring_FSR3\EldenRing_FSR3 v3',
              }

def elden_fsr3():
    global er_origins
    
    if select_mod in er_origins:
        elden_folder = er_origins[select_mod]
    
    if select_mod in er_origins:
        shutil.copytree(elden_folder,select_folder, dirs_exist_ok=True)

    if select_mod == 'Unlock FPS Elden':  
        shutil.copytree('mods\\Elden_Ring_FSR3\\Unlock_Fps',select_folder,dirs_exist_ok=True)

    if os.path.exists(os.path.join(select_folder, 'toggle_anti_cheat.exe')):
        run_dis_anti_c()

def run_dis_anti_c():
    var_anti_c = messagebox.askyesno('Disable Anti Cheat','Do you want to disable the anticheat? (only for Steam users)')
    
    del_anti_c_path = os.path.join(select_folder,'toggle_anti_cheat.exe')
    if var_anti_c:
        subprocess.call(del_anti_c_path)

bdg_origins = {'Baldur\'s Gate 3 FSR3':'mods\\FSR3_BDG',
               'Baldur\'s Gate 3 FSR3 V2':['mods\\FSR3_BDG','mods\\FSR3_BDG_2'],
               'Baldur\'s Gate 3 FSR3 V3':['mods\\FSR3_BDG','mods\\FSR3_BDG_2']}
def bdg_fsr3():
    
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

    if select_mod in callisto_origins:
        callisto_origin  = callisto_origins[select_mod]
    
    if select_mod in callisto_origins:
        shutil.copytree(callisto_origin,select_folder,dirs_exist_ok=True)
    
    callisto_tcp = messagebox.askyesno('TCP MOD','Do you want to install the TCP mod? (It is necessary to install ReShade for this mod to work, check the guide in FSR GUIDE for more information about the mod.)')

    if callisto_tcp:
        shutil.copy(path_tcp,select_folder)
    
    callisto_real_life = messagebox.askyesno('Real Life','Do you want to install the Real Life mod? (It is necessary to install ReShade for the mod to work, check the guide in FSR GUIDE for more information about the mod and how to install it.)')

    if callisto_real_life:
        shutil.copy(path_real_life,select_folder)

def fallout_fsr():
    high_fps_path = 'mods\FSR3_Fallout4\High FPS Physics'
    f4se_plugins = 'mods\FSR3_Fallout4\Addres Library'
    fl4_ups_rtx = 'mods\FSR3_Fallout4\Fallout_Upscaler_RTX'
    fl4_ot_gpus = 'mods\FSR3_Fallout4\Fallout_Upscaler_Others'
    loader_fl4 = 'mods\FSR3_Fallout4\Loader_Fallout4'
    path_data = os.path.join(select_folder,'Data')
    not_loader_fl4 = 'mods\FSR3_Fallout4\Loader_Fallout4_TRUE3DSOUND_Compatible'
    f4se_fl4 = 'mods\FSR3_Fallout4\\f4se_0_06_23\\f4se_0_06_23'
    path_ini_fps = os.path.join(select_folder,r'Data\Data\\F4SE\\Plugins\\HighFPSPhysicsFix.ini')
    path_sym_link = 'mods\FSR3_Fallout4\SymlinkCreator.exe'
    
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
                messagebox.showinfo('Error','File HighFPSPhysicsFix.ini not found, please check if the file is in the folder with the ending Data\Data\F4SE\Plugins, if necessary reinstall the mod.')
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
    
    en_rtx_reg = ['regedit.exe', '/s', "mods\\FSR3_FH\RTX\\DisableNvidiaSignatureChecks.reg"]
    
    if var_gpu:
        shutil.copytree(path_rtx,select_folder,dirs_exist_ok=True)
        subprocess.run(en_rtx_reg,check=True)
    elif not var_gpu:
        shutil.copytree(path_ot_gpu,select_folder,dirs_exist_ok=True)

def pw_fsr3():
    var_gpu = messagebox.askyesno('Select GPU','Do you have an Nvidia RTX GPU?')
    
    path_pw_mod = 'mods\\FSR3_PW'
    path_ini = 'mods\\FSR3_PW\\mods\\PalworldUpscaler.ini'
            
    if not os.path.exists(path_ini):
            messagebox.showinfo('Error','File PalworldUpscaler.ini not found, please see if the file PalworldUpscaler.ini is in the "mods" folder in the directory where the mod was installed.", if necessary reinstall the mod.')
    else:
        if var_gpu:
            config_ini = ConfigObj(path_ini)

            if 'Settings' not in config_ini:
                config_ini['Settings'] = {}

            config_ini['Settings']['mUpscaleType'] = 0

            config_ini.write()
            
            shutil.copytree(path_pw_mod,select_folder,dirs_exist_ok=True)
                
        elif not var_gpu:
            config_ini = ConfigObj(path_ini)

            if 'Settings' not in config_ini:
                config_ini['Settings'] = {}

            config_ini['Settings']['mUpscaleType'] = 3

            config_ini.write()
            
            shutil.copytree(path_pw_mod,select_folder,dirs_exist_ok=True)
     
    
    shortcut_pw_path = os.path.join(select_folder,'Palworld-Win64-Shipping.exe')
    new_target_path = ('Palworld') 
    dx_12 = "-dx12"
    game_name = 'Palworld'
    
    auto_shortcut(shortcut_pw_path,new_target_path,dx_12,game_name)

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
    icr_rtx_reg = ['regedit.exe', '/s', "mods\\FSR3_ICR\\ICARUS_DLSS_3_FOR_RTX\\DisableNvidiaSignatureChecks.reg"]
    
    if select_mod == 'Icarus FSR3 RTX':
        shutil.copytree(icr_rtx,select_folder,dirs_exist_ok=True)
        act_dlss = messagebox.askyesno('DLSS','Do you want to run DisableNvidiaSignatureChecks.reg? It\'s necessary for the mod to work')
        
        if act_dlss:
            subprocess.run(icr_rtx_reg,check=True)
    
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

def tlou_fsr():
    path_uni_tlou_1080p = 'mods\\FSR2FSR3_Uni_Custom\\Uniscaler Preview 7 Custom\\For 1080p Monitors'
    path_uni_tlou_1440p = 'mods\\FSR2FSR3_Uni_Custom\\Uniscaler Preview 7 Custom\\For 1440p Monitors'
    
    if select_mod == 'Uniscaler Tlou':
        var_gpu_tlou = messagebox.askyesno('Resolution','Is your resolution above 1080p?')
    
    if var_gpu_tlou:
        shutil.copytree(path_uni_tlou_1440p,select_folder,dirs_exist_ok=True)
    else:
        shutil.copytree(path_uni_tlou_1080p,select_folder,dirs_exist_ok=True)

def spider_fsr():
    path_xess_spider = 'mods\\Temp\\nvngx_global\\nvngx\\libxess.dll'
    path_dlss_spider = 'mods\\Temp\\nvngx_global\\nvngx\\nvngx_dlss.dll'
    path_uni5_spider = 'mods\\FSR2FSR3_Spider\\Uniscaler.asi'
    path_uni_spider = 'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod'

    rtx_spider = messagebox.askyesno('RTX or AMD','Do you have an Nvidia Rtx?')
    
    if rtx_spider:
        shutil.copytree(path_uni_spider,select_folder,dirs_exist_ok=True)
        shutil.copy2(path_xess_spider,select_folder)
        shutil.copy2(path_dlss_spider,select_folder)
        shutil.copy2(path_uni5_spider,select_folder)
    else:
        shutil.copytree(path_uni_spider,select_folder,dirs_exist_ok=True)
        shutil.copy2(path_xess_spider,select_folder)
        shutil.copy2(path_uni5_spider,select_folder)

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
    
    dinput8_var = os.path.exists(os.path.join(select_folder,'dinput8.dll'))
    
    if select_mod == 'Dinput 8':
        shutil.copytree(dinput8_gtav,select_folder,dirs_exist_ok=True)
        return True
        
    elif select_mod == 'GTA V FSR3' and dinput8_var:
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
    
    elif select_mod == 'GTA V FSR3' and not dinput8_var and select_mod :
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
    lotf_rtx_reg = ['regedit.exe', '/s', "mods\\FSR3_LOTF\\RTX\\LOTF_DLLS_3_RTX\\DisableNvidiaSignatureChecks.reg"]
    
    if select_mod == 'Lords of The Fallen FSR3':
        rtx_amd = messagebox.askyesno('RTX','Do you have an RTX GPU?"?')
        if rtx_amd:
            shutil.copytree(rtx_fsr3,select_folder,dirs_exist_ok=True)
        else:
            shutil.copytree(amd_gtx_fsr3,select_folder,dirs_exist_ok=True)
    
        subprocess.run(lotf_rtx_reg,check=True)
        
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

def dl2_fsr3():
    global_dlss()

def hfw_fsr3():
    hfw_rtx = 'mods\\FSR3_HFW\\RTX FSR3'
    xess_hfw ='mods\\Temp\\nvngx_global\\nvngx\\libxess.dll'
    hfw_ot_gpu = 'mods\\FSR3_Callisto\\FSR_Callisto'
    hfw_rtx_reg = ['regedit.exe', '/s', "mods\\FSR3_HFW\\RTX FSR3\\DisableNvidiaSignatureChecks.reg"]
    hfw_ot_gpu_reg = ['regedit.exe', '/s', "mods\\Temp\\enable signature override\\EnableSignatureOverride.reg"]
    path_crash_fix= "mods\\FSR3_HFW\\Crash_Fix"
    path_exe = os.path.join(select_folder,"HorizonForbiddenWest.exe")
    
    if select_mod == 'Horizon Forbidden West FSR3':
        var_gpu = messagebox.askyesno('GPU','Do you have an RTX GPU?')
        
        if var_gpu:
            shutil.copytree(hfw_rtx,select_folder,dirs_exist_ok=True)
            shutil.copy2(xess_hfw,select_folder)
            subprocess.run(hfw_rtx_reg,check=True)
            
        else:
            shutil.copytree(hfw_ot_gpu,select_folder,dirs_exist_ok=True)
            shutil.copy2(xess_hfw,select_folder)
            subprocess.run(hfw_ot_gpu_reg,check=True)
    
    crash_fix_hfw = messagebox.askyesno("Crash Fix","Would you like to install the crash fix?")
    
    if crash_fix_hfw:
        if os.path.exists(path_exe):
            os.rename(path_exe, os.path.join(select_folder,"HorizonForbiddenWestOriginalEXE.txt"))
        shutil.copytree(path_crash_fix, select_folder, dirs_exist_ok=True)

def fsr3_control():
    path_nvngx_control = 'mods\\FSR3_Control'
    if select_option == 'Control':
        shutil.copytree(path_nvngx_control,select_folder,dirs_exist_ok=True)
        
def fsr3_aw2_rtx():
    path_rtx = 'mods\\FSR3_AW2\\RTX'
    path_dlss = 'mods\\Temp\\nvngx_global\\nvngx\\nvngx_dlss.dll'
    path_amd = 'mods\\FSR3_AW2\\AMD'
    path_iniaw2 = os.getenv("LOCALAPPDATA") + '\\Remedy\\AlanWake2\\renderer.ini'
    
    if select_mod == 'Alan Wake 2 FG RTX':
        shutil.copytree(path_rtx,select_folder,dirs_exist_ok=True)
        shutil.copy2(path_dlss,select_folder)
    
    elif select_mod  == 'Alan Wake 2 Uniscaler Custom':
        shutil.copytree(path_amd,select_folder,dirs_exist_ok=True)
    
    var_aw2 = messagebox.askyesno('Fix Ghosting Aw2','Do you want to fix possible ghosting issues caused by the FSR3 mod?')

    value_remove_pos_processing = {   
                "m_bLensDistortion": False,
                "m_bFilmGrain": False,
                "m_bVignette": False
            } 

    if var_aw2:
        config_json(path_iniaw2,value_remove_pos_processing,"'Path not found, the path to the renderer.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\Remedy\\AlanWake2. Would you like to select the path manually?'",'Post-processing effects successfully removed')

def fsr3_motogp():
    if select_option == 'MOTO GP 24':
        path_uni = os.path.join(select_folder,'uniscaler')
        
        if os.path.exists(path_uni):
            shutil.rmtree(path_uni)

def fsr3_got():
    path_dlss_got = 'mods\\FSR3_GOT\\DLSS FG'
    path_dx12 = 'mods\\FSR3_GOT\\Fix_DX12'
    got_reg = ['regedit.exe', '/s', "mods\\FSR3_GOT\\DLSS FG\\DisableNvidiaSignatureChecks.reg"]
    exe_got = os.path.join(select_folder,'GhostOfTsushima.exe')
    post_processing_got_folder = 'mods\\FSR3_GOT\\Remove_Post_Processing'
    path_var_post_processing_got = 'mods\\FSR3_GOT\\Remove_Post_Processing\\no-filmgrain.reg'
    
    if select_option == 'Ghost of Tsushima':
        shutil.copytree(path_dlss_got,select_folder,dirs_exist_ok=True)
        
        subprocess.run(got_reg,check=True)
    
    dx12_got = messagebox.askyesno('DX12','Do you want to install the DX12 files? These files fix issues related to DX12. (Only confirm if you have encountered a DX12 related error)')

    if dx12_got:
        shutil.copytree(path_dx12,select_folder,dirs_exist_ok=True)
    
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
    if select_mod == 'FFXVI DLSS RTX':
        dlss_to_fsr()
    elif select_mod == 'FFXVI DLSS ALL GPU':
        global_dlss()

def fsr3_outlaws():
    outlaws_reg = ['regedit.exe', '/s', "mods\FSR3_Outlaws\Anti_Stutter\Install Star Wars Outlaws CPU Priority.reg"]
    graphics_preset_outlaws = 'mods\\FSR3_Outlaws\\Preset\\Outlaws2.ini'
    var_stutter_outlaws = 'mods\\FSR3_Outlaws\\Anti_Stutter\\Anti_Sttuter.txt'

    if select_mod == 'Outlaws DLSS RTX':
        dlss_to_fsr()
    
    anti_stutter_outlaws = messagebox.askyesno('Anti Stutter','Do you want to install the anti-stutter?')

    if anti_stutter_outlaws:
        shutil.copy(var_stutter_outlaws,select_folder) #File used to remove the Anti-Stutter in 'Cleanup Mod'
        subprocess.run(outlaws_reg,check=True)
    
    preset_outlaws = messagebox.askyesno('Graphics Preset','Do you want to install he Graphics Preset?')

    if preset_outlaws:
        shutil.copy(graphics_preset_outlaws,select_folder)

        messagebox.showinfo('FSR Guide','To apply the graphics preset, see the Star Wars Outlaws guide in the FSR Guide.')
        

def handle_prompt(window_title, window_message,action_func=None):
    user_choice = messagebox.askyesno(window_title, window_message)
    
    if user_choice and action_func:
        action_func(user_choice)

    return user_choice

def copy_if_exists(folder_path, dest_path):
    try:
        if os.path.exists(folder_path):
            shutil.copytree(folder_path, dest_path, dirs_exist_ok=True)
        else:
            messagebox.showinfo('Not Found', f'{dest_path} not found, please select the .exe path in "Select Folder". The path should look something like this: BlackMythWukong\\b1\\Binaries\\Win64')
    except Exception as e:
        messagebox.showinfo('Error','It was not possible to complete the installation, please restart the Utility and try again.')
        print(e)

def wukong_fsr3():
    wukong_stutter_reg = ['regedit.exe', '/s', r"mods\FSR3_WUKONG\HIGH CPU Priority\Install Black Myth Wukong High Priority Processes.reg"]
    wukong_file_optimized = r'mods\FSR3_WUKONG\BMWK\BMWK - SPF'
    wukong_graphic_preset = r'mods\FSR3_WUKONG\Graphic Preset'
    wukong_ue4_map = r"mods\FSR3_WUKONG\Map\WukongUE4SS"
    wukong_map = r"mods\FSR3_WUKONG\Map\b1"
    wukong_hdr = r"mods\FSR3_WUKONG\HDR"
    full_path_wukong = os.path.abspath(os.path.join(select_folder, '..\\..\\..'))
    path_fsr31_wukong = 'mods\\FSR3_WUKONG\\WukongFSR31\\FSR31_Wukong'
    
    if select_mod == 'RTX DLSS FG Wukong':
        dlss_to_fsr()
    if select_mod == 'FSR 3.1 Custom Wukong':
        shutil.copytree(path_fsr31_wukong,select_folder,dirs_exist_ok=True)
    
    wukong_optimized = messagebox.askyesno('Optimized Wukong','Do you want to install the optimization mod? (Faster Loading Times, Optimized CPU and GPU Utilization, etc. To check the other optimizations, see the guide in FSR Guide).')

    if os.path.exists(os.path.join(full_path_wukong + "\\b1\\Binaries\\Win64")):

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
            subprocess.run(wukong_stutter_reg, check=True),
            shutil.copy(r'mods\FSR3_WUKONG\HIGH CPU Priority\Anti-Stutter - Utility.txt', select_folder)
            )
        )

        handle_prompt(
            'Graphic Preset',
            'Do you want to apply the Graphics Preset? (ReShade must be installed for the preset to work, check the guide in FSR Guide for more information)',
            lambda _: copy_if_exists(wukong_graphic_preset, full_path_wukong + "\\b1")
        )

        view_message_wukong = handle_prompt(
            'Mini Map',
            'Would you like to install the mini map?',
            lambda _:(
                copy_if_exists(wukong_ue4_map,select_folder),
                copy_if_exists(wukong_map,full_path_wukong + "\\b1"),
            )
        )

        view_message_wukong = handle_prompt(
            'HDR',
            'Would you like to install the HDR correction?',
            lambda _: copy_if_exists(wukong_hdr,full_path_wukong)
        )

        if view_message_wukong or wukong_optimized:
            messagebox.showinfo('Success', 'Preset applied successfully. To complete the installation, go to the game\'s page in your Steam library, click the gear icon \'Manage\' to the right of \'Achievements\', select \'Properties\', and in \'Launch Options\', enter -fileopenlog.')
    else:
        messagebox.showinfo('Not Founde','Path not found, please select the correct path: BlackMythWukong\\b1\\Binaries\\Win64')

# Modify the ini file of Hellblade 2 to remove post-processing effects
def config_ini_hell2(key_ini,value_ini,path_ini,message_hb2):
    global select_folder
    
    if os.path.exists(path_ini):
      
        select_folder = os.path.dirname(path_ini)
        
        game_folder_canvas.delete('text')
        game_folder_canvas.create_text(2,8, anchor='w',text=select_folder,fill='black',tags='text') 
      
        with open(path_ini, 'a') as configfile:
           
            if configfile.tell() > 0:
                configfile.write("\n")
            
            configfile.write(f"\n[{key_ini}]\n")

            for key, value in value_ini.items():
                configfile.write(f"{key}={value}\n")
           
        messagebox.showinfo('Sucess',message_hb2)
    else:
        messagebox.showinfo('Path Not Found','Path not found, please select manually. The path to the Engine.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\Hellblade2\\Saved\\Config\\Windows or WinGDK. If you need further instructions, refer to the Hellblade 2 FSR Guide')
        return

def config_json(path_json, values_json,path_not_found_message,ini_message=None):

    var_config_json = False

    try:
        while not var_config_json:

            if os.path.exists(path_json):
                var_config_json = True
            else:
                var_config_json = False

                var_folder_ini = messagebox.askyesno('Path Not Found',path_not_found_message)

                if var_folder_ini:
                    folder_ini = filedialog.askdirectory()
                else:
                    messagebox.showinfo("Empty path","No path was selected, post-processing effects were not removed")
                    return
                
                if folder_ini:
                    if os.path.exists(os.path.join(folder_ini,"renderer.ini")):
                        var_config_json = True
                else:
                    var_config_json = False
                    messagebox.showinfo("Empty path","No path was selected, post-processing effects were not removed")
                    return
        
        if var_config_json:

            shutil.copy2(path_json,os.path.join(path_json,'..','..')) #.ini file backup

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
    message_black_bars = 'The black bars have been successfully removed, you can now install the Hellblade 2 FSR3 mod or exit the Utility if you prefer.'
    message_post_processing = 'The main post processing effects were successfully removed.'
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
            
    if select_mod  == 'Remove Black Bars':
        config_ini_hell2(key_remove_post_processing,value_remove_black_bars,path_final,message_black_bars) 
             
    elif select_mod == 'Remove Black Bars Alt':  
        config_ini_hell2(key_remove_post_processing,value_remove_black_bars_alt,path_final,message_black_bars) 
            
    elif select_mod  == 'Remove Post Processing Effects':
        config_ini_hell2(key_remove_post_processing,value_remove_pos_processing,path_final,message_post_processing) 
    
    elif select_mod  == 'Remove All Post Processing Effects':
        config_ini_hell2(key_remove_post_processing,value_remove_all_pos_processing,path_final,message_post_processing) 
    
    if select_mod == 'Restore Post Processing':
        path_replace_ini = 'mods\\FSR3_HB2\\Replace_ini\\Engine.ini'
        
        var_replace_ini = messagebox.askyesno('Replace INI','Would you like to revert to the post-processing options? (Black bars, film grain, etc.)')
        
        if var_replace_ini:
            if os.path.exists(os.path.join(path_inihb2)):
                shutil.copy2(path_replace_ini,path_inihb2)
                messagebox.showinfo('Success', 'The Post Processing options have been re-enabled.')
            
            elif os.path.exists(os.path.join(alt_path_hb2)):
                shutil.copy2(path_replace_ini,alt_path_hb2) 
                messagebox.showinfo('Success', 'The Post Processing options have been re-enabled.')
            
            elif select_folder is None: 
                messagebox.showinfo('Path Not Found','Path not found, please select manually. The path to the Engine.ini file is something like this: C:\\Users\\YourName\\AppData\\Local\\Hellblade2\\Saved\\Config\\Windows or WinGDK and then select the option again. If you need further instructions, refer to the Hellblade 2 FSR Guide') 
                return
            
            else:              
                replace_ini_path = os.path.join(select_folder,'Engine.ini')
                if os.path.exists(replace_ini_path):
                    shutil.copy2(path_replace_ini,os.path.dirname(replace_ini_path)) 
                    messagebox.showinfo('Success', 'The Post Processing options have been re-enabled.')
                else:
                    messagebox.showinfo('INI Not Found','File not found in the specified path. Please select another path or verify if the Engine.ini file is in the selected path.')
                    return
            
def fsr3_hellblade_2():
    global select_folder
    path_dlss_hb2 = 'mods\\FSR3_GOT\\DLSS FG'
    hb2_reg = ['regedit.exe', '/s', "mods\\FSR3_GOT\\DLSS FG\\DisableNvidiaSignatureChecks.reg"]
    fix_dlss_hb2 = 'mods\\FSR3_HB2\\Fix_rtx_gtx'
    cpu_reg = ['regedit.exe', '/s', "mods\\FSR3_HB2\\Cpu_Hb2\\Install Hellblade 2 CPU Priority.reg"]
    
    if select_mod == 'Hellblade 2 FSR3 (Only RTX)':
        shutil.copytree(path_dlss_hb2,select_folder,dirs_exist_ok=True)
        subprocess.run(hb2_reg,check=True)
    
    if select_mod in ['Remove Black Bars','Remove Black Bars Alt','Remove Post Processing Effects','Remove All Post Processing Effects','Restore Post Processing']:
        remove_post_processing_effects_hell2()

    if select_mod not in ['Remove Black Bars','Remove Black Bars Alt','Remove Post Processing Effects','Remove All Post Processing Effects','Restore Post Processing']:
        fix_dlss = messagebox.askyesno('DLSS fix','Do you want to install the nvngx.dll file? (recommended for users who cannot see DLSS in the game)')
    
        if fix_dlss:
            shutil.copytree(fix_dlss_hb2,select_folder,dirs_exist_ok=True)
    
    if select_mod not in ['Remove Black Bars','Remove Black Bars Alt','Remove Post Processing Effects','Remove All Post Processing Effects','Restore Post Processing']:
        cpu_message = messagebox.askyesno("Anti Stutter","Would you like to apply the Anti Stutter? It can reduce game stuttering.")
        
        if cpu_message:
            subprocess.run(cpu_reg,check=True)
            shutil.copy2("mods\\FSR3_HB2\\Cpu_Hb2\\Install Hellblade 2 CPU Priority.reg",select_folder)
        
def fsr3_miles():
    path_uni_custom_miles = 'mods\\FSR2FSR3_Miles\\Uni_Custom_miles'
    
    shutil.copytree(path_uni_custom_miles,select_folder,dirs_exist_ok=True)

def fsr3_jedi():
    path_uni_jedi = "mods\\FSR2FSR3_Miles\\Uni_Custom_miles"
    shutil.copytree(path_uni_jedi,select_folder,dirs_exist_ok=True)

async def fsr3_cyber():
    path_mods = {
        "mods\\FSR3_CYBER2077\\mods\\Cyberpunk 2077 HD Reworked",
        "mods\\FSR3_CYBER2077\\mods\\Nova_LUT_2-1"
    }
    path_reshade_2077 = "mods\\FSR3_CYBER2077\\mods\\V2.0 Real Life Reshade"
    path_rtx_dlss = "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal"
    cb2077_reg = [
        'regedit.exe', '/s', 
        "mods\\FSR3_CYBER2077\\dlssg-to-fsr3-0.90_universal\\DisableNvidiaSignatureChecks.reg"
    ]
    
    try:
        if select_mod == "RTX DLSS FG":
            await asyncio.to_thread(shutil.copytree, path_rtx_dlss, select_folder, dirs_exist_ok=True)
            await asyncio.to_thread(subprocess.run, cb2077_reg, check=True)
        
        mods_message = messagebox.askyesno("Mods", "Would you like to install the Nova Lut and Cyberpunk 2077 HD Reworked mods?")
        
        if mods_message:
            for path_cb2077 in path_mods:
                await asyncio.to_thread(shutil.copytree, path_cb2077, select_folder, dirs_exist_ok=True)
        
        reshade_message = messagebox.askyesno('Reshade', 'Do you want to install Reshade Real Life 2.0? (It is necessary to install Reshade for this mod to work. Please refer to the FSR Guide for installation instructions.)')
        
        if reshade_message:
            await asyncio.to_thread(shutil.copytree, path_reshade_2077, select_folder, dirs_exist_ok=True)
    except Exception as e:
        messagebox.showinfo('Error','Failed to install the mod. Please try again.')
        return

def optiscaler_fsr3():
    path_optiscaler_custom = 'mods\\Optiscaler FSR 3.1 Custom'
    path_ini_optiscaler_custom = 'mods\\Temp\\Optiscaler FG 3.1\\nvngx.ini'
    shutil.copytree(path_optiscaler_custom,select_folder,dirs_exist_ok=True)
    shutil.copy2(path_ini_optiscaler_custom,select_folder)

    optiscaler_reg = ['regedit.exe', '/s', "mods\\Optiscaler FSR 3.1 Custom\\EnableSignatureOverride.reg"]
    optiscaler_reg2= ['regedit.exe', '/s', "mods\\Optiscaler FSR 3.1 Custom\\DisableNvidiaSignatureChecks.reg"]
    
install_contr = None
fsr_2_2_opt = ['Achilles Legends Untold','Alan Wake 2','A Plague Tale Requiem','Assassin\'s Creed Mirage',
               'Atomic Heart','Banishers: Ghosts of New Eden','Black Myth: Wukong','Blacktail','Bright Memory: Infinite','Cod Black Ops Cold War','Control','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Death Stranding Director\'s Cut','Dying Light 2','Everspace 2','Evil West','F1 2022','F1 2023','Final Fantsy XVI','FIST: Forged In Shadow Torch',
               'Fort Solis','Ghostwire: Tokyo','Hellblade 2','Hogwarts Legacy','Kena: Bridge of Spirits','Lies of P','Loopmancer','Manor Lords','Metro Exodus Enhanced Edition','Monster Hunter Rise','Nobody Wants To Die','Outpost: Infinity Siege',
               'Palworld','Ready or Not','Remnant II','RoboCop: Rogue City','Satisfactory','Sackboy: A Big Adventure','Smalland','Shadow Warrior 3','Starfield','STAR WARS Jedi: Survivor','Star Wars Outlaws','Steelrising','TEKKEN 8','The Chant','The Invincible','The Medium','Wanted: Dead']

fsr_2_1_opt=['Chernobylite','Dead Space (2023)','Hellblade: Senua\'s Sacrifice','Hitman 3','Horizon Zero Dawn','Judgment','Martha Is Dead','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man Miles Morales','Returnal','Ripout','Saints Row','The Callisto Protocol','Uncharted Legacy of Thieves Collection']

fsr_2_0_opt = ['Alone in the Dark','Deathloop','Crime Boss Rockay City','Dying Light 2','Brothers: A Tale of Two Sons Remake','Ghostrunner 2','High On Life','Jusant','Layers of Fear','Marvel\'s Guardians of the Galaxy','Nightingale','Rise of The Tomb Raider','Shadow of the Tomb Raider','The Outer Worlds: Spacer\'s Choice Edition','The Witcher 3']

fsr_sdk_opt = ['Ratchet & Clank - Rift Apart','Pacific Drive','MOTO GP 24']

fsr_sct_2_2 = ['2.2']
fsr_sct_2_1 = ['2.1']
fsr_sct_2_0 = ['2.0']
fsr_sct_SDK = ['SDK']
fsr_sct_rdr2 = ['RDR2','Red Dead Redemption 2']
fsr_sct_dd2 = ['Dragons Dogma 2']

nvngx_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
nvngx_label_guide.place_forget()

def guide_nvngx(event=None):
    nvngx_label_guide.config(text="Files that can help the mod to work in some specific games.\n(We recommend copying these files only if the default mod doesn't work.")
    nvngx_label_guide.place(x=420,y=419)
    
def close_nvngx_guide(event=None):
    nvngx_label_guide.config(text="")
    nvngx_label_guide.place_forget()

dxgi_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
dxgi_label_guide.place_forget()

def guide_dxgi(event=None):
    dxgi_label_guide.config(text="Files that can help the mod to work in some specific games.\n(We recommend copying these files only if the default mod doesn't work.")
    dxgi_label_guide.place(x=420,y=448)
     
def close_dxgi_guide(event=None):
    dxgi_label_guide.config(text="")
    dxgi_label_guide.place_forget()
    
asi_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=250)
asi_label_guide.place_forget()

def guide_asi(event=None):
    asi_label_guide.config(text="Default: Copies the ASI file from the selected mod/FSR.\n\n"
    "Select ASI Loader: Copies the ASI file from the FSR version of the selected mod, FSR: 2.0, 2.1, 2.2, SDK.\n\n"
    "ASI Loader for RDR2: Copies the Red Dead Redemption ASI file from the selected mod.\n\n"
    "Only select an option in the case of tests, choosing the wrong option may cause the mod not to work. If you have selected by mistake, choose Default.")
    asi_label_guide.place(x=0,y=173)

def close_asi_guide(event=None):
    asi_label_guide.config(text="")
    asi_label_guide.place_forget()

fk_gpu_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=250)
fk_gpu_label_guide.place_forget()

def guide_fk_gpu(event=None):
    fk_gpu_label_guide.config(text="Enable GPU proxy/spoof, show as Nvidia 40-series, default = false.")
    fk_gpu_label_guide.place(x=0,y=213)

def close_fk_gpu_guide(event=None):
    fk_gpu_label_guide.config(text="")
    fk_gpu_label_guide.place_forget()
    
nvapi_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
nvapi_label_guide.place_forget()

def guide_nvapi(event=None):
    nvapi_label_guide.config(text="Only relevant for GTX users who had issues with DLSS/FG not being selectable, default = false.")
    nvapi_label_guide.place(x=0,y=243)

def close_nvapiguide(event=None):
    nvapi_label_guide.config(text="")
    nvapi_label_guide.place_forget()

ue_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=190)
ue_label_guide.place_forget()

def guide_ue(event=None):
    ue_label_guide.config(text="Workaround for xmas/disco graphical artifacts in Unreal Engine games when selecting DLSS, default = false")
    ue_label_guide.place(x=200,y=213)

def close_ueguide(event=None):
    ue_label_guide.config(text="")
    ue_label_guide.place_forget()

mcos_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=190)
mcos_label_guide.place_forget()

def guide_mcos(event=None):
    mcos_label_guide.config(text="Enable macOS-specific compatibility tweaks, default = false")
    mcos_label_guide.place(x=200,y=243)

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
    dis_con_label_guide.place(x=0,y=365)
    
def close_dis_conguide(event=None):
    dis_con_label_guide.config(text="")
    dis_con_label_guide.place_forget()

debug_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
debug_label_guide.place_forget()

def guide_debug_op (event=None):
    debug_label_guide.config(text="For enabling FSR3FG debug overlay, default = false")
    debug_label_guide.place(x=200,y=362)
    
def close_debugguide(event=None):
    debug_label_guide.config(text="")
    debug_label_guide.place_forget()

debug_view_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
debug_view_label_guide.place_forget()

def guide_debug_view_op (event=None):
    debug_view_label_guide.config(text="For enabling FSR3FG debug overlay, default = false")
    debug_view_label_guide.place(x=200,y=332)
    
def close_debug_viewguide(event=None):
    debug_view_label_guide.config(text="")
    debug_view_label_guide.place_forget()

en_sig_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
en_sig_label_guide.place_forget()

def guide_en_sig (event=None):
    en_sig_label_guide.config(text="Enable Signature Override can help some games to work, it is also recommended to activate in older versions of the mod")
    en_sig_label_guide.place(x=0,y=447)
    
def close_en_sigguide(event=None):
    en_sig_label_guide.config(text="")
    en_sig_label_guide.place_forget()

lfz_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
lfz_label_guide.place_forget()

def guide_lfz(event=None):
    lfz_label_guide.config(text="Files that can help the mod to work in some specific games.\n(We recommend copying these files only if the default mod doesn't work.")
    lfz_label_guide.place(x=0,y=415)
     
def close_lfz_guide(event=None):
    lfz_label_guide.config(text="")
    lfz_label_guide.place_forget()

addon_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
addon_label_guide.place_forget()

def guide_addon_mods(event=None):
    addon_label_guide.config(text="Addon Mods to assist the performance of FSR 3 mods, check the guide on FSR Guide for more information.")
    addon_label_guide.place(x=420,y=480)

def close_addon_guide(event=None):
    addon_label_guide.config(text="")
    addon_label_guide.place_forget()

addon_dx12_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
addon_dx12_guide.place_forget()

def guide_addon_dx12(event=None):
    addon_dx12_guide.config(text="Select the upscaler that the mod will use")
    addon_dx12_guide.place(x=420,y=540)
 
def close_addon_dx12(event=None):
    addon_dx12_guide.config(text="")
    addon_dx12_guide.place_forget()

ignore_ingame_fg_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
ignore_ingame_fg_guide.place_forget()

def guide_ignore_ingame_fg(event=None):
    ignore_ingame_fg_guide.config(text="Enables Frame Gen regardless of the ingame DLSS-FG/FSR3-FG setting.")
    ignore_ingame_fg_guide.place(x=0,y=390)

def close_guide_ignore_ingame_fg(event=None):
    ignore_ingame_fg_guide.config(text="")
    ignore_ingame_fg_guide.place_forget()

ignore_ingame_fg_resources_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
ignore_ingame_fg_resources_guide.place_forget()

def guide_ignore_ingame_fg_resources(event=None):
    ignore_ingame_fg_resources_guide.config(text="Disables the use of game provided HUD less and UI resources. Will only cause more graphical issues in most games, so you should leave this turned off in most cases.")
    ignore_ingame_fg_resources_guide.place(x=200,y=390)

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
    global install_contr,var_d_put,continue_install,replace_flag,var_method
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
        elif select_fsr in fsr_sct_rdr2 and select_mod in origins_rdr2_folder or select_option in fsr_sct_rdr2 and select_mod in origins_rdr2_folder and install_contr:
            fsr_rdr2()
        elif select_fsr in fsr_sct_rdr2 and select_mod in rdr2_folder or select_option in fsr_sct_rdr2 and select_mod in rdr2_folder and install_contr:
            rdr2_build2()
        elif select_mod in dd2_folder or select_mod == 'FSR 3.1/DLSS DD2 NVIDIA' or select_mod == 'FSR 3.1/DLSS DD2 ALL GPU':
            dd2_fsr()
            if var_d_put == False:
                return
        elif select_mod in er_origins or select_mod == 'Unlock FPS Elden':
            elden_fsr3()
        elif select_mod in bdg_origins:
            bdg_fsr3()
        elif select_mod == 'Fallout 4 FSR3':
            fallout_fsr()
        elif select_mod  == 'Forza Horizon 5 FSR3':
            fh_fsr3()
        elif select_mod == 'Uniscaler Tlou':
            tlou_fsr()
        elif select_option == 'Icarus':
            icarus_fsr3()
        elif select_option == 'Lords of the Fallen':
            lotf_fsr3()
        elif select_option == 'Horizon Forbidden West':
            hfw_fsr3()


        if select_mod == 'Palworld Build03':
            pw_fsr3()
        if select_mod == 'Uniscaler Spider':
            spider_fsr()
        if select_mod == 'DL2 DLSS FG':
            dl2_fsr3()
        if select_mod == 'Uni Custom Miles':
            fsr3_miles()
        if select_mod == 'Dlss Jedi':
            fsr3_jedi()
        if select_mod == "FSR 3.1/DLSS Optiscaler":
            optiscaler_fsr3()
            
        if select_option == 'Cod Black Ops Cold War':
            cod_fsr()
        if select_option == 'COD MW3':
            cod_mw3_fsr3()
        
        if select_option == 'GTA V':
            var_dinput_gtav = gtav_fsr3()
            if not var_dinput_gtav:
                return

        if select_option == "Cyberpunk 2077":
            asyncio.run(fsr3_cyber())
        if select_option == 'Black Myth: Wukong':
            wukong_fsr3()
        if select_option == 'The Callisto Protocol':
            callisto_fsr()
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
            fsr3_aw2_rtx()
        if select_mod == 'Unlock Fps Tekken 8':
            ulck_fps_tekken()
        if select_mod == 'Uniscaler' and select_mod_operates != None and select_nvngx != 'XESS 1.3.1' or select_mod == 'Uniscaler' and select_mod_operates != None and not nvngx_contr:
            xess_fsr()
        if select_mod == 'Uniscaler' and select_mod_operates != None and select_nvngx != 'DLSS 3.7.0' or select_mod == 'Uniscaler' and select_mod_operates != None and not nvngx_contr:
            dlss_fsr()

        if addon_contr:
            addon_mods()
        if select_addon_mods == 'OptiScaler':
            update_optiscaler_dx11_dx12()
            update_optiscaler_ini()
            if select_mod != 'FSR 3.1/DLSS Optiscaler':
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
        if lfz_sl_var.get() == 1:
            copy_lfz_sl()
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
        print(e)
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
    global listbox_visible
    if listbox_visible:
        listbox.place_forget()
        listbox_visible = False
    else:
        listbox.place(x=101,y=58)
        listbox_visible = True
        
listbox_visible = False
listbox = tk.Listbox(screen,bg='white',selectbackground='white',width=30,height=0)
listbox.pack(side=tk.RIGHT,expand=True,padx=(0,115),pady=(0,500))
listbox.pack_forget()
scroll_listbox = tk.Scrollbar(listbox,orient=tk.VERTICAL,command=listbox.yview)
scroll_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(13,50))
listbox.config(yscrollcommand=scroll_listbox.set)
scroll_listbox.config(command=listbox.yview)

select_asi_color = 'white'
select_asi_bool = True
select_asi_rec = select_asi_canvas.create_rectangle(0,0,50,30,fill=select_asi_color,outline='')

def update_asi_color():
    global select_asi_color
    if select_asi_notvisible == True:
        select_asi_color = 'white'
    else:
        select_asi_color = '#C0C0C0'
    select_asi_canvas.itemconfig(select_asi_rec,fill=select_asi_color)

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
                    messagebox.showinfo('Sucess','Original font file copied successfully, restart the application. If the font is still not applied even after the restart, try installing the font manually. Follow this path: FSR3\lib\customtkinter\\assets\\fonts, open the CustomTkinter_shapes_font file, and click on \'Install\'.')
            except Exception:
                messagebox.showinfo('Error','The original font file could not be copied, perhaps your system is not compatible with this font. If you want to install manually, follow this path: FSR3\lib\customtkinter\\assets\\fonts, open the CustomTkinter_shapes_font file, and click on \'Install\'.')
                return
            
def change_labels():
    global change_text
    if change_text:
        
        change_font_label = tk.Label(screen,text="Change font", font=font_select,bg='black',fg='#C0C0C0')
        change_font_label.place(x=0,y=565)
        change_font_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=change_font_var,command=cbox_change_font)
        change_font_cbox.place(x=80,y=565)
    
        debug_tear_lines_label.place(x=120,y=338)
        debug_tear_lines_cbox.place(x=239,y=338)
        
        lfz_sl_label.place(x=267,y=338)
        lfz_sl_label_cbox.place(x=376,y=338)
        
        fakegpu_cbox.place(x=126,y=185)
        nvapi_cbox.place(x=113,y=215)
        ue_cbox.place(x=364,y=185)
        macos_sup_cbox.place(x=374,y=215)
        var_expo_cbox.place(x=310,y=245)
        open_editor_cbox.place(x=332,y=276)
        disable_sigover_cbox.place(x=365,y=306)
        enable_sigover_cbox.place(x=159,y=306)
        fps_user_entry.place(x=80,y=248)
        var_frame_gen_cbox.place(x=110,y=276)
        debug_view_cbox.place(x=90,y=335)
        disable_console_cbox.place(x=117,y=367)
        backup_cbox.place(x=214,y=367)
        fsr_guide_cbox.place(x=348,y=366)
        cleanup_cbox.place(x=100,y=425)
        del_dxgi_cbox.place(x=118,y=459)
        mod_operates_label.place(x=420,y=36)
        sharpness_cbox.place(x=560,y=73)
        nvngx_label.place(x=420,y=395)
        dxgi_label.place(x=420,y=425)
        addon_mods_label.place(x=420,y=457)
        addon_ups_dx12_label.place(x=420,y=517)
        
        uni_custom_canvas.place(x=602,y=365)
        uni_custom_cbox.place(x=575,y=363)
        
        custom_fsr_cbox.place(x=658,y=144)
        fsr_balanced_label.place(x=420,y=245)
        fsr_ultraq_label.place(x=420,y=185)
        fsr_quality_label.place(x=420,y=216)
        fsr_ultrap_label.place(x=420,y=305)
        fsr_performance_label.place(x=420,y=275)
        native_res_label.place(x=420,y=335)
change_labels()
    
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
    'Horizon Zero Dawn':'2.1',
    'Horizon Forbidden West':'2.2',
    'The Last of Us':'2.1',
    'Uncharted: Legacy of Thievs':'2.1',
    'Achilles Legends Untold':'2.2',
    'A Plague Tale Requiem':'2.2',
    'Alan Wake 2':'2.2',
    'Alone in the Dark':'2.0',
    'Assassin\'s Creed Mirage':'2.2',
    'Assassin\'s Creed Valhalla':'DLSS',
    'Atomic Heart':'2.2',
    'Baldur\'s Gate 3':'PD',
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
    'Cyberpunk 2077':'2.2',
    'Dakar Desert Rally':'2.2',
    'Deathloop':'2.0',
    'Dead Island 2':'2.2',
    'Death Stranding Director\'s Cut':'2.2',
    'Dead Space (2023)':'2.1',
    'Dragons Dogma 2':'US',
    'Dying Light 2':'2.0',
    'Elden Ring':'PD',
    'Everspace 2':'2.2',
    'Evil West':'2.2',
    'Fallout 4':'PD',
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
    'GTA V':'PD',
    'Martha Is Dead':'2.1',
    'Marvel\'s Guardians of the Galaxy':'2.0',
    'Hellblade: Senua\'s Sacrifice':'2.1',
    'Hellblade 2':'2.2',
    'High On Life':'2.0',
    'Hitman 3':'2.1',
    'Hogwarts Legacy':'2.2',
    'Icarus':'ICR',
    'Judgment':'2.1',
    'Jusant':'2.0',
    'Kena: Bridge of Spirits':'2.2',
    'Layers of Fear':'2.0',
    'Lies of P':'2.2',
    'Lords of the Fallen':'2.2',
    'Loopmancer':'2.2',
    'Manor Lords':'2.2',
    'Marvel\'s Spider-Man Remastered':'2.1',
    'Marvel\'s Spider-Man Miles Morales':'2.1',
    'Metro Exodus Enhanced Edition': '2.2',
    'Monster Hunter Rise':'2.2',
    'MOTO GP 24':'SDK',
    'Nightingale':'2.0',
    'Nobody Wants To Die':'3.0',
    'Outpost: Infinity Siege':'2.2',
    'Pacific Drive':'SDK',
    'Palworld':'2.2',
    'Ratchet & Clank - Rift Apart':'SDK',
    'Red Dead Redemption 2':'RDR2',
    'Ready or Not':'2.2',
    'Remnant II':'2.2',
    'Returnal':'2.1',
    'Rise of The Tomb Raider':'2.0',
    'Ripout':'2.1',
    'RoboCop: Rogue City':'2.2',
    'Saints Row':'2.1',
    'Satisfactory':'2.2',
    'Sackboy: A Big Adventure':'2.2',
    'Shadow of the Tomb Raider':'2.0',
    'Shadow Warrior 3':'2.2',
    'Smalland':'2.2',
    'Starfield':'2.2',
    'STAR WARS Jedi: Survivor':'2.2',
    'Star Wars Outlaws':'2.2',
    'Steelrising':'2.2',
    'TEKKEN 8':'2.2',
    'The Callisto Protocol':'2.1',
    'The Chant':'2.2',
    'The Invincible':'2.2',
    'The Last of Us Part I':'US',
    'The Medium':'2.2',
    'The Thaumaturge':'2.2',
    'The Outer Worlds: Spacer\'s Choice Edition':'2.0',
    'The Witcher 3':'2.0',
    'Uncharted Legacy of Thieves Collection':'2.1',
    'Wanted: Dead':'2.2'  
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
def update_canvas(event=None): #canvas_options text configuration
    global mod_options,x,y,select_fsr,fsr_visible,fsr_game_version,color_rec_bool,select_option,fsr_view_listbox
    
    def mod_text():
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    
    if fsr_view_listbox == True:
        canvas_options.delete('text')
        
    index = listbox.curselection()
    if index:
        select_option = listbox.get(index)
        x = 2
        y = 8
        fsr_canvas.delete('text')
        if select_option != 'Select FSR version': 
            color_rec_bool = False
            fsr_view_listbox = False
            canvas_options.delete('text')  
            canvas_options.create_text(x, y, anchor='w', text=select_option, fill='black', tag='text')
            fsr_canvas.create_text(2, 8, anchor='w', text=fsr_game_version.get(select_option, ''), fill='black', tag='text')
            fsr_listbox.place_forget()
    
    if select_option == 'Select FSR version':
        fsr_view_listbox = True
        color_rec_bool = True
        canvas_options.delete('text')
        canvas_options.create_text(x, y, anchor='w', text='Select FSR version', fill='black', tag='text')
    
    if select_option == 'Red Dead Redemption 2':
        mod_text()
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        mod_version_listbox.insert(tk.END,'RDR2 Build_2','RDR2 Build_4','RDR2 Mix','RDR2 Mix 2','Red Dead Redemption V2','RDR2 Non Steam FSR3','RDR2 FSR 3.1 FG','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss','FSR 3.1/DLSS Optiscaler')
    
    elif select_option == 'Dragons Dogma 2':
        mod_text()
        mod_version_listbox.insert(tk.END,'Dinput8','FSR 3.1/DLSS DD2 ALL GPU','FSR 3.1/DLSS DD2 NVIDIA','Uniscaler_DD2','Uniscaler + Xess + Dlss DD2')
    
    elif select_option == 'Elden Ring':
        mod_text()
        mod_version_listbox.insert(tk.END,'Disable_Anti-Cheat','Elden_Ring_FSR3','Elden_Ring_FSR3 V2','Elden_Ring_FSR3_V3','Unlock FPS Elden')
    
    elif select_option == 'Baldur\'s Gate 3':
        mod_text()
        mod_version_listbox.insert(tk.END,'Baldur\'s Gate 3 FSR3','Baldur\'s Gate 3 FSR3 V2','Baldur\'s Gate 3 FSR3 V3')
    
    elif select_option == 'The Callisto Protocol':
        mod_text()
        mod_version_listbox.insert(tk.END,'The Callisto Protocol FSR3','0.10.4','Uniscaler V3')  
    
    elif select_option == 'Fallout 4':
        mod_text()
        mod_version_listbox.insert(tk.END,'Fallout 4 FSR3') 
    
    elif select_option == 'Forza Horizon 5':
        mod_text()
        mod_version_listbox.insert(tk.END,'Forza Horizon 5 FSR3') 
    
    elif select_option == 'Forza Horizon 5':
        mod_text()
        mod_version_listbox.insert(tk.END,'Forza Horizon 5 FSR3') 
    
    elif select_option == 'Palworld':
        mod_text()
        mod_version_listbox.insert(tk.END,'Palworld Build03','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        
    elif select_option == 'TEKKEN 8':
        mod_text()
        mod_version_listbox.insert(tk.END,'Unlock Fps Tekken 8','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        
    elif select_option == 'Icarus':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Icarus FSR3 AMD/GTX','Icarus FSR3 RTX')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
        
    elif select_option == 'The Last of Us Part I':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Uniscaler Tlou','Uniscaler FSR 3.1')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
        
    elif select_option == 'Marvel\'s Spider-Man Remastered':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Uniscaler Spider','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
    
    elif select_option == 'Marvel\'s Spider-Man Miles Morales':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Uni Custom Miles','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        
    elif select_option == 'GTA V':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Dinput 8','GTA V FSR3','GTA V FiveM','GTA Online','GTA V Epic','GTA V Epic V2')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        
    elif select_option == 'Lords of the Fallen':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Lords of The Fallen FSR3')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    
    elif select_option == 'Horizon Forbidden West':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Horizon Forbidden West FSR3','Uniscaler FSR 3.1')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
        
    elif select_option == 'Alan Wake 2':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Alan Wake 2 FG RTX','Alan Wake 2 Uniscaler Custom','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss','FSR 3.1/DLSS Optiscaler')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
    
    elif select_option == 'Ghost of Tsushima':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Ghost of Tsushima FG DLSS','Uniscaler FSR 3.1')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    
    elif select_option == 'Assassin\'s Creed Valhalla':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Ac Valhalla DLSS3 (Only RTX)','Ac Valhalla FSR3 All GPU')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    
    elif select_option == 'The Witcher 3':
        mod_text()
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        mod_version_listbox.insert(tk.END,'FSR 3.1/DLSS Optiscaler','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss')
    
    elif select_option == 'Hellblade 2':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Hellblade 2 FSR3 (Only RTX)','Remove Black Bars','Remove Black Bars Alt','Remove Post Processing Effects','Remove All Post Processing Effects','Restore Post Processing','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(45,0))
    
    elif select_option == 'STAR WARS Jedi: Survivor':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Dlss Jedi','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(45,0))
    
    elif select_option == 'Cyberpunk 2077':
        mod_text() 
        mod_version_listbox.insert(tk.END,'RTX DLSS FG','FSR 3.1/DLSS Optiscaler','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(45,0))
    
    elif select_option == 'Flintlock: The Siege of Dawn':
        mod_text() 
        mod_version_listbox.insert(tk.END,'FSR 3.1/DLSS Optiscaler')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    
    elif select_option == 'COD MW3':
        mod_text() 
        mod_version_listbox.insert(tk.END,'COD MW3 FSR3')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    
    elif select_option == 'Dying Light 2':
        mod_text() 
        mod_version_listbox.insert(tk.END,'DL2 DLSS FG','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss','FSR 3.1/DLSS Optiscaler')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(45,0))
    
    elif select_option == 'Black Myth: Wukong':
        mod_text() 
        mod_version_listbox.insert(tk.END,'RTX DLSS FG Wukong','FSR 3.1 Custom Wukong','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss','FSR 3.1/DLSS Optiscaler')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(45,0))

    elif select_option == 'Final Fantasy XVI':
        mod_text() 
        mod_version_listbox.insert(tk.END,'FFXVI DLSS ALL GPU','FFXVI DLSS RTX','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss','FSR 3.1/DLSS Optiscaler')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(45,0))
    
    elif select_option == 'Star Wars Outlaws':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Outlaws DLSS RTX','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss','FSR 3.1/DLSS Optiscaler')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(45,0))
    
    else:
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        for mod_op in mod_options:
            mod_version_listbox.insert(tk.END,mod_op)    
    fsr_listbox_view()
    
options = ['Select FSR version','Achilles Legends Untold','Alan Wake 2','Alone in the Dark','A Plague Tale Requiem','Assassin\'s Creed Mirage','Assassin\'s Creed Valhalla','Atomic Heart','Baldur\'s Gate 3','Banishers: Ghosts of New Eden','Black Myth: Wukong','Blacktail','Bright Memory: Infinite','Brothers: A Tale of Two Sons Remake','Chernobylite','Cod Black Ops Cold War','COD MW3','Control','Crime Boss Rockay City','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Deathloop','Death Stranding Director\'s Cut','Dead Space (2023)','Dragons Dogma 2','Dying Light 2','Elden Ring','Everspace 2','Evil West','Fallout 4','F1 2022','F1 2023','Final Fantasy XVI','FIST: Forged In Shadow Torch','Flintlock: The Siege of Dawn','Fort Solis',
        'Forza Horizon 5','Ghost of Tsushima','Ghostrunner 2','Ghostwire: Tokyo','GTA V','Hellblade: Senua\'s Sacrifice','Hellblade 2','High On Life','Hitman 3','Hogwarts Legacy','Horizon Zero Dawn','Horizon Forbidden West','Icarus','Judgment','Jusant','Kena: Bridge of Spirits','Layers of Fear','Lies of P','Lords of the Fallen','Loopmancer','Manor Lords','Martha Is Dead','Marvel\'s Guardians of the Galaxy','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man Miles Morales','Metro Exodus Enhanced Edition','Monster Hunter Rise','MOTO GP 24','Nightingale','Nobody Wants To Die','Outpost: Infinity Siege','Pacific Drive','Palworld','Ratchet & Clank - Rift Apart',
        'Red Dead Redemption 2','Ready or Not','Remnant II','Returnal','Rise of The Tomb Raider','Ripout','RoboCop: Rogue City','Saints Row','Satisfactory','Sackboy: A Big Adventure','Shadow Warrior 3','Shadow of the Tomb Raider','Smalland','Starfield','STAR WARS Jedi: Survivor','Star Wars Outlaws','Steelrising','TEKKEN 8','The Callisto Protocol','The Chant','The Invincible','The Last of Us Part I','The Medium','The Outer Worlds: Spacer\'s Choice Edition','The Witcher 3','Uncharted Legacy of Thieves Collection','Wanted: Dead']#add options
for option in options:
    listbox.insert(tk.END,option)

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
    
fsr_options = ['SDK','2.0','2.1','2.2','RDR2']
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
    
    if select_mod in ['Remove Black Bars','Remove Black Bars Alt','Remove Post Processing Effects','Remove All Post Processing Effects','Restore Post Processing']:
        fsr3_hellblade_2()
    
    if select_mod == 'Hellblade 2 FSR3 (Only RTX)':
        path_inihb2 = os.getenv("LOCALAPPDATA") + '\\Hellblade2\\Saved\\Config\\Windows'
        alt_path_hb2 = os.getenv("LOCALAPPDATA") + '\\Hellblade2\\Saved\\Config\\WinGDK'
             
        if select_folder == path_inihb2 or select_folder == alt_path_hb2:
            game_folder_canvas.delete('text')
            select_folder = None
           
    mod_version_canvas.update()

mod_options = ['0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','FSR 3.1/DLSS Optiscaler','Uniscaler','Uniscaler V2','Uniscaler V3','Uniscaler FSR 3.1','Uniscaler + Xess + Dlss']
for mod_op in mod_options:
    mod_version_listbox.insert(tk.END,mod_op)
  
def update_asi(event=None):
    global option_asi,select_asi_bool,select_asi_notvisible
    index_asi = asi_listbox.curselection()
    if index_asi:
        option_asi = asi_listbox.get(index_asi)
        asi_canvas.delete('text')
        asi_canvas.create_text(2,8,anchor='w',text=option_asi,fill='black',tags='text')
    if option_asi == 'ASI Loader for RDR2' or option_asi == 'Default':
        select_asi_notvisible = False
        select_asi_notvisible = False
        select_asi_canvas.delete('text')
        select_asi_listbox.place_forget()
    else:
        select_asi_notvisible = True
        select_asi_bool = True
    update_asi_color()
    asi_canvas.update()
    
asi_options = ['Default','Select ASI Loader','ASI Loader for RDR2']
for asi_op in asi_options:
    asi_listbox.insert(tk.END,asi_op)

def update_select_asi(event=None):
    global select_asi
    index_select_asi = select_asi_listbox.curselection()
    if index_select_asi:
        select_asi = select_asi_listbox.get(index_select_asi)
        select_asi_canvas.delete('text')
        select_asi_canvas.create_text(2,8,anchor='w',text=select_asi,fill='black',tags='text')
    select_asi_canvas.update()
    
select_asi_options =  ['2.0','2.1','2.2','SDK']
for select_asi_op in select_asi_options:
    select_asi_listbox.insert(tk.END,select_asi_op)
    
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
        
    elif select_mod in list_uni and select_mod != 'Uniscaler V3' and select_mod != 'Uniscaler FSR 3.1' or select_mod == 'Uni Custom Miles' or select_mod == 'Dlss Jedi':
        mod_op_list = ['FSR3','DLSS','XESS']
        mod_operates_listbox.delete(0,tk.END)
        unlock_listbox_mod_op = True
        mod_operates_canvas.config(bg='white')
    elif select_mod == 'Uniscaler V3':
        mod_op_list = ['None','FSR3','DLSS','XESS']
        mod_operates_listbox.delete(0,tk.END)
        unlock_listbox_mod_op = True
        mod_operates_canvas.config(bg='white') 
    elif select_mod == 'Uniscaler FSR 3.1':
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
        nvngx_op = ['Default', 'NVNGX Version 1', 'XESS 1.3.1', 'DLSS 3.7.0','DLSS 3.7.0 FG','DLSS 3.7.2','DLSSG 3.7.1 FG','DLSSD 3.7.1']

    nvngx_listbox.delete(0, tk.END) 
    for nvngx_options in nvngx_op:
        nvngx_listbox.insert(tk.END, nvngx_options)
    
    if index_nvngx_op:
        select_nvngx = nvngx_listbox.get(index_nvngx_op)
        nvngx_canvas.delete('text')   
    nvngx_canvas.delete('text')  
    get_canvas = nvngx_canvas.create_text(2, 8, anchor='w', text=select_nvngx, fill='black', tags='text')

    text_canvas_nvngx = nvngx_canvas.itemcget(get_canvas, "text")
    
    if select_mod == 'Uniscaler + Xess + Dlss' and text_canvas_nvngx == 'XESS 1.3.1' or select_mod == 'Uniscaler + Xess + Dlss' and text_canvas_nvngx == 'DLSS 3.7.0':
        nvngx_canvas.delete('text')
    
    nvngx_canvas.update()

nvngx_op = ['Default', 'NVNGX Version 1', 'XESS 1.3.1', 'DLSS 3.7.0','DLSSG 3.7.0 FG','DLSS 3.7.2','DLSSG 3.7.1 FG','DLSSD 3.7.1']
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
        if select_mod != 'The Witcher 3 Optiscaler FG':
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

canvas_options.bind('<Button-1>',select_game_listbox_view)
fsr_canvas.bind('<Button-1>',fsr_listbox_visible)
listbox.bind("<<ListboxSelect>>",update_canvas)
fsr_listbox.bind("<<ListboxSelect>>",update_fsr_v)
fakegpu_label.bind('<Enter>',guide_fk_gpu)
fakegpu_label.bind('<Leave>',close_fk_gpu_guide)
select_folder_canvas.bind('<Button-1>',open_explorer)
search_game_exe_canvas.bind('<Button-1>',search_game_exe)
epic_over_browser_canvas.bind('<Button-1>',epic_explorer)
epic_over_enable_label.bind('<Button-1>',enable_epic_over)
epic_over_disable_label.bind('<Button-1>',disable_epic_over)
epic_over_auto_label.bind('<Button-1>',epic_dis_over)
mod_version_canvas.bind('<Button-1>',mod_listbox_view)
mod_version_listbox.bind("<<ListboxSelect>>",update_mod_version)
asi_canvas.bind('<Button-1>',asi_listbox_view)
asi_listbox.bind('<<ListboxSelect>>',update_asi)
asi_label.bind('<Enter>',guide_asi)
asi_label.bind('<Leave>',close_asi_guide)
select_asi_canvas.bind('<Button-1>',select_asi_view)
select_asi_listbox.bind('<<ListboxSelect>>',update_select_asi)
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
lfz_sl_label.bind('<Enter>',guide_lfz)
lfz_sl_label.bind('<Leave>',close_lfz_guide)
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