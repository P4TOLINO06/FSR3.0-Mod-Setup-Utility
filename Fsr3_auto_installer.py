import tkinter as tk
from PIL import ImageTk, Image, ImageDraw, ImageFont
from customtkinter import *
from customtkinter import CTk
from tkinter.font import Font
from tkinter import Canvas,filedialog

screen = tk.Tk()
screen.title("FSR3.0 Mod Setup Utility - 0.2v")
screen.geometry("400x700")
screen.iconbitmap('D:\Prog\Fsr3\images\FSR-3-Supported-GPUs-Games.ico')
screen.resizable(0,0)
screen.configure(bg='black')

img_bg = Image.open('D:\Prog\Fsr3\images\gray-amd-logo-n657xc6ettzratsr...-removebg-preview.png')
img_res = img_bg.resize((200,300))
img_tk =ImageTk.PhotoImage(img_res)
x_img = (400 - 200)//2
y_img = (700 - 300)//2

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

select_folder_canvas = Canvas(screen,width=50,height=19,bg='white',highlightthickness=0)
select_folder_canvas.place(x=335,y=75)
select_folder_canvas.create_text(4,8,anchor='w',font=(font_select,9,'bold'),text='Select',fill='black',)
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
    
fsr_canvas= Canvas(screen,width=50,height=19,bg='#C0C0C0',highlightthickness=0)
fsr_canvas.place(x=335,y=37)
color_rec_bool = True
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

x=0
y=0
def update_canvas():#canva_options text configuration
    global x,y,select_fsr,fsr_visible,fsr_vtext,fsr_game_version,color_rec,color_rec_bool,select_option,fsr_view_listbox
    if fsr_view_listbox == False:
        canvas_options.delete('text')
        
    index = listbox.curselection()
    if index:
        fsr_canvas.delete('text')
        select_option = listbox.get(index)
        x = 2
        y = 8
        canvas_options.create_text(x,y,anchor='w',text=select_option,fill='black',tag='text')
        fsr_canvas.create_text(2,8,anchor='w',text=fsr_game_version.get(select_option,''),fill='black',tag='text')
        if select_option != 'Select FSR version': 
            canvas_options.delete('text')  
            canvas_options.create_text(x, y, anchor='w', text=select_option, fill='black', tag='text')
            fsr_canvas.create_text(2, 8, anchor='w', text=fsr_game_version.get(select_option, ''), fill='black', tag='text')
    if select_option == 'Select FSR version':
        fsr_view_listbox = True
        color_rec_bool = True
    else:
        fsr_view_listbox = False
        color_rec_bool = False
        fsr_listbox.place_forget()
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

mod_options = ['0.7.4','0.7.5','0.7.6','0.8','0.9','0.10','0.10.1','0.10.1h1','0.10.2h1']
for mod_op in mod_options:
    mod_version_listbox.insert(tk.END,mod_op)

canvas_options.bind('<Button-1>',rectangle_event)
fsr_canvas.bind('<Button-1>',fsr_listbox_visible)
listbox.bind("<<ListboxSelect>>",lambda event:update_canvas())
fsr_listbox.bind("<<ListboxSelect>>",update_fsr_v)
select_folder_canvas.bind('<Button-1>',open_explorer)
mod_version_canvas.bind('<Button-1>',mod_listbox_view)
mod_version_listbox.bind("<<ListboxSelect>>",update_mod_version)
#screen.bind('<Button1-1>',close_all_listbox)

screen.mainloop()