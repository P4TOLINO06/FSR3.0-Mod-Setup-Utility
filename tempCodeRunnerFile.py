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
            messagebox.sho