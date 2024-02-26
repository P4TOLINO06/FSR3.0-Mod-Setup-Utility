    with open(folder_toml,'r') as file:
            toml_d = toml.load(file)  
                    
        toml_d[key_1]['fake_nvapi_results'] = True
        
        with open (folder_toml,'w') as file:
            toml.dump(toml_