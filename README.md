**What?**

Attempt to fix, stabilize and optimize VRmod for Garry's Mod x64. 
Developed and tested with Quest 2 on Linux OS. 
Work in progress at early stage, don’t have high expectations. :)

Pescorr's Semi- Offical Version didn't not start, so I integrated most or the changes that worked for me into the Catse's original version. Additionally I test and fix related addons and try to optimize the whole thing as one big project. 

**Why?**

VRmod and it's parts such as hand physics,melee attacks and such are maintained by different authors. In some cases like with physics mod and melee mod, both create exactly the same props to be used as collision detection, so ideally one must avoid such cases.  


**How?**

1) Make sure SteamVR is set up and you have no problems running other games. 
2) Make sure you can run gmod x64 on your system. On Linux it’s required to run GModCEFCodecFix
3) I encourage everyone to compile their own module, but in case you can’t be bothered I build these on kUbuntu 24.04
https://github.com/catoni0/vrmod-module-master/tree/main/install

4) You might wanna run original version once, moreover you can fix it youself by changing the required version in vrmod api and you don’t have to use my mess. 

    Or you can download mine and place it here:
    $HOME/.steam/steam/steamapps/common/GarrysMod/garrysmod/addons/
    Probably will need to rename addon from vrmod-master to vrmod, as sometimes name can cause addon not to load. 

5) If you are lucky enough to have Quest 2, look for “Quest 2 vrmod by Doom Slayer” controller bindings


**Known issues:**

In order to restart the vrmod, it’s required to restart the game, otherwise the it would be pixelated mess in HMD


Need to install and launch original VRmod by Catse once


**The projects is reorganized and contains works of various authors:**

Cats - original VRmod creator
Pescorr - semiofficial VRmod creator, melee, hostler (I used the code to drop the weapons on release) 
Wheatley126 - VRmod-Plus
Hugo - manual pickup,simple hand physics and hl2 weapon replacer
Arctic - ArcVR

Might be more, contact me to be included
