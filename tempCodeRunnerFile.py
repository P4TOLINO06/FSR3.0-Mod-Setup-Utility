def cbox_fakegpu():
    if fakegpu_cbox_var.get() == 1:
        print('1')
        fakegpu_cbox_var.set(0)
    else:
        fakegpu_cbox_var.set(1)
        print('2')

fakegpu_cbox_var = tk.IntVar()
fakegpu_cbox = tk.Checkbutton(screen,bg='black',fg='white',text='Fake Gpu',variable=fakegpu_cbox_var,command=cbox_fakegpu)
fakegpu_cbox.pack(padx=0,pady=100,anchor='w')