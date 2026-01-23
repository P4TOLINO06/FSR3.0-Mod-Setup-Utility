import json
import hashlib
import zipfile
import shutil
import requests
from pathlib import Path
import os
import sys
import ctypes
from helpers import hide_and_protect, make_writable

if getattr(sys, "frozen", False):
    ROOT_DIR = Path(sys.executable).parent
else:
    ROOT_DIR = Path(__file__).parent

MODS_DIR = ROOT_DIR / "mods"
TEMP_DIR = ROOT_DIR / "Temp"

APPDATA_DIR = Path(os.getenv("LOCALAPPDATA")) / "FSR-Mod-Utility"
LOCAL_MANIFEST_PATH = APPDATA_DIR / "manifest_local.json"

class Update:
    def __init__(self):
        
        self.config = self.load_config()
        if "bucket_url" not in self.config:
            raise KeyError("bucket_url not defined in config.json")

        self.bucket_url = self.config["bucket_url"]
        self.manifest_url = f"{ self.bucket_url}/manifest.json"

        self.remote_manifest = self.download_json(self.manifest_url)
        self.local_manifest = self.load_local_manifest()

        TEMP_DIR.mkdir(exist_ok=True)
        MODS_DIR.mkdir(exist_ok=True)

    def load_config(self): # Load the bucket URL
        APPDATA_DIR.mkdir(parents=True, exist_ok=True)

        self.appdata_config = APPDATA_DIR/"config.json"
        self.exe_config_file = Path("J/config.json")

        if self.appdata_config.exists():
            with self.appdata_config.open("r", encoding="utf-8") as f:
                return json.load(f)
        
        # Copies the config.json from the exe’s “J” folder to appdata/FSR-Mod-Utility the first time the app is opened, after the copy, the config.json file from the exe’s “J” folder is deleted
        if self.exe_config_file.exists(): 
            shutil.copy2(self.exe_config_file, self.appdata_config)
            self.exe_config_file.unlink()

            hide_and_protect(self.appdata_config)

            with self.appdata_config.open("r", encoding="utf-8") as f:
                return json.load(f)
        
        raise FileNotFoundError("config.json not exists.")

    def download_json(self, url):
        r = requests.get(url, timeout=30)
        r.raise_for_status()
        return r.json()

    def md5_file(self, path: Path) -> str:
        h = hashlib.md5()
        with open(path, "rb") as f:
            for chunk in iter(lambda: f.read(8192), b""):
                h.update(chunk)
        return h.hexdigest()

    def download_file(self, url, dest: Path):
        with requests.get(url, stream=True, timeout=120) as r:
            r.raise_for_status()
            with open(dest, "wb") as f:
                for chunk in r.iter_content(chunk_size=8192):
                    if chunk:
                        f.write(chunk)

    def load_local_manifest(self):
        return self.load_or_create_local_manifest()
    
    def save_local_manifest(self, manifest):
        make_writable(LOCAL_MANIFEST_PATH)

        LOCAL_MANIFEST_PATH.write_text(
            json.dumps(manifest, indent=2),
            encoding="utf-8"
        )

        hide_and_protect(LOCAL_MANIFEST_PATH)

    def update_mod(self, mod_name, mod_data):
        print(f"🔄 Updating mod: {mod_name}")

        zip_url = f"{self.bucket_url}/{mod_data['download']}"
        zip_path = TEMP_DIR / f"{mod_name}.zip"

        self.download_file(zip_url, zip_path)

        # Remove old version
        shutil.rmtree(MODS_DIR / mod_name, ignore_errors=True)

        with zipfile.ZipFile(zip_path, "r") as z:
            z.extractall(MODS_DIR)

        zip_path.unlink(missing_ok=True)
        print(f"✅ {mod_name} updated")

    def process_updates(self, apply_updates: bool, progress_callback=None, update_list=None):
        updates_found = 0
        pending_mods = []

        for mod_name, remote_data in self.remote_manifest["mods"].items():
            mod_path = MODS_DIR / mod_name
            local_data = self.local_manifest["mods"].get(mod_name)

            needs_update = (
                not local_data or
                local_data["hash"] != remote_data["hash"] or
                not mod_path.exists()
            )

            if needs_update:
                updates_found += 1
                

                if update_list:
                    pending_mods.append({
                        "name": mod_name,
                        "remote": remote_data
                    })

                if apply_updates:
                    self.update_mod(mod_name, remote_data)
                    self.local_manifest["mods"][mod_name] = remote_data

                    if progress_callback:
                        progress_callback()

        if apply_updates and updates_found > 0:
            self.save_local_manifest(self.local_manifest)
        
        if update_list:
            return updates_found, pending_mods

        return updates_found

    def check_updates(self):
        count, mods = self.process_updates(apply_updates=False, update_list=True)
        return count > 0, count, mods
    
    def load_or_create_local_manifest(self):
        appdir = os.path.join(os.getenv("LOCALAPPDATA"), "FSR-Mod-Utility")
        os.makedirs(appdir, exist_ok=True)

        appdata_file = os.path.join(appdir, 'manifest_local.json')

        if getattr(sys, "frozen", False):
            exe_dir = os.path.dirname(sys.executable)
        else:
            exe_dir = os.getcwd()
        
        exe_manifest = os.path.join(exe_dir, "J\\manifest_local.json")

        if os.path.exists(appdata_file):
            with open(appdata_file, "r", encoding="utf-8") as f:
                return json.load(f)
        
        if os.path.exists(exe_manifest):
            shutil.copy2(exe_manifest, appdata_file)
            os.remove(exe_manifest)

            with open(appdata_file, "r", encoding="utf-8") as f:
                return json.load(f)        
        
        data= {"mods":{}}
        with open(appdata_file, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2)

            hide_and_protect(appdata_file)
            return data
            
    def run_updater(self, progress_callback=None):
        print("🔍 Checking mod updates...")
        count = self.process_updates(apply_updates=True, progress_callback=progress_callback)

        if count > 0:
            print(f"🎉 {count} mods updated successfully")
        else:
            print("✔ All mods are already up to date")
        
        return count