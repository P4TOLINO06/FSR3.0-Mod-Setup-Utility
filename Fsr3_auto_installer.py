import tkinter as tk
from PIL import ImageTk, Image
from customtkinter import *
from tkinter.font import Font
from tkinter import Canvas,filedialog,messagebox
import subprocess,os,shutil
from pathlib import Path
import toml
import ctypes, sys
import pyglet
from configobj import ConfigObj
import psutil
import os

def uac():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

unlock_screen = False
def run_as_admin():
    global unlock_screen
    if uac():
        print("0")
        unlock_screen = True
    else:
        unlock_screen = False
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 1)

run_as_admin()

screen = tk.Tk()
screen.title("FSR3.0 Mod Setup Utility - 1.6.2v")
screen.geometry("400x700")
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
x_img = (400 - 180)//2
y_img = (1300 - 250)//2

bg_label = tk.Label(screen,image=img_tk,bg='black')
bg_label.place(x=x_img,y=y_img)

title_page = tk.Label(screen, text="FSR3 Mod", font=("Arial", 10, "bold"), fg="#FFFAFA", bg="black") 
title_page.pack(anchor='w',pady=0)

pyglet.options['win32_gdi_font'] = True
fontpath = Path(__file__).parent / r'Fonts\notably_absent\Notably Absent DEMO.ttf'
pyglet.font.add_file(str(fontpath))
font_select = ('Notably Absent',12)

select_label = tk.Label(screen, text="Game select:",font=font_select,bg='black',fg='#C0C0C0')
select_label.pack(anchor='w',pady=10)

fsr_label = tk.Label(screen,text='FSR:',font=font_select,bg='black',fg='#C0C0C0')
fsr_label.place(x=300,y=33)
canvas_options = Canvas(screen,width=200,height=15,bg='white')
canvas_options.place(x=90,y=37)

exit_label = tk.Label(screen,text='Exit',font=font_select,bg='black',fg='#E6E6FA')
exit_label.place(x=355,y=658)

install_label = tk.Label(screen,text='Install',font=font_select,bg='black',fg='#E6E6FA')
install_label.place(x=295,y=658)

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
    
    for disk_name in user_disk_part:
        default_path = os.path.join(disk_name, r'Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay')
        if os.path.exists(default_path):
            for root, dirs, files in os.walk(default_path):
                if exe_name in files:
                    path_over = os.path.join(root)
                    break
            if path_over:
                break
        
        alt_path = os.path.join(disk_name, r'Epic Games\Launcher\Portal\Extras\Overlay')
        if os.path.exists(alt_path):
            for root, dirs, files in os.walk(alt_path):
                if exe_name in files:
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
    epic_label_guide.place(x=0,y=620)
    epic_label_guide.lift()

def close_guide_epic(event=None):
    epic_label_guide.place_forget()

epic_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
epic_label_guide.place_forget()

epic_over_label = tk.Label(screen,text='Epic Games Overlay:',font=font_select,bg='black',fg='#C0C0C0')
epic_over_label.place(x=0,y=595)

epic_over_canvas = tk.Canvas(screen,width=162,height=19,bg='white',highlightthickness=0)
epic_over_canvas.place(x=140,y=599)

epic_over_browser_canvas = tk.Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
epic_over_browser_canvas.create_text(0,8,anchor='w',font=(font_select,9,'bold'),text='Browser',fill='black')
epic_over_browser_canvas.place(x=330,y=599)

epic_over_marc_label = tk.Label(screen,text='–',font=font_select,bg='black',fg='#C0C0C0')
epic_over_marc_label.place(x=308,y=593)

epic_over_disable_label = tk.Label(screen,text='Disable',font=font_select,bg='black',fg='#E6E6FA')
epic_over_disable_label.place(x=330,y=625)

epic_over_enable_label = tk.Label(screen,text='Enable',font=font_select,bg='black',fg='#E6E6FA')
epic_over_enable_label.place(x=270,y=625)

epic_over_auto_label = tk.Label(screen,text='Auto Search',font=font_select,bg='black',fg='#E6E6FA')
epic_over_auto_label.place(x=175,y=625)

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
fsr_guide_label.place(x=200,y=566)
fsr_guide_var = tk.IntVar()
fsr_guide_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=fsr_guide_var,command=fsr_guide)
fsr_guide_cbox.place(x=275,y=568)

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
    
    s_games_op = ['Alone in the Dark','Baldur\'s Gate 3','Bright Memory: Infinite','Dead Space Remake','Deathloop','Dragons Dogma 2','Dying Light 2','Elden Ring','Fallout 4','F1 2022','F1 2023','Ghostrunner 2','Hellblade: Senua\'s Sacrifice',
                'Hogwarts legacy','Horizon Forbidden West','Kena: Bridge of Spirits','Lies of P','Martha Is Dead','Marvel\'s Guardians of the Galaxy','Rise of The Tomb Raider','Ready or Not','Red Dead Redemption 2','Returnal',
                'Sackboy: A Big Adventure','Shadow of the Tomb Raider','Star Wars: Jedi Survivor','Steelrising','The Callisto Protocol',"The Outer Worlds: Spacer's Choice Edition",'The Thaumaturge','Uniscaler','XESS/DLSS']
    for select_games_op in s_games_op:  
        select_game_listbox.insert(tk.END,select_games_op)
    
    select_game_listbox.bind('<<ListboxSelect>>',update_select_game)
    select_game_canvas.bind('<Button-1>',view_listbox_s_games)
    
    select_game_canvas.update()

s_games_listbox_view = False
def view_listbox_s_games(event=None):
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
'Alone in the Dark':(
"1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n"
"2 - Enable the 'Enable Signature Override' checkbox.\n"
"3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n"
"4 - Set FSR in the game settings.\n"
"5 - If the mod doesn't work, select one of the nvngx.dll\noptions."
),

'Baldur\'s Gate 3': (
'1 - Start the game in DX11 and select Borderless.\n'
'2 - Choose DLSS or DLAA.\n'
'3 - Press the END key to enter the mod menu, check\nthe Frame Generation box to activate the mod; you can also\nadjust the Upscaler. (To activate Frame Generation, simply\npress the * key; you can also change the key in the mod\nmenu.)\n'  
),

'Bright Memory: Infinite':(
  '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n '  
  '2 -  To make the mod work, run it in DX12. To run it in DX12, right-click the game\'s\nexe and create a shortcut, then right-click the shortcut again,\ngo to \"Properties,\" and at the end of \"Target\" (outside the\nquotes), add -dx12 or go to your Steam library, select the\ngame, go to Settings > Properties > Startup options, and enter -dx12.'
),

'Dead Space Remake':(
"1 - Select a version of the mod of your choice (versions\nfrom 0.9.0 onwards \nare recommended to fix UI flickering).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the\nmod doesn't work.\n"
"3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n"
"4 - If the mod doesn't work, select one of the nvngx.dll options."   
),

'Deathloop':(
  '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n' 
  '2 - Activate Fake Nvidia Gpu and Nvapi Results (Only for AMD and GTX) ' 
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
"1 - Select a version of the mod of your choice (versions from\n0.7.6 onwards are recommended to fix UI flickering).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the\nmod doesn't work.\n"
"3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n"  
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

'F1 2022' : (
'1 - Choose a version of the mod you prefer (version 0.10.4 is\nrecommended).\n'
'2 - Select "Default" in Nvngx and check the box "Enable\nSignature Override.\n'
'3 - Check the box "Fake Nvidia GPU" (AMD Only).\n'
'4 - Within the game, under AntiAliasing, select DLSS or FSR.\n'
'• To fix the HUD flickering, select DLSS in AntiAliasing before\nstarting the game. While playing, switch to TAA+FSR or TAA\nonly.'     
),

'F1 2023':(
'1 - Choose a version of the mod you prefer (version 0.10.4 is\nrecommended).\n'
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

'Ghostrunner 2': (
    '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended)\n' 
    '2 - To make the mod work, run it in DX12. To run it in DX12, right-click\nthe game exe and create a shortcut, then right-click the shortcut\nagain, go to \"Properties,\" and at the end of \"Target\" (outside the\nquotes), add -dx12 or go to your Steam library, select the game, go to\nSettings > Properties > Startup options, and enter -dx12.\n'
    '3 - Activate Fake Nvidia Gpu (AMD only)\n'
    '4 - Inside the game, set the frame limit to unlimited, activate DLSS first\n(disable other upscalers before) and then activate frame generation\n'
    '• To fix the flickering of the HUD, activate and deactivate frame\ngeneration again (no need to apply settings).'
),

'Hellblade: Senua\'s Sacrifice':(
    '1 - Select a version of the mod of your choice (version 0.10.4\nis recommended).\n'
    '2 - Select Fake Nvidia Gpu and UE Compatibility (AMD only),\nselect Fake Nvidia Gpu and Nvapi Results (GTX only).'
),

'Hogwarts legacy':(
"1 - Select a version of the mod of your choice (versions from 0.9.0\nonwards are recommended to fix UI flickering).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the mod\ndoesn't work.\n"
"3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n"
"4 - Select an option nvngx.dll."
),

'Horizon Forbidden West':(
'1 - Turn off MSI Afterburner/Rivatuner or any other FPS monitor to\navoid crashes.\n'
'2 - If the game still crashes, select \'Nvngx: Default\' and enable\n\'Enable Signature Override\'\n'
'3 - Turn Dynamic Resolution Scaling Off if you still have the black box\nsquare on-screen\n'
'4 - If you experience sudden FPS drops during cutscenes, delete\ndstorage.dll and dstoragecore.dll (A function to delete these 2 files\nwill be implemented soon)\n'
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

'Returnal':(
"1 - Choose a version of the mod you prefer (version 0.10.3\nis recommended).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the\nmod doesn't work.\n"
"3 - Select an option nvngx.dll."
),

'Star Wars: Jedi Survivor':(
"1 - Choose a version of the mod you prefer (Recommended\nversion 0.10.2 or higher).\n"
"2 - Enable the 'Enable Signature Override' checkbox if the\nmod doesn't work.\n"
"3 - Select an option nvngx.dll."
),

'Sackboy: A Big Adventure':(
'1 - Select a version of the mod of your choice (version 0.10.3\nis recommended).\n'
'2 - Select the game folder that has the ending\n"\GingerBread\Binaries\Win64".\n'
'3 - Enable Fake Nvidia GPU (Only for AMD GPUs).\n'
'4 - In "Mod Operates", select "Replace Dlss FG".\n'
'5 - Select an option nvngx.dll.\n'
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

'The Callisto Protocol':(
  '1 - Select The Callisto Protocol Fsr 3 in Mod Version and\ncheck the Fake Nvidia GPU box and install.\n'
'2 - To fix the HUD flickering: within the game, select fsr2,\nAnti-Aliasing to TemporalAA, and turn off the film grain, play\nfor a few seconds, return to the menu, and switch fsr2 to\nTemporal.'  
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
    else:
        screen_guide.geometry('520x260')
    
    if guide_label is None:
        guide_label = tk.Label(screen_guide, text="", font=('Helvetica', 10), bg='black', fg='#F0FFF0', justify='left')
        guide_label.place(x=165, y=28) 
    
    guide_label.config(text=guide_text)
    
def exit_fsr_guide(event=None):
    global screen_guide,guide_label
    
    if screen_guide:
        screen_guide.destroy()
        fsr_guide_cbox.deselect()
        screen_guide = None
        guide_label = None

def guide_fsr_guide(event=None):
    guide_fsr_label.config(text='Installation guide for specific games. To open the guide, simply click on the checkbox')
    guide_fsr_label.place(x=200,y=590)

def close_guide_fsr(event=None):
    guide_fsr_label.place_forget()
    
guide_fsr_label = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
guide_fsr_label.place_forget()

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
var_auto.place(x=273,y=345)
var_auto_expo_var = tk.IntVar()
var_expo_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=var_auto_expo_var,command=cbox_var_auto_expo)
var_expo_cbox.place(x=377,y=348)

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
var_frame_gen_label.place(x=273,y=310)
var_frame_gen_var = tk.IntVar()
var_frame_gen_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=var_frame_gen_var,command=cbox_var_frame_gen)
var_frame_gen_cbox.place(x=375,y=313)

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
fps_user_label.place(x=273,y=276)
fps_user_entry =  tk.Entry(screen,width=5,bg='#C0C0C0',state= 'readonly',borderwidth=0)
fps_user_entry.place(x=350,y=280)
fps_user_entry.lift()

def cbox_del_dxgi(event=None):
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
del_dxgi_label.place(x=0,y=660)
del_dxgi_var = IntVar()
del_dxgi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=del_dxgi_var,command=cbox_del_dxgi)
del_dxgi_cbox.place(x=112,y=662) 
   
def cbox_cleanup(event=None):
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
        print(e)
    
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
                   
cleanup_label = tk.Label(screen,text='Cleanup Mod',font=font_select,bg='black',fg='#E6E6FA')
cleanup_label.place(x=0,y=626) 
cleanup_var = IntVar()
cleanup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=cleanup_var,command=cbox_cleanup)
cleanup_cbox.place(x=93,y=629)       

disable_var = None
def cbox_disable_console(event=None):
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
disable_console_label.place(x=0,y=566)
disable_console_var = IntVar()
disable_console_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=disable_console_var,command=cbox_disable_console)
disable_console_cbox.place(x=108,y=569)

lfz_list = {
'0.7.4':'mods\Temp\FSR2FSR3_0.7.4\lfz.sl.dlss',
'0.7.5':'mods\Temp\FSR2FSR3_0.7.5_hotfix\lfz.sl.dlss',
'0.7.6':'mods\Temp\FSR2FSR3_0.7.6\lfz.sl.dlss',
'0.8.0':'mods\Temp\FSR2FSR3_0.8.0\lfz.sl.dlssl',
'0.9.0':'mods\Temp\FSR2FSR3_0.9.0\lfz.sl.dlss',
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
        messagebox.showinfo('Error','Please, select a mod version up to 0.9.0')
        lfz_sl_label_cbox.deselect()
    elif select_folder is None:
        messagebox.showinfo('Select Folder','Please, select a destination folder')

def cbox_lfz_sl(event=None):
    global lfz_list
    if lfz_sl_var.get() == 1: 
        var_mod_lfz()
    
lfz_sl_label = tk.Label(screen,text='Install lfz.sl.dlss',font=font_select,bg='black',fg='#C0C0C0')
lfz_sl_label.place(x=265,y=533)
lfz_sl_var = IntVar()
lfz_sl_label_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=lfz_sl_var,command=cbox_lfz_sl)
lfz_sl_label_cbox.place(x=375,y=535)

var_debug_tear = None
def cbox_debug_tear_lines(event=None):
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
debug_tear_lines_label.place(x=120,y=533)
debug_tear_lines_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_tear_lines_var,command=cbox_debug_tear_lines)
debug_tear_lines_cbox.place(x=235,y=536)

var_deb_view = False
def cbox_debug_view(event=None):
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
debug_view_label.place(x=0,y=533)
debug_view_var = IntVar()
debug_view_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_view_var,command=cbox_debug_view)
debug_view_cbox.place(x=85,y=536)

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
        
def cbox_enable_sigover(event=None):
    if enable_sigover_var.get() == 1:
        enable_over()
    
enable_sigover_label = tk.Label(screen,text='Enable Signature Override',font=font_select,bg='black',fg='#C0C0C0')
enable_sigover_label.place(x=0,y=503)
enable_sigover_var = IntVar()
enable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=enable_sigover_var,command=cbox_enable_sigover)
enable_sigover_cbox.place(x=170,y=506)

def cbox_disable_sigover(event=None):
    if disable_sigover_var.get() == 1:
        disable_over()

disable_sigover_label = tk.Label(screen,text='Disable Signature Override',font=font_select,bg='black',fg='#C0C0C0')
disable_sigover_label.place(x=202,y=503)
disable_sigover_var = IntVar()
disable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=disable_sigover_var,command=cbox_disable_sigover)
disable_sigover_cbox.place(x=375,y=506)

dxgi_contr = False
def cbox_dxgi(event=None):
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
            dxgi_listbox.place(x=285,y=498)
            dxgi_view = True
      
def dxgi_listbox_contr(event=None):
    global dxgi_view,dxgi_contr
    if not dxgi_contr and dxgi_view:
        dxgi_listbox.place_forget()
        dxgi_view = False

copy_all_dxgi = None       
def copy_dxgi():
    global copy_all_dxgi
    dxgi_folders = None
    dxgi_folders = {
    '0.8.0':'mods\Temp\FSR2FSR3_0.8.0\\dxgi',
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\\dxgi',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\\dxgi',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\\dxgi',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\\dxgi',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\\dxgi',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\\dxgi',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\\dxgi',
    'Uniscaler':'mods\\Temp\\Uniscaler\\dxgi',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\dxgi'
    }
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
dxgi_label.place(x=205,y=470)
dxgi_var = IntVar()
dxgi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=dxgi_var,command=cbox_dxgi)
dxgi_cbox.place(x=259,y=472)
dxgi_canvas = tk.Canvas(width=103,height=19,bg='#C0C0C0',highlightthickness=0)
dxgi_canvas.place(x=285,y=475)
dxgi_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)
dxgi_listbox.place(x=285,y=498)
dxgi_listbox.place_forget()

nvngx_contr = False
def cbox_nvngx(event=None):
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
            nvngx_listbox.place(x=90,y=497)
            nvngx_view = True
            
def nvngx_listbox_contr():
    global nvngx_view
    if not nvngx_contr and nvngx_view:
        nvngx_listbox.place_forget()
        nvngx_view = False
    
nvngx_label = tk.Label(screen,text='Nvngx.dll',font=font_select,bg='black',fg='#C0C0C0')
nvngx_label.place(x=0,y=470)
nvngx_var = IntVar()
nvngx_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=nvngx_var,command=cbox_nvngx)
nvngx_cbox.place(x=66,y=472)
nvngx_canvas = tk.Canvas(screen,width=103,height=19,bg='#C0C0C0',highlightthickness=0)
nvngx_canvas.place(x=90,y=475)
nvngx_listbox = tk.Listbox(screen,width=17,height=0,bg='white',highlightthickness=0)
nvngx_listbox.pack(side=tk.RIGHT,expand=True,padx=(0,15),pady=(0,410))
nvngx_listbox.place(x=90,y=497)
nvngx_listbox.place_forget()

def copy_nvngx():
      
    nvngx_folders = None
    nvngx_folders = {
    '0.7.6':'mods\Temp\FSR2FSR3_0.7.6\\nvngx',
    '0.8.0':'mods\Temp\FSR2FSR3_0.8.0\\nvngx',
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\\nvngx',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\\nvngx',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\\nvngx',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\\nvngx',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\\nvngx',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\\nvngx',
    '0.10.4':'mods\Temp\FSR2FSR3_0.10.4\\nvngx',
    'RDR2 Build_2':'mods\Temp\RDR2_FSR3\\nvngx',
    'RDR2 Build_4':'mods\Temp\RDR2_FSR3\\nvngx',
    'Uniscaler':'mods\\Temp\\Uniscaler\\nvngx',
    'Uniscaler + Xess + Dlss':r'mods\Temp\FSR2FSR3_Uniscaler_Xess_Dlss\nvngx'
    }
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

def cbox_custom_fsr(event=None):
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
custom_fsr_label.place(x=0,y=345)
custom_fsr_var = IntVar()
custom_fsr_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=custom_fsr_var,command=cbox_custom_fsr)
custom_fsr_cbox.place(x=230,y=347)

fsr_ultraq_canvas = tk.Canvas(screen,bg='#C0C0C0',width=50,height=19,highlightthickness=0)
fsr_ultraq_canvas.place(x=140,y=380)
fsr_ultraq_label = tk.Label(screen,text='FSR Ultra Quality:',font=font_select,bg='black',fg='#C0C0C0')
fsr_ultraq_label.place(x=0,y=375)
fsr_ultraq_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_ultraq_label_up.place(x=120,y=375)
fsr_ultraq_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
fsr_ultraq_label_down.place(x=193,y=367)

fsr_quality_label = tk.Label(screen,text='FSR Quality:',font=font_select,bg='black',fg='#C0C0C0')
fsr_quality_label.place(x=220,y=375)
fsr_quality_canvas = tk.Canvas(screen,width=50,height=19,bg='#C0C0C0',highlightthickness=0)
fsr_quality_canvas.place(x=325,y=380)
fsr_quality_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_quality_label_up.place(x=305,y=375)
fsr_quality_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
fsr_quality_label_down.place(x=378,y=366)

fsr_balanced_label = tk.Label(screen,text='FSR Balanced:',font=font_select,bg='black',fg='#C0C0C0')
fsr_balanced_label.place(x=0,y=407)
fsr_balanced_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_balanced_label_up.place(x=95,y=407)
fsr_balanced_canvas = tk.Canvas(screen,bg='#C0C0C0',width=50,height=19,highlightthickness=0)
fsr_balanced_canvas.place(x=115,y=412)
fsr_balanced_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg="#B0C4DE")
fsr_balanced_label_down.place(x=169,y=399)

fsr_performance_label = tk.Label(screen,text='FSR Performance:',font=font_select,bg='black',fg='#C0C0C0')
fsr_performance_label.place(x=190,y=407)
fsr_performance_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_performance_label_up.place(x=306,y=407)
fsr_performance_canvas = tk.Canvas(screen,width=50,height=19,bg='#C0C0C0',highlightthickness=0)
fsr_performance_canvas.place(x=325,y=412)
fsr_performance_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
fsr_performance_label_down.place(x=378,y=398)

fsr_ultrap_label = tk.Label(screen,text='FSR Ultra Performance:',font=font_select,bg='black',fg='#C0C0C0')
fsr_ultrap_label.place(x=0,y=439)
fsr_ultrap_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
fsr_ultrap_label_up.place(x=150,y=438)
fsr_ultrap_canvas = tk.Canvas(screen,bg='#C0C0C0',width=50,height=19,highlightthickness=0)
fsr_ultrap_canvas.place(x=170,y=443)
fsr_ultrap_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
fsr_ultrap_label_down.place(x=225,y=430)

native_res_canvas = tk.Canvas(screen,bg='#C0C0C0',width=50,height=19,highlightthickness=0)
native_res_canvas.place(x=325,y=442)
native_res_label = tk.Label(screen,text='Native: ',font=font_select,bg='black',fg='#C0C0C0')
native_res_label.place(x=258,y=438)
native_res_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
native_res_label_up.place(x=307,y=437)
native_res_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
native_res_label_down.place(x=378,y=429)

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
        print('0')
        fakegpu_cbox_var.set == 0
    else:
        fakegpu_cbox_var.set == 1
        default_fake_gpu()
        print('1')

fakegpu_label = tk.Label(screen,text='Fake NVIDIA GPU',font=font_select,bg='black',fg='#C0C0C0')
fakegpu_label.place(x=0,y=185)
fakegpu_cbox_var = tk.IntVar()
fakegpu_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=fakegpu_cbox_var,command=cbox_fakegpu)
fakegpu_cbox.place(x=120,y=187)

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
ue_cbox.place(x=355,y=187)

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
nvapi_cbox.place(x=120,y=217)

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
        print('0')
    else:
        macos_sup_var.set == 1
        default_macos()
        print('1')
macos_sup_label = tk.Label(screen,text='MacOS Crossover Support',font=font_select,bg='black',fg='#C0C0C0')
macos_sup_label.place(x=200,y=215)
macos_sup_var = tk.IntVar()
macos_sup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=macos_sup_var,command=cbox_macos)
macos_sup_cbox.place(x=372,y=217)

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
open_editor_label.place(x=200,y=245)
open_editor_var = tk.IntVar()
open_editor_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=open_editor_var,command=cbox_editor)
open_editor_cbox.place(x=325,y=247)

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
sharpness_label.place(x=0,y=245)
sharpness_var = tk.IntVar()
sharpness_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=sharpness_var,command=cbox_sharpness)
sharpness_cbox.place(x=130,y=247)
sharpness_value_label = tk.Label(screen,text='Sharpness Value:',font=font_select,bg='black',fg='#C0C0C0')
sharpness_value_label.place(x=0,y=277)
sharpness_value_canvas = tk.Canvas(screen,width=80,height=19,bg='#C0C0C0',highlightthickness=0)
sharpness_value_canvas.place(x=140,y=282)
sharpness_value_label_up = tk.Label(screen,text='+',font=(font_select,14),bg='black',fg='#B0C4DE')
sharpness_value_label_up.place(x=120,y=276)
sharpness_value_label_down = tk.Label(screen,text='-',font=(font_select,22),bg='black',fg='#B0C4DE')
sharpness_value_label_down.place(x=225,y=268)

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
mod_operates_label.place(x=0,y=310)
mod_operates_canvas = tk.Canvas(screen,width=150,height=19,bg='#C0C0C0',highlightthickness=0)
mod_operates_canvas.place(x=100,y=314)
mod_operates_listbox = tk.Listbox(screen,bg='white',width=25,height=0,highlightthickness=0)
mod_operates_listbox.place(x=100,y=335)
mod_operates_listbox.place_forget()

optional_mod_op_label = tk.Label(screen,text='optional',font=(font_select,7),bg='black',fg='#696969')
optional_mod_op_label.place(x=0,y=330)

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
            mod_operates_listbox.place(x=100,y=335)
            mod_op_list_visible = True

asi_label = tk.Label(screen,text='ASI Loader:',font=font_select,bg='black',fg='#C0C0C0')
asi_label.place(x=0,y=146)
asi_optional_label = tk.Label(screen,text='optional',font=(font_select, 7),bg='black',fg='#696969')
asi_optional_label.place(x=10,y=166)
asi_canvas = Canvas(screen,width=205,height=19,bg='white',highlightthickness=0)
asi_canvas.place(x=90,y=150)

asi_listbox = tk.Listbox(screen,bg='white',width=34,height=0,highlightthickness=0)
asi_listbox.pack(side=tk.RIGHT,expand=True,padx=(0,15),pady=(0,410))
asi_listbox.pack_forget()

select_asi_label = tk.Label(screen,text='ASI:',font=font_select,bg='black',fg='#C0C0C0')
select_asi_label.place(x=300,y=145)
select_asi_canvas = tk.Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
select_asi_canvas.place(x=335,y=149)

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
        asi_listbox.place(x=90,y=171)
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
            select_asi_listbox.place(x=335,y=170)
            select_asi_visible = True

select_folder_canvas = Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
select_folder_canvas.place(x=335,y=75)
select_folder_canvas.create_text(0,8,anchor='w',font=(font_select,9,'bold'),text='Browser',fill='black')
select_folder_label = tk.Label(screen,text='–',font=font_select,bg='black',fg='#C0C0C0')
select_folder_label.place(x=309,y=70)
select_folder = None

def open_explorer(event=None): #Function to select the game folder and create the selected path text on the Canvas
    global select_folder
    select_folder =filedialog.askdirectory()
    game_folder_canvas.delete('text')
    game_folder_canvas.create_text(2,8, anchor='w',text=select_folder,fill='black',tags='text') 

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

def fsr_2_2():
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
    
    if select_mod in origins_2_2_folder:
        origins_2_2 = origins_2_2_folder[select_mod]
    
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

rdr2_folder = {"RDR2 Build_2":'mods\Red_Dead_Redemption_2_Build02',
               "RDR2 Build_4":'mods\RDR2Upscaler-FSR3Build04'}
def rdr2_build2():
    global rdr2_folder
    
    if select_mod in rdr2_folder:
        origins_rdr2 = rdr2_folder[select_mod]
    
    if select_mod == 'RDR2 Build_2':
        shutil.copytree(origins_rdr2,select_folder,dirs_exist_ok=True)
    elif select_mod == 'RDR2 Build_4':
        shutil.copytree(origins_rdr2,select_folder,dirs_exist_ok=True)

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
    print(var_d_put)
    
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
         
install_contr = None
fsr_2_2_opt = ['Alan Wake 2','A Plague Tale Requiem','Assassin\'s Creed Mirage',
               'Atomic Heart','Banishers: Ghosts of New Eden','Bright Memory: Infinite','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Death Stranding Director\'s Cut','Dying Light 2','F1 2022','F1 2023','FIST: Forged In Shadow Torch',
               'Fort Solis','Hogwarts Legacy','Horizon Forbidden West','Kena: Bridge of Spirits','Lies of P','Lords of The Fallen','Metro Exodus Enhanced Edition','Outpost: Infinity Siege',
               'Palworld','Ready or Not','Remnant II','RoboCop: Rogue City','Satisfactory','Sackboy: A Big Adventure','Starfield','STAR WARS Jedi: Survivor','Steelrising','TEKKEN 8','The Medium','Wanted: Dead']

fsr_2_1_opt=['Dead Space (2023)','Hellblade: Senua\'s Sacrifice','Hitman 3','Horizon Zero Dawn','Judgment','Martha Is Dead','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man: Miles Morales','Returnal','The Last of Us','Uncharted: Legacy of Thieves Collection']

fsr_2_0_opt = ['Alone in the Dark','Deathloop','Dying Light 2','Brothers: A Tale of Two Sons Remake','Ghostrunner 2','Marvel\'s Guardians of the Galaxy','Nightingale','Rise of The Tomb Raider','Shadow of the Tomb Raider','The Outer Worlds: Spacer\'s Choice Edition','The Witcher 3']

fsr_sdk_opt = ['Ratchet & Clank-Rift Apart']

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
    nvngx_label_guide.place(x=0,y=500)
    
def close_nvngx_guide(event=None):
    nvngx_label_guide.config(text="")
    nvngx_label_guide.place_forget()

dxgi_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
dxgi_label_guide.place_forget()

def guide_dxgi(event=None):
    dxgi_label_guide.config(text="Files that can help the mod to work in some specific games.\n(We recommend copying these files only if the default mod doesn't work.")
    dxgi_label_guide.place(x=205,y=500)
    
    
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
    sharp_over_label_guide.place(x=0,y=273)

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
    mod_op_label_guide.place(x=0,y=337)

def close_mod_opguide(event=None):
    mod_op_label_guide.config(text="")
    mod_op_label_guide.place_forget()

dis_con_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
dis_con_label_guide.place_forget()

def guide_dis_con_op (event=None):
    dis_con_label_guide.config(text="Disable the CMD that autostarts on game boot, default = false")
    dis_con_label_guide.place(x=0,y=595)
    
def close_dis_conguide(event=None):
    dis_con_label_guide.config(text="")
    dis_con_label_guide.place_forget()

debug_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
debug_label_guide.place_forget()

def guide_debug_op (event=None):
    debug_label_guide.config(text="For enabling FSR3FG debug overlay, default = false")
    debug_label_guide.place(x=122,y=562)
    
def close_debugguide(event=None):
    debug_label_guide.config(text="")
    debug_label_guide.place_forget()

debug_view_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
debug_view_label_guide.place_forget()

def guide_debug_view_op (event=None):
    debug_view_label_guide.config(text="For enabling FSR3FG debug overlay, default = false")
    debug_view_label_guide.place(x=0,y=562)
    
def close_debug_viewguide(event=None):
    debug_view_label_guide.config(text="")
    debug_view_label_guide.place_forget()

en_sig_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=220)
en_sig_label_guide.place_forget()

def guide_en_sig (event=None):
    en_sig_label_guide.config(text="Enable Signature Override can help some games to work, it is also recommended to activate in older versions of the mod")
    en_sig_label_guide.place(x=0,y=532)
    
def close_en_sigguide(event=None):
    en_sig_label_guide.config(text="")
    en_sig_label_guide.place_forget()

lfz_label_guide = tk.Label(text="",anchor='n',bd=1,relief=tk.SUNKEN,bg='black',fg='white',wraplength=150)
lfz_label_guide.place_forget()

def guide_lfz(event=None):
    lfz_label_guide.config(text="Files that can help the mod to work in some specific games.\n(We recommend copying these files only if the default mod doesn't work.")
    lfz_label_guide.place(x=245,y=560)
     
def close_lfz_guide(event=None):
    lfz_label_guide.config(text="")
    lfz_label_guide.place_forget()
    
def install(event=None):
    global install_contr,var_d_put
    try:
        install_contr = True
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

        if select_mod == 'Uniscaler' and select_mod_operates != None and select_nvngx != 'XESS 1.3' or select_mod == 'Uniscaler' and select_mod_operates != None and not nvngx_contr:
            xess_fsr()
        if select_mod == 'Uniscaler' and select_mod_operates != None and select_nvngx != 'DLSS 3.7.0' or select_mod == 'Uniscaler' and select_mod_operates != None and not nvngx_contr:
            dlss_fsr()
        if  nvngx_contr:
            copy_nvngx()
        if dxgi_contr:
            copy_dxgi()
        if lfz_sl_var.get() == 1:
            copy_lfz_sl()
        if install_contr and select_fsr != None or install_contr and select_option != 'Select FSR version':
            copy_fake_gpu()
        elif install_contr and select_option == 'Select FSR version' and select_fsr == None:
            messagebox.showwarning('Select FSR Version','Please select the FSR version')
        if select_mod != None and select_folder != None and select_option != None:
            messagebox.showinfo('Successful','Successful installation')
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
game_folder_canvas.place(x=90,y=75)

game_folder_label = tk.Label(screen,text = 'Game folder:',font=font_select,bg='black',fg='#C0C0C0')
game_folder_label.place(x=0,y=70)

mod_version_label = tk.Label(screen,text='Mod version:',font=font_select,bg='black',fg='#C0C0C0')
mod_version_label.place(x=0,y=108)

mod_version_canvas = Canvas(screen,width=200,height=15,bg='white')
mod_version_canvas.place(x=90,y=113)

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
        mod_version_listbox.place(x=90,y=135)
        mod_listbox_visible = True

def rectangle_event(event):
    global listbox_visible
    if listbox_visible:
        listbox.place_forget()
        listbox_visible = False
    else:
        listbox.place(x=90,y=58)
        listbox_visible = True
        
listbox_visible = False
listbox = tk.Listbox(screen,bg='white',selectbackground='white',width=30,height=0)
listbox.pack(side=tk.RIGHT,expand=True,padx=(0,115),pady=(0,500))
listbox.pack_forget()
scroll_listbox = tk.Scrollbar(listbox,orient=tk.VERTICAL,command=listbox.yview)
scroll_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(13,50))
listbox.config(yscrollcommand=scroll_listbox.set)
scroll_listbox.config(command=listbox.yview)

def update_rec_color():#color setting fsr_rec
    global color_rec
    if color_rec_bool == True:
        color_rec = 'white'
    else:
        color_rec = '#C0C0C0'
    fsr_canvas.itemconfig(fsr_rec,fill=color_rec)

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
    
fsr_canvas= Canvas(screen,width=50,height=19,bg='#C0C0C0',highlightthickness=0)
fsr_canvas.place(x=335,y=37)
color_rec_bool = False
color_rec = 'white'
fsr_rec = fsr_canvas.create_rectangle(0,0,50,30,fill=color_rec,outline='')
fsr_vtext = ""
fsr_listbox = tk.Listbox(screen,bg='white',width=8,height=0,highlightthickness=0)
fsr_listbox.pack(side=tk.RIGHT,expand=True,padx=(280,0),pady=(0,610))
fsr_listbox.pack_forget()

fsr_visible = False
fsr_view_listbox = False

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
            fsr_listbox.place(x=335,y=58)
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
    'Bright Memory: Infinite':'2.2',
    'Brothers: A Tale of Two Sons Remake':'2.0',
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
    'Ghostrunner 2':'2.0',
    'Martha Is Dead':'2.1',
    'Marvel\'s Guardians of the Galaxy':'2.0',
    'Hellblade: Senua\'s Sacrifice':'2.1',
    'Hitman 3':'2.1',
    'Hogwarts Legacy':'2.2',
    'Judgment':'2.1',
    'Kena: Bridge of Spirits':'2.2',
    'Lies of P':'2.2',
    'Lords of the Fallen':'2.2',
    'Marvel\'s Spider-Man Remastered':'2.1',
    'Marvel\'s Spider-Man: Miles Morales':'2.1',
    'Metro Exodus Enhanced Edition': '2.2',
    'Nightingale':'2.0',
    'Outpost: Infinity Siege':'2.2',
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
    'Starfield':'2.2',
    'STAR WARS Jedi: Survivor':'2.2',
    'Steelrising':'2.2',
    'Shadow of the Tomb Raider':'2.0',
    'TEKKEN 8':'2.2',
    'The Callisto Protocol':'2.1',
    'The Last of Us':'2.1',
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
    global mod_options,x,y,select_fsr,fsr_visible,fsr_vtext,fsr_game_version,color_rec,color_rec_bool,select_option,fsr_view_listbox
    if fsr_view_listbox == True:
        canvas_options.delete('text')
        
    index = listbox.curselection()
    if index:
        select_option = listbox.get(index)
        x = 2
        y = 8
        if select_option != 'Select FSR version': 
            fsr_view_listbox = False
            color_rec_bool = False
            canvas_options.delete('text')  
            fsr_canvas.delete('text')
            canvas_options.create_text(x, y, anchor='w', text=select_option, fill='black', tag='text')
            fsr_canvas.create_text(2, 8, anchor='w', text=fsr_game_version.get(select_option, ''), fill='black', tag='text')
            fsr_listbox.place_forget()
    if select_option == 'Select FSR version':
        fsr_view_listbox = True
        color_rec_bool = True
        canvas_options.delete('text')
        fsr_canvas.delete('text')
        canvas_options.create_text(x, y, anchor='w', text='Select FSR version', fill='black', tag='text')
    if select_option == 'Red Dead Redemption 2':
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        mod_version_listbox.insert(tk.END,'RDR2 Build_2','RDR2 Build_4','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3','0.10.4','Uniscaler')
    elif select_option == 'Dragons Dogma 2':
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
        mod_version_listbox.insert(tk.END,'Dinput8','Uniscaler_DD2','Uniscaler + Xess + Dlss DD2')
    elif select_option == 'Elden Ring':
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
        mod_version_listbox.insert(tk.END,'Disable_Anti-Cheat','Elden_Ring_FSR3')
    elif select_option == 'Baldur\'s Gate 3':
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
        mod_version_listbox.insert(tk.END,'Baldur\'s Gate 3 FSR3')
    elif select_option == 'The Callisto Protocol':
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
        mod_version_listbox.insert(tk.END,'The Callisto Protocol FSR3')  
    elif select_option == 'Fallout 4':
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        scroll_mod_listbox.pack(side=tk.RIGHT,fill=tk.Y,padx=(184,0),pady=(0,0))
        mod_version_listbox.insert(tk.END,'Fallout 4 FSR3') 
    else:
        mod_version_canvas.delete('text')
        mod_version_listbox.delete(0,END)
        for mod_op in mod_options:
            mod_version_listbox.insert(tk.END,mod_op)    
    update_rec_color()
    
options = ['Select FSR version','Alan Wake 2','Alone in the Dark','A Plague Tale Requiem','Assassin\'s Creed Mirage','Atomic Heart','Baldur\'s Gate 3','Banishers: Ghosts of New Eden','Bright Memory: Infinite','Brothers: A Tale of Two Sons Remake','Cyberpunk 2077','Dakar Desert Rally','Dead Island 2','Deathloop','Death Stranding Director\'s Cut','Dead Space (2023)','Dragons Dogma 2','Dying Light 2','Elden Ring','Fallout 4','F1 2022','F1 2023','FIST: Forged In Shadow Torch','Fort Solis',
        'Ghostrunner 2','Hellblade: Senua\'s Sacrifice','Hitman 3','Hogwarts Legacy','Horizon Zero Dawn','Horizon Forbidden West','Judgment','Kena: Bridge of Spirits','Lies of P','Lords of the Fallen','Martha Is Dead','Marvel\'s Guardians of the Galaxy','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man: Miles Morales','Metro Exodus Enhanced Edition','Nightingale','Outpost: Infinity Siege','Palworld','Ratchet & Clank-Rift Apart',
        'Red Dead Redemption 2','Ready or Not','Remnant II','Returnal','Rise of The Tomb Raider','RoboCop: Rogue City','Satisfactory','Sackboy: A Big Adventure','Shadow of the Tomb Raider','Starfield','STAR WARS Jedi: Survivor','Steelrising','TEKKEN 8','The Callisto Protocol','The Last of Us','The Medium','The Outer Worlds: Spacer\'s Choice Edition','The Witcher 3','Uncharted: Legacy of Thieves Collection','Wanted: Dead']#add options
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
        nvngx_op = ['Default', 'NVNGX Version 1', 'XESS 1.3', 'DLSS 3.7.0']

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

nvngx_op = ['Default', 'NVNGX Version 1', 'XESS 1.3', 'DLSS 3.7.0']
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

canvas_options.bind('<Button-1>',rectangle_event)
fsr_canvas.bind('<Button-1>',fsr_listbox_visible)
listbox.bind("<<ListboxSelect>>",update_canvas)
fsr_listbox.bind("<<ListboxSelect>>",update_fsr_v)
fakegpu_label.bind('<Enter>',guide_fk_gpu)
fakegpu_label.bind('<Leave>',close_fk_gpu_guide)
select_folder_canvas.bind('<Button-1>',open_explorer)
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
fps_user_entry.bind("<Key>", fps_isdigit)
install_label.bind('<Button-1>',install)
install_label.bind('<ButtonRelease-1>', install_false)

exit_label.bind('<Button-1>',exit_screen)

#screen.bind('<Button-1>',close_all_listbox)

screen.mainloop()