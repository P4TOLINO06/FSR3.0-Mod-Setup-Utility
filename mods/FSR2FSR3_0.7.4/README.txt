# New installation guide FSR2FSR3

## Regular FSR2FSR3 installation  
1. Find out which version of FSR2 the game uses.  
You can do this by checking the list of games that support high fidelity upscaling on [PCGamingWiki](https://www.pcgamingwiki.com/wiki/List_of_games_that_support_high-fidelity_upscaling).  
NOTE: Certain games (Ratchet & Clank: Rift Apart) use a different implementation of FSR2, but might also be listed as using version 2.2 on the wiki.  
You can detect these by looking for a file called `ffx_fsr2_x64.dll` in the game directory.  
If your game has that file in its game directory, please use the *SDK* version of the mod.

2. Select the mod corresponding to the FSR2 version.  
2.0.x -> `_200`  
2.1.x -> `_210`  
2.2.x or (N/A) -> `_220`  
SDK -> `_SDK`

3. Navigate to your game executable.  
For most games this should be in the root game directory, but also check the Notes section for your game's compatibility list entry for any specific directory you might need to use instead.  
For Unreal Engine games, you should use the executable ending with `-Shipping.exe`, which should be in a subdirectory. Do **not** use the executable found in the root game directory!

4. Extract the downloaded mod archive into the folder with the game executable.

5. Launch the game. If everything worked correctly, there should be a new console window with a few log messages and FSR3 working once you enable FSR2 (or DLSS) in select games.

## Notes  
- **If you are on linux,** you need to add an environment variable `WINEDLLOVERRIDES="winmm=n,b"` to get the mod to work.  
    - For Steam games you can do that by adding `WINEDLLOVERRIDES="winmm=n,b" %COMMAND%` into your launch parameters in game properties.  
- If the game requires a (fake) NVIDIA GPU, and you are currently using an AMD GPU, you need to extract `enable_fake_gpu.zip` next to the game executable.  
    - You can also manually set `fake_nvidia_gpu = true` in the mod's config file, `fsr2fsr3.config.toml`, which will be created after launching the game for the first time with the mod installed.  
    - You might get an outdated driver message on launch. This is expected, as the game tries to compare your AMD driver version with the much-larger NVIDIA driver versions, so it can safely be ignored.

## How to disable the Epic Games Store overlay  
Games bought from the Epic Store have a high chance of randomly crashing when the overlay is enabled.  
To disable it, follow these steps:  
1.  Go into your Epic Games Store installation folder (usually `C:/Program Files (x86)/Epic Games/Launcher`)  
2.  Navigate to `Portal/Extras/Overlay`  
3. Rename `EOSOverlayRenderer-Win32-Shipping.exe` and `EOSOverlayRenderer-Win64-Shipping.exe` to something else, like `disabled-EOSOverlayRenderer.exe`

## How to upgrade from an earlier version  
- Follow the *How to uninstall* section.  
- If you had the old proxy installed, also delete *dxgi.dll*.  
- Follow the installation instructions.

## How to uninstall  
Delete the following files:  
- winmm.dll  
- winmm.ini  
- lfz.sl.dlss.dll  
- fsr2fsr3.config.toml  
- fsr2fsr3.log  
- fsr2fsr3.asi  
- nvngx.dll  