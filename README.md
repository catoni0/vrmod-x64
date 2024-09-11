**VRmod for Native Linux Garry's Mod x64 build - AIO Package**

While Native Linux build have some issues, it loads way faster than under Proton.

If you want more stability use Proton GE 9-10 or Proton 9.0-2.


**Optimization problem:**

VRmod and its components, such as hand physics and melee attacks, are maintained by different authors. In some cases, they conflict with each other, and some addons are abandoned or broken.

Apart from that there are rendering problems on Linux build and image is not optimized Quest 2/3. 


**Additional info abot this version of VRmod:**

* Integrated collision physics, melee, (fixed) manual pickup
* Developed and tested with Quest 2/Quest 3 on Linux OS (kUbuntu 24.04)
* Mostly fixed rendering issues on Linux native build
* Tailored for Quest 3 to avoid fish eye effect and distorted image when tilting head.
* Should work on Windows too (not tested)


**Known issues:**

* In order to restart the vrmod on Linux native build, it’s required to reload the map/restart game, otherwise the it would be pixelated mess in HMD
* Might Need to install and launch original VRmod once

**Installation:**

Make sure you can run gmod x64 on your system. On Native Linux version it’s required to run [GModCEFCodecFix](https://github.com/solsticegamestudios/GModCEFCodecFix)

Either [download precompiled module](https://github.com/catoni0/vrmod-module-master/tree/main/install) for native build or complie your own.

Place vrmod folder in HOME/.steam/steam/steamapps/common/GarrysMod/garrysmod/addons/


**Credits:**

The projects is reorganized and contains works of various authors:


*Catse*, original VRmod creator

*Pescorr*, semiofficial VRmod creator, melee, hostler (I used the code to drop the weapons on release)

*Wheatley126*, VRmod-Plus

*Hugo*, manual pickup,simple hand physics and hl2 weapon replacer

*Arctic* for ArcVR

SligWolf for alpha 0 image from SW_ADDONS


Might be more, contact me to be included...


Big Thank You to *Grocel* for helping me to figure how SW_Addons unintentianally fixed rendering issues
