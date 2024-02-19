import tkinter as tk
from PIL import ImageTk, Image, ImageDraw, ImageFont
from customtkinter import *
from customtkinter import CTk
from tkinter.font import Font
from tkinter import Canvas,filedialog,ttk

screen = tk.Tk()
screen.title("FSR3.0 Mod Setup Utility - 0.6v")
screen.geometry("400x700")
screen.iconbitmap('D:\Prog\Fsr3\images\FSR-3-Supported-GPUs-Games.ico')
screen.resizable(0,0)
screen.configure(bg='black')

img_bg = Image.open('D:\Prog\Fsr3\images\gray-amd-logo-n657xc6ettzratsr...-removebg-preview.png')
img_res = img_bg.resize((200,300))
img_tk =ImageTk.PhotoImage(img_res)
x_img = (400 - 200)//2
y_img = (1200 - 300)//2

bg_label = tk.Label(screen,image=img_tk,bg='black')
bg_label.place(x=x_img,y=y_img)

title_page = tk.Label(screen, text="FSR3 Mod", font=("Arial", 10, "bold"), fg="#FFFAFA", bg="black") 
title_page.pack(anchor='w',pady=0)

font_select = Font(family='Notably Absent',size=12)
select_label = tk.Label(screen, text="Game select:",font=font_select,bg='black',fg='#C0C0C0')
select_label.pack(anchor='w',pady=10)

fsr_label = tk.Label(screen,text='FSR:',font=font_select,bg='black',fg='#C0C0C0')
fsr_label.place(x=300,y=33)
canvas_options = Canvas(screen,width=200,height=15,bg='white')
canvas_options.place(x=90,y=37)

def cbox_lfz_sl(event=None):
    if lfz_sl_var.get() == 1:
        print('1')
    else:
        print('0')
    
lfz_sl_label = tk.Label(screen,text='Install lfz.sl.dlss',font=font_select,bg='black',fg='#C0C0C0')
lfz_sl_label.place(x=265,y=533)
lfz_sl_var = IntVar()
lfz_sl_label_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=lfz_sl_var,command=cbox_lfz_sl)
lfz_sl_label_cbox.place(x=375,y=535)

def cbox_debug_tear_lines(event=None):
    if debug_tear_lines_var.get() == 1:
        print('1')
    else:
        print('0')
debug_tear_lines_label = tk.Label(screen,text='Debug Tear Lines',font=font_select,bg='black',fg='#C0C0C0')
debug_tear_lines_var = IntVar()
debug_tear_lines_label.place(x=120,y=533)
debug_tear_lines_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_tear_lines_var,command=cbox_debug_tear_lines)
debug_tear_lines_cbox.place(x=235,y=536)

def cbox_debug_view(event=None):
    if debug_view_var.get() == 1:
        print('1')
    else:
        print('0')
debug_view_label = tk.Label(screen,text='Debug View',font=font_select,bg='black',fg='#C0C0C0')
debug_view_label.place(x=0,y=533)
debug_view_var = IntVar()
debug_view_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=debug_view_var,command=cbox_debug_view)
debug_view_cbox.place(x=85,y=536)

def cbox_enable_sigover(event=None):
    if enable_sigover_var.get() == 1:
        print('1')
    else:
        print('0')
        
enable_sigover_label = tk.Label(screen,text='Enable Signature Override',font=font_select,bg='black',fg='#C0C0C0')
enable_sigover_label.place(x=0,y=503)
enable_sigover_var = IntVar()
enable_sigover_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=enable_sigover_var,command=cbox_enable_sigover)
enable_sigover_cbox.place(x=170,y=506)

def cbox_disable_sigover(event=None):
    if disable_sigover_var.get() == 1:
        print('1')
    else:
        print('0')
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

custom_fsr_act = False
def cbox_custom_fsr(event=None):
    global custom_fsr_act
    if custom_fsr_var.get() == 1:
        fsr_balanced_canvas.configure(bg='white')
        fsr_ultraq_canvas.configure(bg='white')
        fsr_ultrap_canvas.configure(bg='white')
        fsr_performance_canvas.configure(bg='white')
        fsr_quality_canvas.configure(bg='white')
        custom_fsr_act = True
    else:
        custom_fsr_act = False
        fsr_balanced_canvas.configure(bg='#C0C0C0')
        fsr_ultraq_canvas.configure(bg='#C0C0C0')
        fsr_ultrap_canvas.configure(bg='#C0C0C0')
        fsr_performance_canvas.configure(bg='#C0C0C0')
        fsr_quality_canvas.configure(bg='#C0C0C0')
        
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

fsr_ultraq_up_count = 25
fsr_ultraq_up_count_f = 25
def fsr_ultraq_up_custom(event=None):
    global custom_fsr_act,fsr_ultraq_up_count
    fsr_ultraq_up_count_f = f'{fsr_ultraq_up_count:.0f}'
    if custom_fsr_act and fsr_ultraq_up_count <= 100:
        fsr_ultraq_up_count += 1
        fsr_ultraq_canvas.delete('text')
        fsr_ultraq_canvas.create_text(2,8,anchor='w',fill='black',text=fsr_ultraq_up_count_f,tags='text')
        fsr_ultrap_canvas.update()
        fsr_ultraq_label_up.configure(fg='black')
def color_fsr_ultraq_up(event=None):
    fsr_ultraq_label_up.configure(fg='#B0C4DE')

def fsr_ultraq_down_custom(event=None):
    global fsr_ultraq_up_count,fsr_ultraq_up_count_f
    if custom_fsr_act and fsr_ultraq_up_count > 25:
        fsr_ultraq_up_count -= 1
        fsr_ultraq_up_count_f = f'{fsr_ultraq_up_count:.0f}'
        fsr_ultraq_canvas.delete('text')
        fsr_ultraq_canvas.create_text(2,8,anchor='w',fill='black',text=fsr_ultraq_up_count_f,tags='text')
        fsr_ultraq_label_down.configure(fg='black')
        fsr_ultraq_canvas.update()
def color_fsr_ultraq_down(event=None):
    fsr_ultraq_label_down.configure(fg='#B0C4DE')

fsr_quality_up_count = 25 
fsr_quality_up_count_f = 25

def fsr_quality_up_custom(event=None):
    global fsr_quality_up_count,fsr_quality_up_count_f
    fsr_quality_up_count_f = f'{fsr_quality_up_count:.0f}'
    if custom_fsr_act and fsr_quality_up_count <= 100:
        fsr_quality_up_count += 1
        fsr_quality_canvas.delete('text')
        fsr_quality_canvas.create_text(2,8,anchor='w',text=fsr_quality_up_count_f,fill='black',tags='text')       
        fsr_quality_label_up.configure(fg='black')
        fsr_quality_canvas.update()
def color_fsr_quality_up(event=None):
    fsr_quality_label_up.configure(fg='#B0C4DE')

def fsr_quality_down_custom(event=None):
    global fsr_quality_up_count,fsr_quality_up_count_f
    if custom_fsr_act and fsr_quality_up_count > 25:
        fsr_quality_up_count -= 1
        fsr_quality_up_count_f = f'{fsr_quality_up_count:.0f}'
        fsr_quality_canvas.delete('text')
        fsr_quality_canvas.create_text(2,8,anchor='w',text=fsr_quality_up_count_f,fill='black',tags='text')
        fsr_quality_label_down.configure(fg='black')
def color_fsr_quality_down(event=None):
    fsr_quality_label_down.configure(fg='#B0C4DE')

fsr_balanced_up_count = 25
fsr_balanced_up_count_f = 25
def fsr_balanced_up_custom(event=None):
    global fsr_balanced_up_count,fsr_balanced_up_count_f
    fsr_balanced_up_count_f = f'{fsr_balanced_up_count:.0f}'
    if custom_fsr_act and fsr_balanced_up_count <= 100:
        fsr_balanced_up_count += 1
        fsr_balanced_canvas.delete('text')
        fsr_balanced_canvas.create_text(2,8,anchor='w',text=fsr_balanced_up_count_f,tags='text')
        fsr_balanced_label_up.configure(fg='black')
def color_fsr_balanced_up(event=None):
    fsr_balanced_label_up.configure(fg='#B0C4DE')

def fsr_balanced_down_custom(event=None):
    global fsr_balanced_up_count,fsr_balanced_up_count_f
    if custom_fsr_act and fsr_balanced_up_count > 25:
        fsr_balanced_up_count -= 1
        fsr_balanced_up_count_f = f'{fsr_balanced_up_count:.0f}'
        fsr_balanced_canvas.delete('text')
        fsr_balanced_canvas.create_text(2,8,anchor='w',text=fsr_balanced_up_count_f,fill='black',tags='text')
        fsr_balanced_label_down.configure(fg='black')
def color_fsr_balanced_down(event=None):
    fsr_balanced_label_down.configure(fg='#B0C4DE')

fsr_perf_up_count = 25
fsr_perf_up_count_f = 25
def fsr_perf_up_custom(event=None):
    global fsr_perf_up_count,fsr_perf_up_count_f
    fsr_perf_up_count_f = f'{fsr_perf_up_count:.0f}'
    if custom_fsr_act and fsr_perf_up_count <= 100:
        fsr_perf_up_count += 1
        fsr_performance_canvas.delete('text')
        fsr_performance_canvas.create_text(2,8,anchor='w',text=fsr_perf_up_count_f,tags='text')
        fsr_performance_label_up.configure(fg='black')
def color_fsr_perf_up(event=None):
    fsr_performance_label_up.configure(fg='#B0C4DE')

def fsr_perf_down_custom(event=None):
    global fsr_perf_up_count,fsr_perf_up_count_f
    if custom_fsr_act and fsr_perf_up_count > 25:
        fsr_perf_up_count -= 1
        fsr_perf_up_count_f = f'{fsr_perf_up_count:.0f}'
        fsr_performance_canvas.delete('text')
        fsr_performance_canvas.create_text(2,8,anchor='w',text=fsr_perf_up_count_f,tags='text')
        fsr_performance_label_down.configure(fg='black')
def color_fsr_perf_down(event=None):
    fsr_performance_label_down.configure(fg='#B0C4DE')

fsr_ultrap_count_up = 25
fsr_ultrap_count_up_f = 25
def fsr_ultrap_up_custom(event=None):
    global fsr_ultrap_count_up,fsr_ultrap_count_up_f
    fsr_ultrap_count_up_f = f'{fsr_ultrap_count_up:.0f}'
    if custom_fsr_act and fsr_ultrap_count_up <= 100:
        fsr_ultrap_count_up += 1
        fsr_ultrap_canvas.delete('text')
        fsr_ultrap_canvas.create_text(2,8,anchor='w',text=fsr_ultrap_count_up_f,fill='black',tags='text')
        fsr_ultrap_label_up.configure(fg='black')
def color_fsr_ultrap_up(event=None):
    fsr_ultrap_label_up.configure(fg='#B0C4DE')

def fsr_ultrap_down_custom(event=None):
    global fsr_ultrap_count_up,fsr_ultrap_count_up_f
    if custom_fsr_act and fsr_ultrap_count_up > 25:
        fsr_ultrap_count_up -= 1
        fsr_ultrap_count_up_f = f'{fsr_ultrap_count_up:.0f}'
        fsr_ultrap_canvas.delete('text')
        fsr_ultrap_canvas.create_text(2,8,anchor='w',text=fsr_ultrap_count_up_f,fill='black',tags='text')
        fsr_ultrap_label_down.configure(fg='black')
def color_fsr_ultrap_down(event=None):
    fsr_ultrap_label_down.configure(fg='#B0C4DE')
    
def cbox_fakegpu():
    if fakegpu_cbox_var.get() == 1:
        print('0')
        fakegpu_cbox_var.set == 0
    else:
        fakegpu_cbox_var.set == 1
        print('1')

fakegpu_label = tk.Label(screen,text='Fake NVIDIA GPU',font=font_select,bg='black',fg='#C0C0C0')
fakegpu_label.place(x=0,y=185)
fakegpu_cbox_var = tk.IntVar()
fakegpu_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=fakegpu_cbox_var,command=cbox_fakegpu)
fakegpu_cbox.place(x=120,y=187)

def cbox_ue():
    if ue_cbox_var.get() == 1:
        ue_cbox_var.set == 0
        print('0')
    else:
        ue_cbox_var.set == 1
        print('1')
        
ue_label = tk.Label(screen,text='UE Compatibility Mode',bg='black',font=font_select,fg='#C0C0C0')
ue_label.place(x=200,y=185)
ue_cbox_var = tk.IntVar()
ue_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=ue_cbox_var,command=cbox_ue)
ue_cbox.place(x=355,y=187)

def cbox_nvapi():
    if nvapi_cbox_var.get() == 1:
        print('0')
        nvapi_cbox_var.set == 0
    else:
        print('1')
        nvapi_cbox_var.set == 1

nvapi_label = tk.Label(screen,text='NVAPI Results',font=font_select,bg='black',fg='#C0C0C0')
nvapi_label.place(x=0,y=215)
nvapi_cbox_var = tk.IntVar()
nvapi_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=nvapi_cbox_var,command=cbox_nvapi)
nvapi_cbox.place(x=120,y=217)

def cbox_macos():
    if macos_sup_var.get() == 1:
        print('0')
        macos_sup_var.set == 0
    else:
        print('1')
        macos_sup_var.set == 1
macos_sup_label = tk.Label(screen,text='MacOS Crossover Support',font=font_select,bg='black',fg='#C0C0C0')
macos_sup_label.place(x=200,y=215)
macos_sup_var = tk.IntVar()
macos_sup_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=macos_sup_var,command=cbox_macos)
macos_sup_cbox.place(x=372,y=217)

def cbox_editor():
    if open_editor_var.get() == 1:
        print('0')
        open_editor_var.set = 0
    else:
        print('1')
        open_editor_var.set = 1
open_editor_label = tk.Label(screen,text='Open TOML Editor',font=font_select,bg='black',fg='#C0C0C0')
open_editor_label.place(x=200,y=245)
open_editor_var = tk.IntVar()
open_editor_cbox = tk.Checkbutton(screen,bg='black',activebackground='black',highlightthickness=0,variable=open_editor_var,command=cbox_editor)
open_editor_cbox.place(x=325,y=247)

unlock_sharp_up_down = False
def cbox_sharpness():
    global unlock_sharp_up_down
    if sharpness_var.get() == 1:
        unlock_sharp_up_down = True
        sharpness_value_canvas.configure(bg='white')
    else:
        unlock_sharp_up_down = False
        sharpness_value_canvas.configure(bg='#C0C0C0')
        
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
cont_value_up_f = 0
def cont_sharpness_value_up(event=None):
    global cont_value_up,cont_value_up_f,unlock_sharp_up_down
    cont_value_up_f = f'{cont_value_up:.1f}'
    if unlock_sharp_up_down and cont_value_up < 1:
        cont_value_up+=0.1
        sharpness_value_canvas.delete('text')
        sharpness_value_canvas.create_text(2,8,anchor='w',text=cont_value_up_f,fill='black',tags='text')
        sharpness_value_label_up.configure(fg='black')
        sharpness_value_canvas.update()

def color_sharpness_value_up(event=None):
    sharpness_value_label_up.configure(fg='#B0C4DE')

def cont_sharpness_value_down(event=None):
    global cont_value_up_f,cont_value_up,unlock_sharp_up_down
    if unlock_sharp_up_down and cont_value_up > 0.1:
        cont_value_up-=0.1
        cont_value_up_f = f'{cont_value_up:.1f}'
        sharpness_value_canvas.delete('text')
        sharpness_value_canvas.create_text(2,8,anchor='w',text=cont_value_up_f,fill='black',tags='text')
        sharpness_value_canvas.update()
        sharpness_value_label_down.configure(fg='black')

def color_sharpness_value_down(event=None):
    sharpness_value_label_down.configure(fg='#B0C4DE')
    
mod_operates_label = tk.Label(screen,text='Mod Operates:',font=font_select,bg='black',fg='#C0C0C0')
mod_operates_label.place(x=0,y=310)
mod_operates_canvas = tk.Canvas(screen,width=150,height=19,bg='white',highlightthickness=0)
mod_operates_canvas.place(x=100,y=314)
mod_operates_listbox = tk.Listbox(screen,bg='white',width=25,height=0,highlightthickness=0)
mod_operates_listbox.place(x=100,y=335)
mod_operates_listbox.place_forget()

mod_op_list_visible = False
def mod_operates_view(event):
    global mod_op_list_visible
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

def open_explorer(event=None): #Function to select the game folder and create the selected path text on the Canvas
    select_folder =filedialog.askdirectory()
    game_folder_canvas.delete('text')
    game_folder_canvas.create_text(2,8, anchor='w',text=select_folder,fill='black',tags='text') 
      
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
    global listbox_visible,fsr_visible
    if listbox_visible:
        listbox.place_forget()
        listbox_visible = False
    if fsr_visible:
        fsr_listbox.place_forget()
        fsr_visible = False
    
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
    'The Witcher 3':'2.0'      
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
def update_canvas():#canvas_options text configuration
    global x,y,select_fsr,fsr_visible,fsr_vtext,fsr_game_version,color_rec,color_rec_bool,select_option,fsr_view_listbox
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
        else:
            fsr_listbox.place_forget()
    if select_option == 'Select FSR version':
        fsr_view_listbox = True
        color_rec_bool = True
        canvas_options.delete('text')
        fsr_canvas.delete('text')
        canvas_options.create_text(x, y, anchor='w', text='Select FSR version', fill='black', tag='text')
    update_rec_color()
    
options = ['Select FSR version','Alan Wake 2','A Plague Tale Requiem','Assassin\'s Creed Mirage','Atomic Heart','Cyberpunk 2077','Dakar Desert Rally','Dead Space (2023)','Dying Light 2','Hogwarts Legacy',
        'Horizon Zero Dawn','Lords of the Fallen','Marvel\'s Spider-Man Remastered','Marvel\'s Spider-Man: Miles Morales','Metro Exodus Enhanced Edition','Palworld','Ratchet & Clank-Rift Apart',
        'Red Dead Redemption 2','Ready or Not','Remnant II','Returnal','RoboCop: Rogue City','Satisfactory','Starfield','STAR WARS Jedi: Survivor','TEKKEN 8','The Last of Us','The Medium','The Witcher 3']#add options
for option in options:
    listbox.insert(tk.END,option)

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
    mod_version_canvas.update()

mod_options = ['0.7.4','0.7.5','0.7.6','0.8','0.9','0.10','0.10.1','0.10.1h1','0.10.2h1','0.10.3']
for mod_op in mod_options:
    mod_version_listbox.insert(tk.END,mod_op)
    
def update_asi(event=None):
    global option_asi,select_asi_bool,select_asi_notvisible
    index_asi = asi_listbox.curselection()
    if index_asi:
        option_asi = asi_listbox.get(index_asi)
        asi_canvas.delete('text')
        asi_canvas.create_text(2,8,anchor='w',text=option_asi,fill='black',tags='text')
    if option_asi == 'ASI Loader for RDR2':
        select_asi_notvisible = False
        select_asi_notvisible = False
        select_asi_canvas.delete('text')
        select_asi_listbox.place_forget() 
    else:
        select_asi_notvisible = True
        select_asi_bool = True
    update_asi_color()
    asi_canvas.update()
    
asi_options = ['Select ASI Loader','ASI Loader for RDR2']
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
    mod_operates_canvas.update()

mod_op_list = ['Default','Enable Game Only','Built-in Upscaling','Replace DLSS-FG']
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

nvngx_op = ['Default','NVNGX Version 1','NVNGX Version 2']
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
listbox.bind("<<ListboxSelect>>",lambda event:update_canvas())
fsr_listbox.bind("<<ListboxSelect>>",update_fsr_v)
select_folder_canvas.bind('<Button-1>',open_explorer)
mod_version_canvas.bind('<Button-1>',mod_listbox_view)
mod_version_listbox.bind("<<ListboxSelect>>",update_mod_version)
asi_canvas.bind('<Button-1>',asi_listbox_view)
asi_listbox.bind('<<ListboxSelect>>',update_asi)
select_asi_canvas.bind('<Button-1>',select_asi_view)
select_asi_listbox.bind('<<ListboxSelect>>',update_select_asi)
sharpness_value_label_up.bind('<Button-1>',cont_sharpness_value_up)
sharpness_value_label_up.bind('<ButtonRelease-1>',color_sharpness_value_up)
sharpness_value_label_down.bind('<Button-1>',cont_sharpness_value_down)
sharpness_value_label_down.bind('<ButtonRelease-1>',color_sharpness_value_down)
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
nvngx_canvas.bind('<Button-1>',nvngx_cbox_view)
nvngx_listbox.bind('<<ListboxSelect>>',update_nvngx)
dxgi_canvas.bind('<Button-1>',dxgi_cbox_view)
dxgi_listbox.bind('<<ListboxSelect>>',update_dxgi)

#screen.bind('<Button1-1>',close_all_listbox)

screen.mainloop()