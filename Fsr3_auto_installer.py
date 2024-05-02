import tkinter as tk
from PIL import ImageTk, Image
from customtkinter import *
from tkinter import Canvas,filedialog,messagebox
import subprocess,os,shutil
import toml
import sys
import re
import ctypes
from tkinter import font as tkFont
from configobj import ConfigObj
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
screen.title("FSR3.0 Mod Setup Utility - 1.7.7v")
screen.geometry("700x590")
screen.resizable(0,0)
screen.configure(bg='black')
def exit_screen(event=None):
    sys.exit()
screen.protocol('WM_DELETE_WINDOW',exit_screen)
if not unlock_screen:
    sys.exit()

icon_image = tk.PhotoImage(file="images\FSR-3-Supported-GPUs-Games.gif")
screen.iconphoto(True, icon_image)

img_bg = Image.open('images\gray-amd-logo-n657xc6ettzratsr...-removebg-preview.png')
img_res = img_bg.resize((200,300))
img_tk =ImageTk.PhotoImage(img_res)
x_img = (405 - 180)//2
y_img = (900 - 250)//2

bg_label = tk.Label(screen,image=img_tk,bg='black')
bg_label.place(x=x_img,y=y_img)

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
exit_label.place(x=355,y=458)

install_label = tk.Label(screen,text='Install',font=font_select,bg='black',fg='#E6E6FA')
install_label.place(x=295,y=458)

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
            print('1')
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
    epic_label_guide.place(x=0,y=420)
    epic_label_guide.lift()

def close_guide_epic(event=None):
    epic_label_guide.place_forget()

epic_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
epic_label_guide.place_forget()

epic_over_label = tk.Label(screen,text='Epic Games Overlay:',font=font_select,bg='black',fg='#C0C0C0')
epic_over_label.place(x=0,y=395)

epic_over_canvas = tk.Canvas(screen,width=162,height=19,bg='white',highlightthickness=0)
epic_over_canvas.place(x=152,y=400)

epic_over_browser_canvas = tk.Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
epic_over_browser_canvas.create_text(0,8,anchor='w',font=(font_select,9,'bold'),text='Browser',fill='black')
epic_over_browser_canvas.place(x=340,y=399)

epic_over_marc_label = tk.Label(screen,text='–',font=font_select,bg='black',fg='#C0C0C0')
epic_over_marc_label.place(x=319,y=393)

epic_over_disable_label = tk.Label(screen,text='Disable',font=font_select,bg='black',fg='#E6E6FA')
epic_over_disable_label.place(x=330,y=425)

epic_over_enable_label = tk.Label(screen,text='Enable',font=font_select,bg='black',fg='#E6E6FA')
epic_over_enable_label.place(x=270,y=425)

epic_over_auto_label = tk.Label(screen,text='Auto Search',font=font_select,bg='black',fg='#E6E6FA')
epic_over_auto_label.place(x=175,y=425)

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
fsr_guide_label.place(x=265,y=367)
fsr_guide_var = tk.IntVar()
fsr_guide_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=fsr_guide_var,command=fsr_guide)
fsr_guide_cbox.place(x=348,y=369)

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
    
    s_games_op = ['Initial Information','Add-on Mods','Alone in the Dark','Baldur\'s Gate 3','Blacktail','Bright Memory: Infinite','Chernobylite','Dead Space Remake','Dead Island 2','Deathloop','Dragons Dogma 2','Dying Light 2','Elden Ring','Fallout 4','Forza Horizon 5','F1 2022','F1 2023','Ghostrunner 2','Hellblade: Senua\'s Sacrifice',
                'High On Life','Hogwarts legacy','Horizon Forbidden West','Icarus','Kena: Bridge of Spirits','Lies of P','Manor Lords','Martha Is Dead','Marvel\'s Guardians of the Galaxy','Palworld','Rise of The Tomb Raider','Ready or Not','Red Dead Redemption 2','Red Dead Redemption 2 MIX','Red Dead Redemption Mix 2','Returnal',
                'Sackboy: A Big Adventure','Shadow of the Tomb Raider','Shadow Warrior 3','Star Wars: Jedi Survivor','Steelrising','TEKKEN 8','The Chant','The Callisto Protocol',"The Outer Worlds: Spacer's Choice Edition",'The Thaumaturge','Uniscaler','XESS/DLSS']
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

'Tweak\n'
'Helps \'improve\' aliasing caused by FSR 3 mod, may also\nslightly reduce ghosting, doesn\'t work in all games.\n\n'

),

'Alone in the Dark':(
"1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n"
"2 - Enable the 'Enable Signature Override' checkbox.\n"
"3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n"
"4 - Set FSR in the game settings.\n"
"5 - If the mod doesn't work, elect 'Default' in Nvngx.dll."
),

'Baldur\'s Gate 3': (
'1 - Start the game in DX11 and select Borderless.\n'
'2 - Choose DLSS or DLAA.\n'
'3 - Press the END key to enter the mod menu, check\nthe Frame Generation box to activate the mod; you can also\nadjust the Upscaler. (To activate Frame Generation, simply\npress the * key; you can also change the key in the mod\nmenu.)\n'  
),

'Blacktail':(
  '1 - Select a mod of your choice (0.10.3 is recommended)\n'
  '2 - "Check the Fake Nvidia GPU box.'  
),

'Bright Memory: Infinite':(
  '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n '  
  '2 -  To make the mod work, run it in DX12. To run it in DX12, right-click the game\'s\nexe and create a shortcut, then right-click the shortcut again,\ngo to \"Properties,\" and at the end of \"Target\" (outside the\nquotes), add -dx12 or go to your Steam library, select the\ngame, go to Settings > Properties > Startup options, and\nenter -dx12.'
),

'Dead Island 2':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - If it doesn\'t work with the default files, enable\nEnable Signature Override. If it still doesn\'t work, check the\nbox lfz.sl.dlss.\n'
'3 - It\'s not necessary to activate an upscaler for this game\nfor the mod to work, so enable it if you want.'
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

'Shadow Warrior 3':(
'Select a mod of your preference (0.10.3 is recommended)\n'
'2 - Inside the game, select FSR. (You can use it with DLSS\nbut there might be flickering).\n'
'3 - Set Ambient Occlusion and Post Processing to Low.' 
),

'Ghostrunner 2': (
    '1 - Select a version of the mod of your choice (version 0.10.3\nis recommended)\n' 
    '2 - To make the mod work, run it in DX12. To run it in DX12, right-click\nthe game exe and create a shortcut, then right-click the shortcut\nagain, go to \"Properties,\" and at the end of \"Target\" (outside the\nquotes), add -dx12 or go to your Steam library, select the game, go to\nSettings > Properties > Startup options, and enter -dx12.\n'
    '3 - Activate Fake Nvidia Gpu (AMD only)\n'
    '4 - Inside the game, set the frame limit to unlimited, activate DLSS first\n(disable other upscalers before) and then activate frame generation\n'
    '• To fix the flickering of the HUD, activate and deactivate frame\ngeneration again (no need to apply settings).'
),

'Hellblade: Senua\'s Sacrifice':(
    '1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n'
    '2 - Select Fake Nvidia Gpu and UE Compatibility (AMD only),\nselect Fake Nvidia Gpu and Nvapi Results (GTX only).'
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

'Horizon Forbidden West':(
'1 - Turn off MSI Afterburner/Rivatuner or any other FPS monitor to\navoid crashes.\n'
'2 - If the game still crashes, select \'Nvngx: Default\' and enable\n\'Enable Signature Override\'\n'
'3 - Turn Dynamic Resolution Scaling Off if you still have the black box\nsquare on-screen\n'
'4 - If you experience sudden FPS drops during cutscenes, delete\ndstorage.dll and dstoragecore.dll (A function to delete these 2 files\nwill be implemented soon)\n'
),

'Icarus':(
'1 - Select Icarus FSR3 in mod version.\n'
'2 - If the option selected is RTX, confirm the window that appears.\n'
'3 - If the option is AMD/GTX and you notice that the mod is not generating FPS, open\nthe file fsr2fsr3.config and replace "mode = default" on the first line with "replace_dlss_fg",\nkeep it inside the quotation marks, it will look like this: mode = "replace_dlss_fg".\n'
'4 - Start the game in DX12, if the game exe is in the destination folder where the mod was\ninstalled, a DX12 shortcut will be created on your Desktop. If the exe is not found, you\nneed to create a shortcut and in the properties, at the end of Target, add -dx12 outside the\nquotes if there are any, don\'t forget to put a space between -dx12 and the path.\n'  
'5 - Run the game through the executable.'
),

'Kena: Bridge of Spirits': (
  '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n'  
  '2 - Activate Fake Nvidia Gpu and Nvapi Results (AMD only).'
),

'Lies of P':(
'1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n'
'2 - Activate Fake Nvidia Gpu and UE Compatibility Mode\n(AMD only).\n'
'3 - To fix the flickering of the Hud, first select DLSS Quality,\nthen select FSR Quality (without disabling DLSS), then\nselect DLSS again.'
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

'Palworld':(
'For standard mods (0.10+ and Uniscaler), simply enable \nthe fake Nvidia GPU (for AMD and GTX) and UE Compatibility\nmode (for AMD) and set the game to DX12. Throughout the\nguide, it will be explained how to do this.\n\n'
'1. Select Palworld Build03 and locate the game folder with the\nending binaries/win64 and see if the executable with the ending\nWin64-shipping.exe is present.\n'
'2. Install, confirm the GPU selection window that will appear.\n'
'3. To run the game in DX12, simply confirm the window that\nappears after confirming the GPU selection. Make sure the\nmentioned exe is in the selected folder. Alternatively, you can\nignore the window and do it manually, by creating a shortcut\nand adding \'-dx12\' after the quotes in the \'Target\' field.\n'
'4. Run the game through the shortcut.\n\n'
'• Currently, the mod only works on Steam versions and \nalternative versions with Steam files.'  
),

'Returnal':(
"1 - Choose a version of the mod you prefer (version 0.10.3\nis recommended).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the\nmod doesn't work.\n"
"3 - Select 'Default' in Nvngx.dll."
),

'Star Wars: Jedi Survivor':(
"1 - Choose a version of the mod you prefer (Recommended\nversion 0.10.2 or higher).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the\nmod doesn't work.\n"
"3 - Select 'Default' in Nvngx.dll."
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
'● Select \'Nvngx: Default\' and enable \'Enable Signature Override\' if the mod doesn\'t work\n(AMD GPU users only).'
),

'Steelrising':(
'1 - Choose a version of the mod you prefer (version 0.10.3 is\nrecommended).\n'
'2 - Enable Fake Nvidia GPU (only for AMD and GTX).\n'
'3 - Enable NVAPI Results (only for GTX).\n'
'4 - In Mod Operates, select Enable Upscaling Only.\n\n'
'● To fix the Hub Flickering, do not select any option in Mod\nOperates, open the game, and choose FSR 1.0.'
),

'Rise of The Tomb Raider':(
'1 - Select a version of the mod of your choice (it is recommended 0.10.3\nonwards or Uniscaler)\n'
'2 - Select the folder where the game\'s exe is located (something like\nROTTR.exe)\n'
'3 - Activate Fake Nvidia GPU (if you don\'t have Rtx 3xxx/4xxx series)\n'
'4 - Inside the game, select DLSS as desired, to remove the flickering\nfrom the HUD, select SMAA as Anti Aliasing (this will slightly decrease\nfps)\n'
'• To use Uniscaler, it is necessary to select the \'DLSS\' option in\nMod Operates\n'
'• If the game is on Epic Games, it is necessary to disable the Overlay,\nsimply go to \'Epic Games Overlay\'.'
),

'Ready or Not': (
'1 - Select a version of the mod of your choice (version\n0.10.3 is recommended).\n'
'2 - Select the game folder that has the ending\n"\ReadyOrNot\Binaries\Win64".\n'
'3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n'
'4 - Set Anti-Aliasing to High or Epic + FSR2 Quality\n(DLSS won\'t work with UI flickering fix).\n'
'5 - UI flickering fix: Change Anti-Aliasing from Epic or High\nto Medium.\n'
'After launching the game again, you need to set\nAnti-Aliasing back to High or Epic to activate the mod before\nplaying the character.'
),

'TEKKEN 8':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Enable Fake Nvidia GPU.\n'
'3 - To fix the flickering of the HUD, select any upscaler\n(except DLSS) and wait for 30 seconds, then select DLSS.\nYou may need to do this more than once.\n\n'

'• Fix slow-motion problem\n'
'Turn off v-sync and motion blur, and lower all your settings\n(except Textual quality + FSR2 or DLSS) until your game no\nlonger experiences the slow-motion problem.\n\n'

'Unlock FPS\n'
'1 - Unlock FPS cannot be used alongside FSR3 mod.\n'
'2 - Select Unlock FPS under Mod Version and install it.\n'
'3 - Open the game and select an upscaler.\n'
'4 - Go to the selected folder in Select Folder and run\nTekkenOverlay.exe (with the game open).'
),

'The Callisto Protocol':(
  '1 - Select The Callisto Protocol Fsr 3 in Mod Version and\ncheck the Fake Nvidia GPU box and install.\n'
'2 - To fix the HUD flickering: within the game, select fsr2,\nAnti-Aliasing to TemporalAA, and turn off the film grain, play\nfor a few seconds, return to the menu, and switch fsr2 to\nTemporal.'  
),

'The Chant':(
'1 - Select a mod of your preference (0.10.3 is recommended).\n'
'2 - Enable Fake Nvidia Gpu, if Frame Generation is not\ndetected, enable Nvapi Results. (only Amd and Gtx)'  
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
        screen_guide.geometry('740x260')
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
    guide_fsr_label.place(x=265,y=390)

def close_guide_fsr(event=None):
    guide_fsr_label.place_forget()
    
guide_fsr_label = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
guide_fsr_label.place_forget()

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
            else:
                return  
   
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
        
    if select_option == 'Dragons Dogma 2':
        comp_files(dd2_folder)
        unlock_view_message = False
        
    if select_option == 'Elden Ring':
        comp_files(er_origins)
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
    else:
        return 
    
    if sucess_message and unlock_view_message:
        messagebox.showinfo('Success', 'Backup completed successfully.')
    elif not sucess_message and not unlock_view_message:
        messagebox.showinfo('Not found', 'No matching files, backup was not completed.') 
        return               
        
def cbox_backup():
    if backup_var.get() == 1:
        backup_files()

backup_label = tk.Label(screen,text='Backup',font=font_select,bg='black',fg='#C0C0C0')
backup_label.place(x=156,y=367)
backup_var = IntVar()
backup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=backup_var,command=cbox_backup)
backup_cbox.place(x=214,y=369)

uni_custom_contr = False
select_uni_custom = ""
unlock_uni_custom_res = False
def cbox_uni_custom():
    global uni_custom_contr
    
    if uni_custom_var.get() == 1 and (select_mod == "Uniscaler" or select_mod == "Uniscaler + Xess + Dlss"):
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
    
    if uni_custom_contr and (select_mod == 'Uniscaler' or select_mod == 'Uniscaler + Xess + Dlss'):
        if uni_custom_view:
            uni_custom_view = False
            uni_custom_listbox.place_forget()
        else:
            uni_custom_listbox.place(x=609,y=389)
            uni_custom_view = True

def unlock_uni_custom():
    global unlock_uni_custom_res
    if select_mod == 'Uniscaler' or select_mod == 'Uniscaler + Xess + Dlss':
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
    
    if select_mod == 'Uniscaler':
        path_uni_config = 'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml'
    elif select_mod == 'Uniscaler + Xess + Dlss':
        path_uni_config = 'mods\\Temp\\FSR2FSR3_Uniscaler_Xess_Dlss\\enable_fake_gpu\\uniscaler.config.toml'
    
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

addon_origins = {'OptiScaler':'mods\\Addons_mods\OptiScaler',
                 'Tweak':'mods\\Addons_mods\\tweak'}
select_addon_dx11 = 'auto'
select_addon_dx12 = 'auto'
select_addon_mods = None
def addon_mods():
    path_ini_optiscaler = 'mods\Temp\OptiScaler'
    if select_addon_mods in addon_origins:
        path_addon = addon_origins[select_addon_mods]
    
    try:
        if select_addon_mods == 'OptiScaler':
            shutil.copytree(path_addon,select_folder,dirs_exist_ok=True)
            shutil.copytree(path_ini_optiscaler,select_folder,dirs_exist_ok=True)
        elif select_addon_mods == 'Tweak':
            shutil.copytree(path_addon,select_folder,dirs_exist_ok=True)
    except Exception:
        messagebox.showinfo('Error','Error in installation, please check if you have correctly filled out Select Game, Select Folder, and Mod Version.')
        return
    
addon_contr = False
def cbox_addon_mods():
    global addon_contr,select_addon_mods
    if addon_mods_var.get() == 1:
        addon_mods_canvas.config(bg='white')
        addon_contr = True
    else:
        addon_mods_canvas.config(bg='#C0C0C0')
        addon_ups_dx11_canvas.config(bg='#C0C0C0')
        addon_ups_dx12_canvas.config(bg='#C0C0C0')
        addon_mods_canvas.delete('text')
        select_addon_mods = None
        addon_contr = False
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
        addon_ups_dx11_listbox.place_forget()
        addon_ups_dx12_listbox.place_forget()
        addon_view = False

addon_view_dx11 = False
def addon_dx11_view(event=None):
    global addon_view,addon_contr
    if addon_contr and select_addon_mods == 'OptiScaler':
        if addon_view:
            addon_ups_dx11_listbox.place_forget()
            addon_view = False
        else:
            addon_view = True
            addon_ups_dx11_listbox.place(x=583,y=511)

addon_view_dx12 = False
def addon_dx12_view(event=None):
    global addon_view,addon_contr
    if addon_contr and select_addon_mods == 'OptiScaler':
        if addon_view:
            addon_ups_dx12_listbox.place_forget()
            addon_view = False
        else:
            addon_view = True
            addon_ups_dx12_listbox.place(x=583,y=541)

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
                      'xess DX11':'xess',
                      'fsr2.1 DX11':'fsr21_12',
                      'fsr2.2 DX11 - DX12':'fsr22_12'}

addon_dx12_origins= {'xess DX12':'xess',
                    'fsr2.1 DX12':'fsr21',
                    'fsr2.2 DX12':'fsr22' }

def update_optiscaler_ini():
    
    if select_addon_dx11 in addon_dx11_origins:
        option_addon = addon_dx11_origins[select_addon_dx11]
    
        path_ini_dx11 = 'mods\\Temp\\OptiScaler\\nvngx.ini'
        key_dx11 = 'Dx11Upscaler'
        value_ini_dx11 = option_addon
        
        update_ini(path_ini_dx11,key_dx11,value_ini_dx11)
    
    if select_addon_dx12 in addon_dx12_origins:
        option_addon = addon_dx12_origins[select_addon_dx12]
        key_dx12 = 'Dx12Upscaler'
        value_ini_dx12 = option_addon
    
        update_ini(path_ini_dx11,key_dx12,value_ini_dx12)

def replace_ini():
    path_ini = 'mods\\Temp\\OptiScaler\\nvngx.ini'
    path_ini_origin = 'mods\\Addons_mods\\OptiScaler\\nvngx.ini'
    folder_ini = 'mods\\Temp\\OptiScaler'
    if select_addon_mods == 'OptiScaler':
        os.remove(path_ini)
        shutil.copy2(path_ini_origin,folder_ini)

addon_ups_dx12_label = tk.Label(screen,text='Addon Upscaler DX12',font=font_select,bg='black',fg='#C0C0C0')
addon_ups_dx12_label.place(x=420,y=515)
addon_ups_dx12_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
addon_ups_dx12_canvas.place(x=583,y=519)
addon_ups_dx12_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)
addon_ups_dx12_listbox.place(x=583,y=541)
addon_ups_dx12_listbox.place_forget()
        
addon_ups_dx11_label = tk.Label(screen,text='Addon Upscaler DX11',font=font_select,bg='black',fg='#C0C0C0')
addon_ups_dx11_label.place(x=420,y=485)
addon_ups_dx11_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
addon_ups_dx11_canvas.place(x=583,y=489)
addon_ups_dx11_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)
addon_ups_dx11_listbox.place(x=583,y=511)
addon_ups_dx11_listbox.place_forget()

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

us_origin = {'Uniscaler':r'mods\Temp\Uniscaler\enable_fake_gpu\uniscaler.config.toml',
             'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'}

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
del_dxgi_label.place(x=0,y=460)
del_dxgi_var = IntVar()
del_dxgi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=del_dxgi_var,command=cbox_del_dxgi)
del_dxgi_cbox.place(x=120,y=462) 
   
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
 
      
def clean_mod():
    global select_folder
    mod_clean_list = ['fsr2fsr3.config.toml','winmm.ini','winmm.dll',
                      'lfz.sl.dlss.dll','FSR2FSR3.asi','EnableSignatureOverride.reg',
                      'DisableSignatureOverride.reg','nvngx.dll','_nvngx.dll','dxgi.dll',
                      'd3d12.dll','nvngx.ini','fsr2fsr3.log','Uniscaler.asi','uniscaler.config.toml','uniscaler.log','dinput8.dll']
   
    del_winmm = 'winmm.dll'
    
    del_elden_fsr3 =['_steam_appid.txt','_winhttp.dll','anti_cheat_toggler_config.ini','anti_cheat_toggler_mod_list.txt',
                     'start_game_in_offline_mode.exe','toggle_anti_cheat.exe','ReShade.ini','EldenRingUpscalerPreset.ini',
                     'dxgi.dll','d3dcompiler_47.dll','']
    
    del_bdg_fsr3 = ['nvngx.dll','version.dll','version.org']
    
    del_fl4_fsr3 = ['f4se_whatsnew.txt','f4se_steam_loader.dll','f4se_readme.txt','f4se_loader.exe','f4se_1_10_163.dll',
                    'CustomControlMap.txt']
    
    del_fh_fsr3 = ['DisableNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','nvngx.dll','RestoreNvidiaSignatureChecks.reg',
                   'dinput8.dll','dlssg_to_fsr3.asi','nvapi64.asi','winmm.dll','winmm.ini']
    
    del_rdr2_fsr3 = ['ReShade.ini','RDR2UpscalerPreset.ini','d3dcompiler_47.dll','d3d12.dll','dinput8.dll','ScriptHookRDR2.dll','NVNGX_Loader.asi',
                     'd3dcompiler_47.dll','nvngx.dll']
    
    del_icarus_otgpu_fsr3 = ['nvngx.dll', 'FSR2FSR3.asi','fsr2fsr3.config.toml','winmm.dll','winmm.ini']
    del_icarus_rtx_fsr3 = ['RestoreNvidiaSignatureChecks.reg','dlssg_to_fsr3_amd_is_better.dll','DisableNvidiaSignatureChecks.reg']
                       
    del_tekken_fsr3 = ['TekkenOverlay.exe','Tekken8OverlaySettings.yaml','Tekken8Overlay.dll','Tekken7Overlay.dll']

    del_tlou_fsr3 = ['winmm.ini','winmm.dll','nvngx_dlssg.dll','nvngx_dlss.dll','nvngx.dll','libxess.dll','uniscaler.asi','uniscaler.config.toml','uniscaler.log']
    
    try:     
        for item in os.listdir(select_folder):
            if item in mod_clean_list:
                os.remove(os.path.join(select_folder,item))
        
        path_dd2_w = os.path.join(select_folder,'_storage_')
        if select_option == 'Dragons Dogma 2':
            if os.path.exists(path_dd2_w):
                try:
                    os.remove(os.path.join(path_dd2_w,del_winmm)) 
                except FileNotFoundError:
                    pass 
                
            try:
                storage_folder = os.path.join(select_folder, '_storage_')
                var_storage = messagebox.askyesno('Storage','Would you like to delete the _storage_ folder? (folder created by the dinput8 file.')
                if var_storage:
                    if os.path.exists(storage_folder):
                        shutil.rmtree(storage_folder)
            except Exception as e:
                    pass 
        
        uniscaler_folder = os.path.join(select_folder, 'uniscaler')
        if os.path.exists(uniscaler_folder):
            shutil.rmtree(uniscaler_folder)
    except Exception as e:
        messagebox.showinfo('Error','Unable to delete the Uniscaler folder, please close the game or any other folders related to the game.')
    
    try:
        if select_option == 'Elden Ring':
            for item in os.listdir(select_folder):
                if item in mod_clean_list or item in del_elden_fsr3:
                    os.remove(os.path.join(select_folder,item))
                    
                er_mods = os.path.join(select_folder, 'mods')
                er_reshade = os.path.join(select_folder, 'reshade-shaders')
                if os.path.exists(er_mods or er_reshade):
                    shutil.rmtree(er_reshade)
                    shutil.rmtree(er_mods)           
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
            
    try:
        if select_option == 'Baldur\'s Gate 3':
            for item in os.listdir(select_folder):
                if item in del_bdg_fsr3:
                    os.remove(os.path.join(select_folder,item))
                    
            bdg_mods = os.path.join(select_folder, 'mods') 
            if os.path.exists(bdg_mods):
                shutil.rmtree(bdg_mods)
    except Exception as e:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')      
    
    name_xess = os.path.join(select_folder,'libxess.txt')
    new_xess = os.path.join(select_folder,'libxess.dll')
    rename_old_xess = 'libxess.dll'
    try:
        if select_mod == 'Uniscaler':
            if os.path.exists(name_xess):
                old_xess_rename = messagebox.askyesno('Old Xess','Do you want to remove Xess 1.3 and revert to the old version?')
                if old_xess_rename:
                    os.remove(new_xess)
                    os.rename(name_xess,os.path.join(select_folder,rename_old_xess))
            elif not os.path.exists(name_xess):
                if not os.path.exists(new_xess):
                    return
                else:
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
    
    try:#clear the mods for rdr2 and palworld
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
                            
    except Exception:
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
    
    name_dlss = os.path.join(select_folder,'nvngx_dlss.txt')
    new_dlss = os.path.join(select_folder,'nvngx_dlss.dll')
    rename_old_dlss = 'nvngx_dlss.dll'
    
    try:
        if select_mod == 'Uniscaler':
            if os.path.exists(name_dlss):
                old_dlss_rename = messagebox.askyesno('Old DLSS','Do you want to remove DLSS 3.7.0 and revert to the old version?')
                
                if old_dlss_rename:
                    os.remove(new_dlss)
                    os.rename(name_dlss,os.path.join(select_folder,rename_old_dlss))
                
            elif not os.path.exists(name_dlss):
                if not os.path.exists(new_dlss):
                    return
                else:
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
        print(e)
        messagebox.showinfo('Error','Please close the game or any other folders related to the game.')
                  
cleanup_label = tk.Label(screen,text='Cleanup Mod',font=font_select,bg='black',fg='#E6E6FA')
cleanup_label.place(x=0,y=426) 
cleanup_var = IntVar()
cleanup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=cleanup_var,command=cbox_cleanup)
cleanup_cbox.place(x=100,y=428)       

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
        'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
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
disable_console_label.place(x=0,y=367)
disable_console_var = IntVar()
disable_console_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=disable_console_var,command=cbox_disable_console)
disable_console_cbox.place(x=117,y=369)

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
    screen.update()
    
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
lfz_sl_label.place(x=265,y=335)
lfz_sl_var = IntVar()
lfz_sl_label_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=lfz_sl_var,command=cbox_lfz_sl)
lfz_sl_label_cbox.place(x=383,y=338)

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
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
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
debug_tear_lines_label.place(x=113,y=335)
debug_tear_lines_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_tear_lines_var,command=cbox_debug_tear_lines)
debug_tear_lines_cbox.place(x=241,y=338)

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
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
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
debug_view_label.place(x=0,y=335)
debug_view_var = IntVar()
debug_view_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_view_var,command=cbox_debug_view)
debug_view_cbox.place(x=90,y=338)

def enable_over():
    global list_over
    folder_en_over = 'mods\Temp\enable signature override\EnableSignatureOverride.reg'
    list_over = ['0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss']

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
enable_sigover_label.place(x=0,y=306)
enable_sigover_var = IntVar()
enable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=enable_sigover_var,command=cbox_enable_sigover)
enable_sigover_cbox.place(x=162,y=308)

def cbox_disable_sigover():
    if disable_sigover_var.get() == 1:
        disable_over()

disable_sigover_label = tk.Label(screen,text='Disable Signature Over',font=font_select,bg='black',fg='#C0C0C0')
disable_sigover_label.place(x=202,y=306)
disable_sigover_var = IntVar()
disable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=disable_sigover_var,command=cbox_disable_sigover)
disable_sigover_cbox.place(x=368,y=308)

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
                    '0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss']:
    
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
    'Uniscaler', 'Uniscaler + Xess + Dlss'
]:
    nvngx_folders[nvn_key] = nvngx_path_global

def copy_nvngx():
    global nvngx_folders
    nvngx_folder = nvngx_folders.get(select_mod) 
    
    if select_mod not in nvngx_folders:
        messagebox.showinfo('Error','Please select a version starting at 0.7.6 ')
    else:
        try:
            for item in os.listdir(nvngx_folder):
                nvn_path = os.path.join(nvngx_folder, item)
                if os.path.isfile(nvn_path) and select_nvngx == 'Default':
                    if item == 'nvngx.dll':
                        shutil.copy2(nvn_path, select_folder)
                        
                elif os.path.isfile(nvn_path) and select_nvngx == 'NVNGX Version 1':
                    if item == 'nvngx.ini':
                        shutil.copy2(nvn_path, select_folder)
                        
                elif os.path.isfile(nvn_path) and select_nvngx == 'XESS 1.3':
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
                        
        except Exception as e:
            messagebox.showinfo("Error","Please select the destination folder and the mod version")
            print(e)
            
custom_fsr_act = False

def unlock_custom():
    list_custom = ['0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss']
    if select_mod not in list_custom:
        messagebox.showwarning('Error','Please select a mod version starting from 0.9.0')
        custom_fsr_cbox.deselect()
        return False
    else:
        return True

def cbox_custom_fsr():
    global custom_fsr_act
    print(custom_fsr_var.get())
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
custom_fsr_label.place(x=420,y=145)
custom_fsr_var = IntVar()
custom_fsr_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=custom_fsr_var,command=cbox_custom_fsr)
custom_fsr_cbox.place(x=672,y=147)

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
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
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
        print(fsr_quality_up_count_f)
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
    'The Callisto Protocol FSR3':'mods\\FSR3_Callisto\\enable_fake_gpu\\fsr2fsr3.config.toml'
}

def fake_gpu_mod():
    global folder_fake_gpu
    
    key_1 = 'compatibility'
    sob_line = 'fake_nvidia_gpu = true'
    
    if select_mod in folder_fake_gpu:
       folder_gpu = folder_fake_gpu[select_mod]  
       
    edit_fake_gpu_list = ['0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss']
    
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
        
    edit_fakegpu_list = ['0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss']
    
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
        print(e)

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

list_ue = {
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
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

list_nvapi = {
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
    }
def edit_nvapi():
    global list_nvapi
    
    key_nv = 'compatibility'
    nvapi_folder = None
    
    if select_mod in list_nvapi:
        nvapi_folder = list_nvapi[select_mod]
    else:
        messagebox.showwarning('Error','Please select a mod version starting from 0.10.2h.')
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

list_macos = {
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\enable_fake_gpu\\fsr2fsr3.config.toml',
    'Uniscaler':'mods\\Temp\\Uniscaler\\enable_fake_gpu\\uniscaler.config.toml',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
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

replace_flag = False 
def rep_flag():
    global replace_flag
    replace_flag = True

def replace_clean_file():
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
            'The Callisto Protocol FSR3':'mods\\FSR3_Callisto\\enable_fake_gpu'
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
            'The Callisto Protocol FSR3':'mods\\Temp\\FSR3_Callisto\\enable_fake_gpu'
        }

        if select_mod in clean_file and select_mod in clean_file_rep:
            clean_file_copy = clean_file[select_mod]
            rep_clean_file = clean_file_rep[select_mod]

        if os.path.isdir(clean_file_copy ) and os.path.isdir(rep_clean_file):
            for file_clean in os.listdir(clean_file_copy):
                c_file = os.path.join(clean_file_copy,file_clean)
                if os.path.isfile(c_file):
                    shutil.copy2(c_file,rep_clean_file)

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
    global replace_flag,screen_toml
    if open_editor_var.get() == 1 and select_mod != None:
        screen_editor()
    elif open_editor_var.get() == 0:
        screen_toml.destroy()
        replace_flag = False
    else:
        messagebox.showinfo('Select Mod','Please select the mod version to open TOML EDITOR')
        open_editor_cbox.deselect()

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
    'The Callisto Protocol FSR3':'mods\\Temp\\FSR3_Callisto\\enable_fake_gpu\\fsr2fsr3.config.toml'
    }
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
    mod_list_sharp = ['0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss']
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
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
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
sharpness_label.place(x=420,y=73)
sharpness_var = tk.IntVar()
sharpness_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=sharpness_var,command=cbox_sharpness)
sharpness_cbox.place(x=560,y=76)
sharpness_value_label = tk.Label(screen,text='Sharpness Value:',font=font_select,bg='black',fg='#C0C0C0')
sharpness_value_label.place(x=420,y=103)
sharpness_value_canvas = tk.Canvas(screen,width=80,height=19,bg='#C0C0C0',highlightthickness=0)
sharpness_value_canvas.place(x=565,y=108)
sharpness_value_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
sharpness_value_label_up.place(x=545,y=103)
sharpness_value_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
sharpness_value_label_down.place(x=648,y=95)

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
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\enable_fake_gpu\uniscaler.config.toml'
    }
    
    if select_mod in mod_folder_list:
        mod_operates_folder = mod_folder_list[select_mod]
        key_mod_operates = 'general'
        
    if select_mod == '0.9.0' and select_mod_operates == 'Enable Upscaling Only':
        print(select_mod_operates)
        options_mod_op = 'enable_upscaling_only'
        select_mod_op_options = True
    elif select_mod == '0.9.0' and select_mod_operates == 'Default':
        options_mod_op = 'enable_upscaling_only'
        select_mod_op_options = False
    elif select_mod != '0.9.0' and select_mod != 'Uniscaler' and select_mod != 'Uniscaler + Xess + Dlss':
        options_mod_op = 'mode'
        select_mod_op_options = str(select_mod_operates).lower().replace(" ", '_')
    elif select_mod == 'Uniscaler' or select_mod == 'Uniscaler + Xess + Dlss':
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

def open_explorer(event=None): #Function to select the game folder and create the selected path text on the Canvas
    global select_folder
    select_folder = filedialog.askdirectory()
    game_folder_canvas.delete('text')
    game_folder_canvas.create_text(2,8, anchor='w',text=select_folder,fill='black',tags='text') 

def auto_search(path_origin,alt_path_origin,exe_name,game_select): #auto search for the exe path
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
        
        tlou_name = 'tlou-i.exe'
        game_select_tlou = select_option
        
        if select_option is not None:
        
            steam_path = messagebox.askyesno('Steam','Is your game on Steam?')
            if not steam_path:
                epic_path = messagebox.askyesno('Epic Games','Is your games on Epic Games?')
            
                if steam_path:
                    if select_option == 'The Last of Us Part I':
                        auto_search(path_steam,alt_path_steam,tlou_name,game_select_tlou)
                    else:
                        auto_search(path_steam,alt_path_steam,exe_name,game_select)
                elif epic_path:
                    if select_option == 'The Last of Us':
                        auto_search(path_epic,alt_path_epic,tlou_name,game_select_tlou)
                    else:
                        auto_search(path_epic,alt_path_epic,exe_name,game_select)
                else:
                    messagebox.showinfo('Select Folder','Please select the path manually')
                    return
        else:            
            messagebox.showinfo('Error','Please select a game') 
            return
               
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
        'Uniscaler':'mods\\ASI\\ASI_uniscaler',
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
    
    '0.9.0':['mods\FSR2FSR3_0.9.0\Generic FSR\FSR2FSR3_210',
                'mods\FSR2FSR3_0.9.0\FSR2FSR3_COMMON'],
    
    '0.10.0':['mods\FSR2FSR3_0.10.0\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.0\FSR2FSR3_COMMON'],
    
    '0.10.1':['mods\FSR2FSR3_0.10.1\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.1\FSR2FSR3_COMMON'],
    
    '0.10.1h1':['mods\FSR2FSR3_0.10.1h1\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.1h1\FSR2FSR3_COMMON'],
    
    '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON'],
    
    '0.10.3':['mods\FSR2FSR3_0.10.3\Generic FSR\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON'],
    
    '0.10.4':['mods\FSR2FSR3_0.10.4\FSR2FSR3_220\FSR2FSR3_220',
                'mods\FSR2FSR3_0.10.4\FSR2FSR3_220\FSR2FSR3_COMMON'],
    
    'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
    'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod'
    }

def fsr_2_2():
    global origins_2_2_folder
    
    if select_mod in origins_2_2_folder:
        origins_2_2 = origins_2_2_folder[select_mod]
    else:
        return
    
    if select_mod !='Uniscaler' and select_mod != 'Uniscaler + Xess + Dlss':
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
            print(e)
    else:
        try:
            shutil.copytree(origins_2_2, select_folder, dirs_exist_ok=True)
        except shutil.Error as e:
            print(e)
    
    if select_mod in asi_global and(select_asi  in asi_global[select_mod] or option_asi in asi_global[select_mod]):
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
            print("Files from directory", origins_2_2_f, "were copied.")
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
        
        '0.10.1h1':['mods\FSR2FSR3_0.10.1h1\Generic FSR\FSR2FSR3_210',
                    'mods\FSR2FSR3_0.10.1h1\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\Generic FSR\FSR2FSR3_210',
                    'mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\FSR2FSR3_0.10.3\Generic FSR\FSR2FSR3_210',
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\FSR2FSR3_0.10.4\FSR2FSR3_210\FSR2FSR3_210',
                  'mods\FSR2FSR3_0.10.4\FSR2FSR3_210\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod'
    }
    
    if select_mod in origins_2_1_folder:
        origins_2_1 = origins_2_1_folder[select_mod]
    
    if select_mod != 'Uniscaler' and select_mod != 'Uniscaler + Xess + Dlss':
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
        
        '0.10.1h1':['mods\FSR2FSR3_0.10.1h1\Generic FSR\FSR2FSR3_200',
                    'mods\FSR2FSR3_0.10.1h1\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\Generic FSR\FSR2FSR3_200',
                    'mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\FSR2FSR3_0.10.3\Generic FSR\FSR2FSR3_200',
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\FSR2FSR3_0.10.4\FSR2FSR3_200\FSR2FSR3_200',
                  'mods\FSR2FSR3_0.10.4\FSR2FSR3_200\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod'
    }
    
    if select_mod in origins_2_0_folder:
        origins_2_0 = origins_2_0_folder[select_mod]
     
    if select_mod != 'Uniscaler' and select_mod != 'Uniscaler + Xess + Dlss':   
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
            print("Files from directory", origins_2_0_f, "were copied.")
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
        
        '0.10.1h1':['mods\FSR2FSR3_0.10.1h1\Generic FSR\FSR2FSR3_SDK',
                    'mods\FSR2FSR3_0.10.1h1\FSR2FSR3_COMMON'],
        
        '0.10.2h1':['mods\FSR2FSR3_0.10.2h1\Generic FSR\FSR2FSR3_SDK',
                    'mods\FSR2FSR3_0.10.2h1\FSR2FSR3_COMMON'],
        
        '0.10.3':['mods\FSR2FSR3_0.10.3\Generic FSR\FSR2FSR3_SDK',
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON'],
        
        '0.10.4':['mods\FSR2FSR3_0.10.4\FSR2FSR3_SDK\FSR2FSR3_SDK',
                  'mods\FSR2FSR3_0.10.4\FSR2FSR3_SDK\FSR2FSR3_COMMON'],
        
        'Uniscaler':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
        'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod'
    }
    
    if select_mod in origins_sdk_folder:
        origins_sdk = origins_sdk_folder[select_mod]
    
    if select_mod != 'Uniscaler':
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
        'Uniscaler + Xess + Dlss':r'mods\FSR2FSR3_Uniscaler_Xess_Dlss\Uniscaler_mod\Uniscaler_mod'
    }

def xess_fsr():
    path_xess = r'mods\FSR2FSR3_Uniscaler\CyberXeSS'
    
    name_libxess = os.path.join(select_folder,'libxess.dll')
    name_libxess_old = os.path.join(select_folder,'libxess.txt')
    rename_libxess = 'libxess.txt'
    
    put_xess = messagebox.askyesno('Install Xess 1.3','Would you like to enable XESS 1.3?')
    if put_xess and os.path.exists(name_libxess) and not os.path.exists(name_libxess_old):
        os.rename(name_libxess,os.path.join(select_folder,rename_libxess))
    
    if put_xess and select_nvngx != 'XESS 1.3' or put_xess and not nvngx_contr :
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

def fsr_rdr2():
    global select_fsr,select_mod,origins_rdr2_folder
    
    if select_mod in origins_rdr2_folder:
        origins_rdr2 = origins_rdr2_folder[select_mod]
    
    if select_mod != 'Uniscaler':
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
               "RDR2 Mix 2":'mods\\RDR2_FSR3_mix'}
def rdr2_build2():
    global rdr2_folder
    
    if select_mod in rdr2_folder:
        origins_rdr2 = rdr2_folder[select_mod]
    
    if select_mod == 'RDR2 Build_2':
        shutil.copytree(origins_rdr2,select_folder,dirs_exist_ok=True)
    elif select_mod == 'RDR2 Build_4':
        shutil.copytree(origins_rdr2,select_folder,dirs_exist_ok=True)
    elif select_mod == 'RDR2 Mix':
        shutil.copytree(origins_rdr2,select_folder,dirs_exist_ok=True)
    elif select_mod == 'RDR2 Mix 2':
        ignore_files = ('reshade-shaders','ReShade.ini')

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

dd2_folder = {'Dinput8':'mods\\FSR3_DD2\\dinput',
              'Uniscaler_DD2':'mods\\FSR2FSR3_Uniscaler\\Uniscaler_4\\Uniscaler mod',
              'Uniscaler + Xess + Dlss DD2':'mods\\FSR2FSR3_Uniscaler_Xess_Dlss\\Uniscaler_mod\\Uniscaler_mod'
}
def dd2_fsr():
    global dd2_folder,var_d_put
    
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
              'Elden_Ring_FSR3':'mods\Elden_Ring_FSR3\EldenRing_FSR3'}
def elden_fsr3():
    global er_origins
    
    if select_mod in er_origins:
        elden_folder = er_origins[select_mod]
    
    if select_mod in er_origins:
        shutil.copytree(elden_folder,select_folder, dirs_exist_ok=True)
        
    if os.path.exists(os.path.join(select_folder, 'toggle_anti_cheat.exe')):
        run_dis_anti_c()

def run_dis_anti_c():
    var_anti_c = messagebox.askyesno('Disable Anti Cheat','Do you want to disable the anticheat? (only for Steam users)')
    
    del_anti_c_path = os.path.join(select_folder,'toggle_anti_cheat.exe')
    if var_anti_c:
        subprocess.call(del_anti_c_path)

bdg_origins = {'Baldur\'s Gate 3 FSR3':'mods\FSR3_BDG'}
def bdg_fsr3():
    
    if select_mod in bdg_origins:
        bdg_origin = bdg_origins[select_mod]
    
    if select_mod in bdg_origins:
        shutil.copytree(bdg_origin,select_folder,dirs_exist_ok=True)

callisto_origins = {'The Callisto Protocol FSR3':'mods\\FSR3_Callisto\\FSR_Callisto'}
def callisto_fsr():
    if select_mod in callisto_origins:
        callisto_origin  = callisto_origins[select_mod]
    
    if select_mod in callisto_origins:
        shutil.copytree(callisto_origin,select_folder,dirs_exist_ok=True)

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
      
install_contr = None
fsr_2_2_opt = ['Alan Wake 2','A Plague Tale Requiem','Assassin\'s Creed Mirage',
               'Atomic Heart','Banishers: Ghosts of New Eden','Blacktail','Bright Memory: Infinite','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Death Stranding Director\'s Cut','Dying Light 2','F1 2022','F1 2023','FIST: Forged In Shadow Torch',
               'Fort Solis','Hogwarts Legacy','Horizon Forbidden West','Kena: Bridge of Spirits','Lies of P','Lords of The Fallen','Manor Lords','Metro Exodus Enhanced Edition','Outpost: Infinity Siege',
               'Palworld','Ready or Not','Remnant II','RoboCop: Rogue City','Satisfactory','Sackboy: A Big Adventure','Smalland','Shadow Warrior 3','Starfield','STAR WARS Jedi: Survivor','Steelrising','TEKKEN 8','The Chant','The Medium','Wanted: Dead']

fsr_2_1_opt=['Chernobylite','Dead Space (2023)','Hellblade: Senua\'s Sacrifice','Hitman 3','Horizon Zero Dawn','Judgment','Martha Is Dead','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man: Miles Morales','Returnal','Uncharted: Legacy of Thieves Collection']

fsr_2_0_opt = ['Alone in the Dark','Deathloop','Dying Light 2','Brothers: A Tale of Two Sons Remake','Ghostrunner 2','High On Life','Layers of Fear','Marvel\'s Guardians of the Galaxy','Nightingale','Rise of The Tomb Raider','Shadow of the Tomb Raider','The Outer Worlds: Spacer\'s Choice Edition','The Witcher 3']

fsr_sdk_opt = ['Ratchet & Clank-Rift Apart','Pacific Drive']

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
    "ASI Loader for RDR2: Copies the Red Dead Redemption ASI file from the selected mod.")
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
    sharp_over_label_guide.place(x=420,y=98)

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

dis_con_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
dis_con_label_guide.place_forget()

def guide_dis_con_op (event=None):
    dis_con_label_guide.config(text="Disable the CMD that autostarts on game boot, default = false")
    dis_con_label_guide.place(x=0,y=395)
    
def close_dis_conguide(event=None):
    dis_con_label_guide.config(text="")
    dis_con_label_guide.place_forget()

debug_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
debug_label_guide.place_forget()

def guide_debug_op (event=None):
    debug_label_guide.config(text="For enabling FSR3FG debug overlay, default = false")
    debug_label_guide.place(x=122,y=362)
    
def close_debugguide(event=None):
    debug_label_guide.config(text="")
    debug_label_guide.place_forget()

debug_view_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
debug_view_label_guide.place_forget()

def guide_debug_view_op (event=None):
    debug_view_label_guide.config(text="For enabling FSR3FG debug overlay, default = false")
    debug_view_label_guide.place(x=0,y=362)
    
def close_debug_viewguide(event=None):
    debug_view_label_guide.config(text="")
    debug_view_label_guide.place_forget()

en_sig_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
en_sig_label_guide.place_forget()

def guide_en_sig (event=None):
    en_sig_label_guide.config(text="Enable Signature Override can help some games to work, it is also recommended to activate in older versions of the mod")
    en_sig_label_guide.place(x=0,y=332)
    
def close_en_sigguide(event=None):
    en_sig_label_guide.config(text="")
    en_sig_label_guide.place_forget()

lfz_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
lfz_label_guide.place_forget()

def guide_lfz(event=None):
    lfz_label_guide.config(text="Files that can help the mod to work in some specific games.\n(We recommend copying these files only if the default mod doesn't work.")
    lfz_label_guide.place(x=245,y=360)
     
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

addon_dx11_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
addon_dx11_guide.place_forget()

def guide_addon_dx11(event=None):
    addon_dx11_guide.config(text="Select upscaler for Dx11 games")
    addon_dx11_guide.place(x=420,y=510)

def close_addon_dx11(event=None):
    addon_dx11_guide.config(text="")
    addon_dx11_guide.place_forget()

addon_dx12_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
addon_dx12_guide.place_forget()

def guide_addon_dx12(event=None):
    addon_dx12_guide.config(text="Select upscaler for Dx12 games")
    addon_dx12_guide.place(x=420,y=540)

def close_addon_dx12(event=None):
    addon_dx12_guide.config(text="")
    addon_dx12_guide.place_forget()

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
    global install_contr,var_d_put,continue_install
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
        elif select_mod in dd2_folder:
            dd2_fsr()
            if var_d_put == False:
                return
        elif select_mod in er_origins:
            elden_fsr3()
        elif select_mod in bdg_origins:
            bdg_fsr3()
        elif select_mod in callisto_origins:
            callisto_fsr()
        elif select_mod == 'Fallout 4 FSR3':
            fallout_fsr()
        elif select_mod  == 'Forza Horizon 5 FSR3':
            fh_fsr3()
        elif select_mod == 'Uniscaler Tlou':
            tlou_fsr()
        elif select_option == 'Icarus':
            icarus_fsr3()

        if select_mod == 'Palworld Build03':
            pw_fsr3()
        if select_option== 'Chernobylite':
            chernobylite_short_cut()
        if select_mod == 'Unlock Fps Tekken 8':
            ulck_fps_tekken()
        if select_mod == 'Uniscaler' and select_mod_operates != None and select_nvngx != 'XESS 1.3' or select_mod == 'Uniscaler' and select_mod_operates != None and not nvngx_contr:
            xess_fsr()
        if select_mod == 'Uniscaler' and select_mod_operates != None and select_nvngx != 'DLSS 3.7.0' or select_mod == 'Uniscaler' and select_mod_operates != None and not nvngx_contr:
            dlss_fsr()
        if select_addon_mods == 'OptiScaler':
            update_optiscaler_ini()
        if  nvngx_contr:
            copy_nvngx()
        if dxgi_contr:
            copy_dxgi()
        if addon_contr:
            addon_mods()
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
        
        fps_limit()
        replace_clean_file()

        install_label.configure(fg='black')
        screen.after(100,install_false)
        
    except Exception as e: 
        messagebox.showwarning('Error',f'Installation error')
        print(e)
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
        addon_ups_dx11_label.place(x=420,y=487)
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


def close_all_listbox(event):
    global listbox_visible, fsr_visible
    
    if event.widget != mod_version_listbox:
        mod_version_listbox.pack_forget()
    
    x = event.x
    y = event.y 
    
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
    'A Plague Tale Requiem':'2.2',
    'Alan Wake 2':'2.2',
    'Alone in the Dark':'2.0',
    'Assassin\'s Creed Mirage':'2.2',
    'Atomic Heart':'2.2',
    'Baldur\'s Gate 3':'PD',
    'Banishers: Ghosts of New Eden':'2.2',
    'Blacktail':'2.2',
    'Bright Memory: Infinite':'2.2',
    'Brothers: A Tale of Two Sons Remake':'2.0',
    'Chernobylite':'2.1',
    'Cyberpunk 2077':'2.2',
    'Dakar Desert Rally':'2.2',
    'Deathloop':'2.0',
    'Dead Island 2':'2.2',
    'Death Stranding Director\'s Cut':'2.2',
    'Dead Space (2023)':'2.1',
    'Dragons Dogma 2':'US',
    'Dying Light 2':'2.0',
    'Elden Ring':'PD',
    'Fallout 4':'PD',
    'F1 2022':'2.2',
    'F1 2023':'2.2',
    'FIST: Forged In Shadow Torch':'2.2',
    'Fort Solis':'2.2',
    'Forza Horizon 5':'FH',
    'Ghostrunner 2':'2.0',
    'Martha Is Dead':'2.1',
    'Marvel\'s Guardians of the Galaxy':'2.0',
    'Hellblade: Senua\'s Sacrifice':'2.1',
    'High On Life':'2.0',
    'Hitman 3':'2.1',
    'Hogwarts Legacy':'2.2',
    'Icarus':'ICR',
    'Judgment':'2.1',
    'Kena: Bridge of Spirits':'2.2',
    'Layers of Fear':'2.0',
    'Lies of P':'2.2',
    'Lords of the Fallen':'2.2',
    'Manor Lords':'2.2',
    'Marvel\'s Spider-Man Remastered':'2.1',
    'Marvel\'s Spider-Man: Miles Morales':'2.1',
    'Metro Exodus Enhanced Edition': '2.2',
    'Nightingale':'2.0',
    'Outpost: Infinity Siege':'2.2',
    'Pacific Drive':'SDK',
    'Palworld':'2.2',
    'Ratchet & Clank-Rift Apart':'SDK',
    'Red Dead Redemption 2':'RDR2',
    'Ready or Not':'2.2',
    'Remnant II':'2.2',
    'Returnal':'2.1',
    'Rise of The Tomb Raider':'2.0',
    'RoboCop: Rogue City':'2.2',
    'Satisfactory':'2.2',
    'Sackboy: A Big Adventure':'2.2',
    'Shadow of the Tomb Raider':'2.0',
    'Shadow Warrior 3':'2.2',
    'Smalland':'2.2',
    'Starfield':'2.2',
    'STAR WARS Jedi: Survivor':'2.2',
    'Steelrising':'2.2',
    'TEKKEN 8':'2.2',
    'The Callisto Protocol':'2.1',
    'The Chant':'2.2',
    'The Last of Us Part I':'US',
    'The Medium':'2.2',
    'The Thaumaturge':'2.2',
    'The Outer Worlds: Spacer\'s Choice Edition':'2.0',
    'The Witcher 3':'2.0',
    'Uncharted: Legacy of Thieves Collection':'2.1',
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
        mod_version_listbox.insert(tk.END,'RDR2 Build_2','RDR2 Build_4','RDR2 Mix','RDR2 Mix 2','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss')
    
    elif select_option == 'Dragons Dogma 2':
        mod_text()
        mod_version_listbox.insert(tk.END,'Dinput8','Uniscaler_DD2','Uniscaler + Xess + Dlss DD2')
    
    elif select_option == 'Elden Ring':
        mod_text()
        mod_version_listbox.insert(tk.END,'Disable_Anti-Cheat','Elden_Ring_FSR3')
    
    elif select_option == 'Baldur\'s Gate 3':
        mod_text()
        mod_version_listbox.insert(tk.END,'Baldur\'s Gate 3 FSR3')
    
    elif select_option == 'The Callisto Protocol':
        mod_text()
        mod_version_listbox.insert(tk.END,'The Callisto Protocol FSR3')  
    
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
        mod_version_listbox.insert(tk.END,'Palworld Build03','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
    elif select_option == 'TEKKEN 8':
        mod_text()
        mod_version_listbox.insert(tk.END,'Unlock Fps Tekken 8','0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
    elif select_option == 'Icarus':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Icarus FSR3 AMD/GTX','Icarus FSR3 RTX')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    elif select_option == 'The Last of Us':
        mod_text() 
        mod_version_listbox.insert(tk.END,'Uniscaler Tlou')
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
    else:
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(30,0))
        for mod_op in mod_options:
            mod_version_listbox.insert(tk.END,mod_op)    
    fsr_listbox_view()
    
options = ['Select FSR version','Alan Wake 2','Alone in the Dark','A Plague Tale Requiem','Assassin\'s Creed Mirage','Atomic Heart','Baldur\'s Gate 3','Banishers: Ghosts of New Eden','Blacktail','Bright Memory: Infinite','Brothers: A Tale of Two Sons Remake','Chernobylite','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Deathloop','Death Stranding Director\'s Cut','Dead Space (2023)','Dragons Dogma 2','Dying Light 2','Elden Ring','Fallout 4','F1 2022','F1 2023','FIST: Forged In Shadow Torch','Fort Solis',
        'Forza Horizon 5','Ghostrunner 2','Hellblade: Senua\'s Sacrifice','High On Life','Hitman 3','Hogwarts Legacy','Horizon Zero Dawn','Horizon Forbidden West','Icarus','Judgment','Kena: Bridge of Spirits','Layers of Fear','Lies of P','Lords of the Fallen','Manor Lords','Martha Is Dead','Marvel\'s Guardians of the Galaxy','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man: Miles Morales','Metro Exodus Enhanced Edition','Nightingale','Outpost: Infinity Siege','Pacific Drive','Palworld','Ratchet & Clank-Rift Apart',
        'Red Dead Redemption 2','Ready or Not','Remnant II','Returnal','Rise of The Tomb Raider','RoboCop: Rogue City','Satisfactory','Sackboy: A Big Adventure','Shadow Warrior 3','Shadow of the Tomb Raider','Smalland','Starfield','STAR WARS Jedi: Survivor','Steelrising','TEKKEN 8','The Callisto Protocol','The Chant','The Last of Us Part I','The Medium','The Outer Worlds: Spacer\'s Choice Edition','The Witcher 3','Uncharted: Legacy of Thieves Collection','Wanted: Dead']#add options
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
    global select_mod
    index_mod = mod_version_listbox.curselection()
    if index_mod:
        select_mod = mod_version_listbox.get(index_mod)
        mod_version_canvas.delete('text')
        mod_version_canvas.create_text(2,8,anchor='w',text=select_mod,fill='black',tag='text')
    select_mod_op_lock()
    unlock_fps_limit()
    unlock_sharp()
    update_nvngx()
    unlock_uni_custom()
    mod_version_canvas.update()

mod_options = ['0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler','Uniscaler + Xess + Dlss']
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
        
    elif select_mod == 'Uniscaler' or select_mod == 'Uniscaler + Xess + Dlss':
        mod_op_list = ['FSR3','DLSS','XESS']
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
  
def update_nvngx(event=None):
    global select_nvngx,nvngx_op
    index_nvngx_op = nvngx_listbox.curselection()
    
    if select_mod == 'Uniscaler + Xess + Dlss':
        nvngx_op = ['Default', 'NVNGX Version 1']
    else:
        nvngx_op = ['Default', 'NVNGX Version 1', 'XESS 1.3', 'DLSS 3.7.0','DLSS 3.7.0 FG']

    nvngx_listbox.delete(0, tk.END) 
    for nvngx_options in nvngx_op:
        nvngx_listbox.insert(tk.END, nvngx_options)
    
    if index_nvngx_op:
        select_nvngx = nvngx_listbox.get(index_nvngx_op)
        nvngx_canvas.delete('text')   
    nvngx_canvas.delete('text')  
    get_canvas = nvngx_canvas.create_text(2, 8, anchor='w', text=select_nvngx, fill='black', tags='text')

    text_canvas_nvngx = nvngx_canvas.itemcget(get_canvas, "text")
    
    if select_mod == 'Uniscaler + Xess + Dlss' and text_canvas_nvngx == 'XESS 1.3' or select_mod == 'Uniscaler + Xess + Dlss' and text_canvas_nvngx == 'DLSS 3.7.0':
        nvngx_canvas.delete('text')
    
    nvngx_canvas.update()

nvngx_op = ['Default', 'NVNGX Version 1', 'XESS 1.3', 'DLSS 3.7.0','DLSS 3.7.0 FG']
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
        addon_ups_dx11_canvas.config(bg='white')
        addon_ups_dx12_canvas.config(bg='white')
    elif select_addon_mods != 'OptiScaler' or not addon_contr:
        addon_ups_dx11_canvas.config(bg='#C0C0C0')
        addon_ups_dx11_listbox.place_forget() 
        addon_ups_dx12_canvas.config(bg='#C0C0C0')
        addon_ups_dx12_listbox.place_forget()
    addon_mods_canvas.update()

addon_op = ['OptiScaler','Tweak']
for addon_options in addon_op:
    addon_mods_listbox.insert(tk.END,addon_options)

def update_addon_dx11(event=None):
    global select_addon_dx11
    index_addon_dx11 = addon_ups_dx11_listbox.curselection()
    if index_addon_dx11:
        select_addon_dx11 = addon_ups_dx11_listbox.get(index_addon_dx11)
        addon_ups_dx11_canvas.delete('text')
        addon_ups_dx11_canvas.create_text(2,8,anchor='w',text=select_addon_dx11,fill='black',tags='text')
    addon_ups_dx11_canvas.update()

addon_dx11 = ['fsr2.2 DX11','xess DX11','fsr2.2 DX11 - DX12','fsr2.1 DX11']
for addon_dx11_op in addon_dx11:
    addon_ups_dx11_listbox.insert(tk.END,addon_dx11_op)

def update_addon_dx12(event=None):
    global select_addon_dx12
    index_addon_dx12 = addon_ups_dx12_listbox.curselection()
    if index_addon_dx12:
        select_addon_dx12 = addon_ups_dx12_listbox.get(index_addon_dx12)
        addon_ups_dx12_canvas.delete('text')
        addon_ups_dx12_canvas.create_text(2,8,anchor='w',text=select_addon_dx12,fill='black',tags='text')
    addon_ups_dx12_canvas.update()

addon_dx12 = ['xess DX12','fsr2.2 DX12','fsr2.1 DX12']
for addon_dx12_op in addon_dx12:
    addon_ups_dx12_listbox.insert(tk.END,addon_dx12_op)

def update_uni_custom(event=None):
    global select_uni_custom
    index_uni_custom = uni_custom_listbox.curselection()
    if index_uni_custom:
        select_uni_custom = uni_custom_listbox.get(index_uni_custom)
        uni_custom_canvas.delete('text')
        uni_custom_canvas.create_text(2,8,anchor='w',text=select_uni_custom,fill='black',tags='text')
    
    if select_mod == 'Uniscaler' or select_mod == 'Uniscaler + Xess + Dlss':
        uni_custom_canvas.config(bg='white')
        uni_custom_preset()
    elif select_mod != 'Uniscaler' or select_mod != 'Uniscaler + Xess + Dlss' or not uni_custom_contr:
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
addon_ups_dx11_canvas.bind('<Button-1>',addon_dx11_view)
addon_ups_dx11_listbox.bind('<<ListboxSelect>>',update_addon_dx11)
addon_ups_dx12_canvas.bind('<Button-1>',addon_dx12_view)
addon_ups_dx12_listbox.bind('<<ListboxSelect>>',update_addon_dx12)
uni_custom_canvas.bind('<Button-1>',uni_custom_res_view)
uni_custom_listbox.bind('<<ListboxSelect>>',update_uni_custom)
ue_label.bind('<Enter>',guide_ue)
ue_label.bind('<Leave>',close_ueguide)
macos_sup_label.bind('<Enter>',guide_mcos)
macos_sup_label.bind('<Leave>',close_mcosguide)
mod_operates_label.bind('<Enter>',guide_mod_op)
mod_operates_label.bind('<Leave>',close_mod_opguide)
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
addon_ups_dx11_label.bind('<Enter>',guide_addon_dx11)
addon_ups_dx11_label.bind('<Leave>',close_addon_dx11)
addon_ups_dx12_label.bind('<Enter>',guide_addon_dx12)
addon_ups_dx12_label.bind('<Leave>',close_addon_dx12)
fps_user_entry.bind("<Key>", fps_isdigit)
install_label.bind('<Button-1>',install)
install_label.bind('<ButtonRelease-1>', install_false)

exit_label.bind('<Button-1>',exit_screen)

#screen.bind('<Button-1>',close_all_listbox)

screen.mainloop()