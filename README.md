**Attempt to fix, stabilize and optimize VRmod for Garry's Mod x64.**

Developed and tested with Quest 2/Quest 3 on Linux OS (kUbuntu 24.04)

Native Linux gmod build have some issues, use Proton GE for now (Should work on Windows too)

**Optimization problem:**

VRmod and it's parts such as hand physics,melee attacks and such are maintained by different authors. In some cases like with physics mod and melee mod, both create exactly the same props to be used as collision detection, so ideally one must avoid such cases.

**Known issues:**

* In order to restart the vrmod on Linux native build, it’s required to reload the map/restart game, otherwise the it would be pixelated mess in HMD
* Might Need to install and launch original VRmod once
* For some reason native build will not work without [this](https://github.com/SligWolf/sligwolf_addon_base/releases/tag/v2023-07-28) and [that](https://steamcommunity.com/sharedfiles/filedetails/?id=3008753645) (older version)

**Installation:**

Make sure you can run gmod x64 on your system. On Native Linux version it’s required to run [GModCEFCodecFix](https://github.com/solsticegamestudios/GModCEFCodecFix)

Either [download precompiled module](https://github.com/catoni0/vrmod-module-master/tree/main/install) for native build or [compile your own](https://github.com/catsethecat/vrmod-module). Binaries for Linux have a higher module version.
Windows/Proton would work with original files.

I also uploaded control sheme to Steam under the "Doom Slayer" name for Quest2/3

**The projects is reorganized and contains works of various authors:**

Catse, original VRmod creator
Pescorr, semiofficial VRmod creator, melee, hostler (I used the code to drop the weapons on release)
Wheatley126, VRmod-Plus
Hugo, manual pickup,simple hand physics and hl2 weapon replacer
Arctic for ArcVR

Might be more, contact me to be included
