# How to install FSR2FSR3

Some prerequisites:
- **Turn off the Epic Games Store overlay.** Instructions for this can be found in the "Notes section."
- **Turn off the RivaTuner/RTSS overlay if you have it enabled.**
These overlay will cause crashes otherwise. In general, the less overlays you have active, the better it should work.

## Regular FSR2FSR3 installation
First, find out which mod version you need. Two ways to achieve this:
**Automatic**: Go to https://mods.lukefz.xyz and check if your game is mentioned in the game dropdown. If it is, use that version.
**Manual**: Find out which version of FSR2 the game uses.
You can do this by using the PCGamingWiki.
NOTE: Certain games (Ratchet & Clank: Rift Apart) use a different implementation of FSR2, but might also be listed as using version 2.2 on the wiki.
You can detect these by looking for a file called `ffx_fsr2_x64.dll` in the game directory.
If your game has that file in its game directory, please use the *SDK* version of the mod.
Once you know which version of FSR2 the game uses, download the mod version corresponding to the FSR2 version from [the website](https://mods.lukefz.xyz).
2. Navigate to your game executable.
For most games this should be in the root game directory, but also check the Notes section for your game's compatibility list entry for any specific directory you might need to use instead.
For Unreal Engine games, you should use the executable ending with `-Shipping.exe`, which should be in a subdirectory. Do **not** use the executable found in the root game directory!
4. Extract the downloaded mod archive into the folder with the game executable.
5. Launch the game. If everything worked correctly, there should be a new console window with a few log messages and FSR3 working once you enable FSR2 (or DLSS in select games.

## Notes
- **If you are on linux,** you need to add an environment variable `WINEDLLOVERRIDES="winmm=n,b"` to get the mod to work.
    - For Steam games you can do that by adding `WINEDLLOVERRIDES="winmm=n,b" %COMMAND%` into your launch parameters in game properties.
- If the game requires a (fake) NVIDIA GPU, and you are currently using an AMD GPU, you need to extract `enable_fake_gpu.zip` next to the game executable.
    - You can also manually set `fake_nvidia_gpu = true` in the mod's config file, `fsr2fsr3.config.toml`, 
    which will be created after launching the game for the first time with the mod installed.
    - You might get an outdated driver message on launch. This is expected, as the game tries to compare your AMD driver version with the much-larger NVIDIA driver versions, so it can safely be ignored.
- Some games might require you to add a nvngx.dll file next to the executable. To achieve this, copy the "nvngx.dll" from the "optional_nvngx_files" folder into the parent directory and run the "EnableSignatureOverride.reg" file.
    - On Linux, you need to run it in the wine-prefix for that specific game. You can do that via winetricks or *protontricks* for Steam games. 
Launch Protontricks, select the game, select OK on the default prefix, then choose an option to launch *regedit*. 
From there, in the top left select import and navigate to *EnableSignatureOverride.reg* and select it, confirm every popup.

## How to disable the Epic Games Store overlay
Games bought from the Epic Store have a high chance of randomly crashing when the overlay is enabled.
To disable it, follow these steps:
1.  Go into your Epic Games Store installation folder (usually `C:/Program Files (x86)/Epic Games/Launcher`)
2.  Navigate to `Portal/Extras/Overlay` 
3. Rename `EOSOverlayRenderer-Win32-Shipping.exe` and `EOSOverlayRenderer-Win64-Shipping.exe` to something else, like `disabled-EOSOverlayRenderer.exe`

## How to enable the Fake GPU or AMD Unreal Engine Workaround
1. Find the correct config (fsr2fsr3.config.toml, launch the game once to create it) entry:
Fake GPU: `fake_nvidia_gpu`
AMD Workaround: `amd_unreal_engine_dlss_workaround`
2. Change `false` to `true` next to it

## How to enable DLSS Frame Generation in Nixxes Games (Spider-Man, Miles Morales, Ratchet & Clank)
- Add `-forceReflexMarkers` to the launch arguments.

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