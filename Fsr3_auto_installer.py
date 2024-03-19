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
screen.title("FSR3.0 Mod Setup Utility - 0.9.0v")
screen.geometry("400x700")
screen.resizable(0,0)
screen.configure(bg='black')
if not unlock_screen:
    sys.exit()

icon_image = tk.PhotoImage(file="images\FSR-3-Supported-GPUs-Games.gif")
screen.iconphoto(True, icon_image)

img_bg = Image.open('images\gray-amd-logo-n657xc6ettzratsr...-removebg-preview.png')
img_res = img_bg.resize((200,300))
img_tk =ImageTk.PhotoImage(img_res)
x_img = (400 - 200)//2
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
exit_label.place(x=350,y=626)

install_label = tk.Label(screen,text='Install',font=font_select,bg='black',fg='#E6E6FA')
install_label.place(x=290,y=626)

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
del_dxgi_label.place(x=130,y=626)
del_dxgi_var = IntVar()
del_dxgi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=del_dxgi_var,command=cbox_del_dxgi)
del_dxgi_cbox.place(x=243,y=629) 
   
def cbox_cleanup(event=None):
    if cleanup_var.get() == 1:
        clean_var = messagebox.askyesno('Uninstall','Would you like to proceed with the uninstallation of the mod?')
        if clean_var:
            clean_mod()
            messagebox.showinfo('Success','Uninstallation completed successfully')
            cleanup_cbox.after(400,cleanup_cbox.deselect)
        
def clean_mod():
    mod_clean_list = ['fsr2fsr3.config.toml','winmm.ini','winmm.dll',
                      'lfz.sl.dlss.dll','FSR2FSR3.asi','EnableSignatureOverride.reg',
                      'DisableSignatureOverride.reg','nvngx.dll','_nvngx.dll','dxgi.dll','d3d12.dll','nvngx.ini','fsr2fsr3.log']
    
    for item in os.listdir(select_folder):
        if item in mod_clean_list:
            os.remove(os.path.join(select_folder,item))

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
        '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
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
    list_over = ['0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3']

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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\\dxgi'
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

copy_all_nvn = None
def copy_nvngx():
    global copy_all_nvn
    if select_nvngx == 'Default':
        copy_all_nvn = False
    else:
        copy_all_nvn = True
    
    nvngx_folders = None
    nvngx_folders = {
    '0.7.6':'mods\Temp\FSR2FSR3_0.7.6\\nvngx',
    '0.8.0':'mods\Temp\FSR2FSR3_0.8.0\\nvngx',
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\\nvngx',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\\nvngx',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\\nvngx',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\\nvngx',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\\nvngx',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\\nvngx'
    }
    nvngx_folder= nvngx_folders.get(select_mod)
    if  select_mod not in nvngx_folders:
        messagebox.showinfo('Error','Please select a version starting at 0.7.6')
    else:
        try:
            for item in os.listdir(nvngx_folder):
                nvn_path = os.path.join(nvngx_folder,item)
                if os.path.isfile(nvn_path):
                    shutil.copy2(nvn_path,select_folder)
                elif os.path.isdir(nvn_path):
                    shutil.copytree(nvn_path,os.path.join(select_folder,item))
                if not copy_all_nvn:
                    break
        except Exception as e:
            messagebox.showinfo("Error","Please select the destination folder and the mod version")

custom_fsr_act = False

def unlock_custom():
    list_custom = ['0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3']
    if select_mod not in list_custom:
        messagebox.showwarning('Error','Please select a mod version starting from 0.9.0')
        custom_fsr_cbox.deselect()
        return False
    else:
        return True

def cbox_custom_fsr(event=None):
    global custom_fsr_act
    if unlock_custom():
        fsr_balanced_canvas.configure(bg='white')
        fsr_ultraq_canvas.configure(bg='white')
        fsr_ultrap_canvas.configure(bg='white')
        fsr_performance_canvas.configure(bg='white')
        fsr_quality_canvas.configure(bg='white')
        native_res_canvas.configure(bg='white')
        custom_fsr_act = True
    else:
        custom_fsr_act = False
        fsr_balanced_canvas.configure(bg='#C0C0C0')
        fsr_ultraq_canvas.configure(bg='#C0C0C0')
        fsr_ultrap_canvas.configure(bg='#C0C0C0')
        fsr_performance_canvas.configure(bg='#C0C0C0')
        fsr_quality_canvas.configure(bg='#C0C0C0')
        native_res_canvas.configure(bg='#C0C0C0')
        
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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'   
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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
}

def fake_gpu_mod():
    global folder_fake_gpu
    
    key_1 = 'compatibility'
    sob_line = 'fake_nvidia_gpu = true'
    
    if select_mod in folder_fake_gpu:
       folder_gpu = folder_fake_gpu[select_mod]  
       
    edit_fake_gpu_list = ['0.10.2h1','0.10.3']
    
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
        
    edit_fakegpu_list = ['0.10.2h1','0.10.3']
    
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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
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
            '0.10.3':'mods\FSR2FSR3_0.10.3\enable_fake_gpu'
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
            '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu'
        }

        if select_mod in clean_file and select_mod in clean_file_rep:
            clean_file_copy = clean_file[select_mod]
            rep_clean_file = clean_file_rep[select_mod]

        if os.path.isdir(clean_file_copy ) and os.path.isdir(rep_clean_file):
            for file_clean in os.listdir(clean_file_copy):
                c_file = os.path.join(clean_file_copy,file_clean)
                if os.path.isfile(c_file):
                    shutil.copy2(c_file,rep_clean_file)

def cbox_editor():
    global replace_flag
    if open_editor_var.get() == 1 and select_mod != None:
        screen_editor()
    elif open_editor_var.get() == 0:
        replace_flag = False
    else:
        messagebox.showinfo('Select Mod','Please select the mod version to open TOML EDITOR')
        open_editor_cbox.deselect()

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
    global file_w,screen_toml
    replace_clean_file()
    file_w = default_file_path
    if file_w and open_editor_var.get() == 1:
        with open(file_w, 'r') as file:
            content = file.read()
            text_editor.delete('1.0', 'end')
            text_editor.insert('1.0', content)

def screen_editor():
    global text_editor,default_file_path,default_path,b_reload
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
    '0.7.4':'mods\Temp\FSR2FSR3_0.7.4\enable_fake_gpu',
    '0.7.5':'mods\Temp\FSR2FSR3_0.7.5_hotfix\enable_fake_gpu',
    '0.7.6':'mods\Temp\FSR2FSR3_0.7.6\enable_fake_gpu',
    '0.8.0':'mods\Temp\FSR2FSR3_0.8.0\enable_fake_gpu',
    '0.9.0':'mods\Temp\FSR2FSR3_0.9.0\enable_fake_gpu',
    '0.10.0':'mods\Temp\FSR2FSR3_0.10.0\enable_fake_gpu',
    '0.10.1':'mods\Temp\FSR2FSR3_0.10.1\enable_fake_gpu',
    '0.10.1h1':'mods\Temp\FSR2FSR3_0.10.1h1\enable_fake_gpu',
    '0.10.2h1':'mods\Temp\FSR2FSR3_0.10.2h1\enable_fake_gpu',
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu'
    }
    if select_mod in default_path:
        default_file_path = os.path.join(default_path[select_mod], "fsr2fsr3.config.toml")
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
    mod_list_sharp = ['0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3']
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
    '0.10.3':'mods\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
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
optional_mod_op_label.place(x=251,y=315)

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
    '0.10.3':'mods\Temp\FSR2FSR3_0.10.3\enable_fake_gpu\\fsr2fsr3.config.toml'
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
    elif select_mod != '0.9.0':
        options_mod_op = 'mode'
        select_mod_op_options = str(select_mod_operates).lower().replace(" ", '_')
     
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
    global select_folder,select_option
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
}

def fsr_2_2():
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
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON']
    }
    
    if select_mod in origins_2_2_folder:
        origins_2_2 = origins_2_2_folder[select_mod]
    
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
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON']
    }
    
    if select_mod in origins_2_1_folder:
        origins_2_1 = origins_2_1_folder[select_mod]
    
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
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON']
    }
    
    if select_mod in origins_2_0_folder:
        origins_2_0 = origins_2_0_folder[select_mod]
        
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
                  'mods\FSR2FSR3_0.10.3\FSR2FSR3_COMMON']
    }
    
    if select_mod in origins_sdk_folder:
        origins_sdk = origins_sdk_folder[select_mod]
    
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

def fsr_rdr2():
    global select_fsr,select_mod
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
                  'mods\FSR2FSR3_0.10.3\Red Dead Redemption 2']
    }
    
    if select_mod in origins_rdr2_folder:
        origins_rdr2 = origins_rdr2_folder[select_mod]
    try:
        for origin_folder in origins_rdr2:
            for item in os.listdir(origin_folder):
                item_path = os.path.join(origin_folder,item)
                if os.path.isfile(item_path):
                    shutil.copy2(item_path,select_folder)
    except Exception as e:
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
         
install_contr = None
fsr_2_2_opt = ['Alan Wake 2','A Plague Tale Requiem','Assassin\'s Creed Mirage',
               'Atomic Heart','Cyberpunk 2077','Dakar Desert Rally','Dying Light 2',
               'Hogwarts Legacy','Horizon Zero Dawn','Lords of The Fallen','Metro Exodus Enhanced Edition',
               'Palworld','Remnant II','RoboCop: Rogue City','Satisfactory','Starfield','STAR WARS Jedi: Survivor','TEKKEN 8','The Medium']

fsr_2_1_opt=['Dead Space (2023)','Uncharted: Legacy of Thieves Collection','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man: Miles Morales','Ready or Not','Returnal','The Last of Us',]

fsr_2_0_opt = ['The Witcher 3','Dying Light 2']

fsr_sdk_opt = ['Ratchet & Clank-Rift Apart']

fsr_sct_2_2 = ['2.2']
fsr_sct_2_1 = ['2.1']
fsr_sct_2_0 = ['2.0']
fsr_sct_SDK = ['SDK']
fsr_sct_rdr2 = ['RDR2','Red Dead Redemption 2']

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
    "Replace Dlss-FG: For mixing other upscalers like DLSS or XeSS with FSR3 Frame Generation in games that have NATIVE DLSS3 Frame Generation, no HUD ghosting")
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
    global install_contr
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
        elif select_fsr in fsr_sct_rdr2 or select_option in fsr_sct_rdr2 and install_contr:
            fsr_rdr2()
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
        replace_clean_file()

        install_label.configure(fg='black')
        screen.after(100,install_false)
        
    except Exception as e: 
        messagebox.showwarning('Error','Installation error')
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

def rectangle_event(event): #configuration listbox
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
    print(f"Clique detectado em x={x}, y={y}")
     
    
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
    'Horizon Zero Dawn':'2.2',
    'The Last of Us':'2.1',
    'Uncharted: Legacy of Thievs':'2.1',
    'A Plague Tale Requiem':'2.2',
    'Alan Wake 2':'2.2',
    'Assassin\'s Creed Mirage':'2.2',
    'Atomic Heart':'2.2',
    'Cyberpunk 2077':'2.2',
    'Dakar Desert Rally':'2.2',
    'Dead Space (2023)':'2.1',
    'Dying Light 2':'2.0',
    'Hogwarts Legacy':'2.2',
    'Lords of the Fallen':'2.2',
    'Marvel\'s Spider-Man Remastered':'2.1',
    'Marvel\'s Spider-Man: Miles Morales':'2.1',
    'Metro Exodus Enhanced Edition': '2.2',
    'Palworld':'2.2',
    'Ratchet & Clank-Rift Apart':'SDK',
    'Red Dead Redemption 2':'RDR2',
    'Ready or Not':'2.1',
    'Remnant II':'2.2',
    'Returnal':'2.1',
    'RoboCop: Rogue City':'2.2',
    'Satisfactory':'2.2',
    'Starfield':'2.2',
    'STAR WARS Jedi: Survivor':'2.2',
    'TEKKEN 8':'2.2',
    'The Last of Us':'2.1',
    'The Medium':'2.2',
    'The Witcher 3':'2.0',
    'Uncharted: Legacy of Thieves Collection':'2.1'      
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
def update_canvas(event=None):#canvas_options text configuration
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
        mod_version_listbox.insert(tk.END,'0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3')
    else:
        mod_version_listbox.delete(0,END)
        for mod_op in mod_options:
            mod_version_listbox.insert(tk.END,mod_op)
        
    update_rec_color()
    
options = ['Select FSR version','Alan Wake 2','A Plague Tale Requiem','Assassin\'s Creed Mirage','Atomic Heart','Cyberpunk 2077','Dakar Desert Rally','Dead Space (2023)','Dying Light 2','Hogwarts Legacy',
        'Horizon Zero Dawn','Lords of the Fallen','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man: Miles Morales','Metro Exodus Enhanced Edition','Palworld','Ratchet & Clank-Rift Apart',
        'Red Dead Redemption 2','Ready or Not','Remnant II','Returnal','RoboCop: Rogue City','Satisfactory','Starfield','STAR WARS Jedi: Survivor','TEKKEN 8','The Last of Us','The Medium','The Witcher 3','Uncharted: Legacy of Thieves Collection']#add options
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
    unlock_sharp()
    mod_version_canvas.update()

mod_options = ['0.7.4','0.7.5','0.7.6','0.8.0','0.9.0','0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3']
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
    
unlock_mod_operates_list = ['0.10.0','0.10.1','0.10.1h1','0.10.2h1','0.10.3']
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
    else:
        mod_operates_listbox.place_forget()
        mod_operates_canvas.delete('text')
        mod_operates_canvas.config(bg='#C0C0C0')
        unlock_listbox_mod_op = False
    for mod_operates_ins in mod_op_list:
        mod_operates_listbox.insert(tk.END,mod_operates_ins)
    
def update_nvngx(event=None):
    global select_nvngx
    index_nvngx_op = nvngx_listbox.curselection()
    if index_nvngx_op:
        select_nvngx = nvngx_listbox.get(index_nvngx_op)
        nvngx_canvas.delete('text')
        nvngx_canvas.create_text(2,8,anchor='w',text=select_nvngx,fill='black',tags='text')
    nvngx_canvas.update()

nvngx_op = ['Default','NVNGX Version 1']
for nvngx_options in nvngx_op:
    nvngx_listbox.insert(tk.END,nvngx_options)
    
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
install_label.bind('<Button-1>',install)
install_label.bind('<ButtonRelease-1>', install_false)

exit_label.bind('<Button-1>',sys.exit)

#screen.bind('<Button-1>',close_all_listbox)

screen.mainloop()