# PaperMCServer
This Dockerfile (entrypoint is tini) will build an Alpine-image based Paper Minecraft Server with openjdk11
It has two parts. The first part downloads a jar file from the paper api 
<https://paper.readthedocs.io/en/latest/site/api.html>. Executing the downloaded jar will then download 
the minecraft server jar file from Mojang and patch it. The patched jar is copied to the second container which 
will be used for runtime.

## What is PaperMC?
Citation: "Paper is the next generation of Minecraft server, compatible with Spigot plugins and offering uncompromising performance."

Get more information here <https://papermc.io/> and here https://paper.readthedocs.io/
The project is present on github, see here <https://github.com/PaperMC>

### What is Minecraft?
Have you been living under a rock ;-) ? The game Minecraft has sold over 180,000,000 copies (November 18, 2011) according to Wikipedia

## Dockerimage 
You can get the built container image from
<https://hub.docker.com/repository/docker/s1mmel/papermcserver>

Sign in and pull the image
`docker pull s1mmel/papermcserver`

## ToDo's
* Clean up mess
* more bash less Dockerfile
* thinking about separating build and runtime
* group, mark and describe variables/parameters, etc.
* make a small concept for a mod/config pack 

## License Agreement
The "Code" and the files in this repo are free to use for everyone and come with the attached License, BUT....
please be aware that once you build and/or run this container and especially the modified minecraft server in it, additional Licenses apply.

* See the EULA from Mojang here <https://account.mojang.com/documents/minecraft_eula>
* See the license from Paper here <https://github.com/PaperMC/Paper/blob/master/LICENSE.md>
* See the license from openjdk here <https://openjdk.java.net/legal/gplv2+ce.html>
* Alpine Linux? you don't see it here <https://alpinelinux.org/about/>

## Wishlist

The server is already up and running, but I'd like to implement 

* paperd daemon if possible (in combination with tini) 
<https://github.com/PaperMC/paperd/blob/master/usage.md>

* additional installation and configuration parameters for the server itself 
<https://paper.readthedocs.io/en/latest/server/configuration.html>
<https://www.spigotmc.org/wiki/spigot-configuration/?__cf_chl_jschl_tk__=f0cd0d62e096ffbadb18109cdd7f0710dee5f42c-1587708828-0-Acu_01JQuiTPf4nsQrxdK56Yx4d98bsn6AgmivvE377DIvrmVnEZR0fEPsJcN7teURbOX5iDs0b8EctPYBzQTAkm1C3Q8wEqLJXKxhUei8C6ZmSs3kfdHUsCyqoj5JK9UfMSNu5jzy_B4vtiM-z9NVJ1b7hXP56qsPueignz4k7vrFolj6dk1hSDNSCXUh0PBO4Z3wnrNNXs5bPbLm-d8Ty3BvB4Simqu80WVtm1dGw7vhbVJvrEz2EbtkfOpQwPkfBILpnqO3j-5eAFDBCqzy-2Y7J7VsB9vyWnc-qXFSrJq7cdRq9b5VyxelhHTToLiA>

* additional installation and configuration parameters for the most popular mods
<https://apexminecrafthosting.com/recommended-bukkit-plugins/>
<https://www.spigotmc.org/threads/guide-bugeting-a-server-aka-surviving-the-eula.31789/>
<https://www.spigotmc.org/threads/guide-server-optimization%E2%9A%A1.283181/>
<https://www.curseforge.com/minecraft/bukkit-plugins/minecraft-market-free-donation>
<https://www.notion.so/Craftadia-Guides-b4612d4c1edf441296487f5710d4ee38>
<https://bukkit.org/>
<https://www.spigotmc.org/resources/auctionhouse.61836/>
<https://thebreakdown.xyz/top-10-plugins-for-bukkit-spigot-servers/>

* open up ssh for further configuration 

* optional mysql-db as docker container if there are plugins with db support


