# PaperMCServer

Disclaimer: Please see the License section, before using and/or bulding this Dockerimage

## Dockerimage 
You can get the built container image from
<https://hub.docker.com/repository/docker/s1mmel/papermcserver>

Sign in and pull the image
`docker pull s1mmel/papermcserver`

## Dockerfile

The Dockerfile (entrypoint is tini) will build an Alpine-image based Paper Minecraft Server with openjdk11
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
<https://www.spigotmc.org/threads/guide-optimizing-spigot-remove-lag-fix-tps-improve-performance.21726/>

* open up ssh for further configuration via winscp/sshfs and filezilla, add sshkeys

* optional mysql-db as docker container if there are plugins with db support

* add if condition for different gc with more then 12gb ram https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/

* pre-render the worlds with a range to the world border of 1M blocks (instead of 30m blocks unrendered)

* re-build/render certain worlds after 3 months or after an update via cronjob (to get the new netherite ores in 1.16 e.g.)

* rather then only setting a world border and pre-render, find out the settings, that the world does not have more then 1m blocks

* same render/setting galore for all the small worlds, like spawn and/or minigames etc.

## Considered Plugins For A Server Bundle

* Multiverse2-Core
* Multiverse2-Portals
* CleanroomGenerator
* FAWE > Worldedit
* WorldGuard
* EssentialsX
* ShopGUIPlus
* LuckPerms
* Essentials(X?)
* MCMMO costs money but source code is on github? https://github.com/mcMMO-Dev/mcMMO-Classic
* LiteBans also costs money https://www.spigotmc.org/resources/litebans.3715/
* ClearLagg
* Minepacks
* Playerwarps
* Veinminer
* Vault: https://TheBreakdown.xyz/VaultSpigot
* EssentialsX Permissions: https://TheBreakdown.xyz/EssentialsPerms
* Bukkit Color Codes: https://TheBreakdown.xyz/BukkitColorC...
* Minecraft Item IDs: https://TheBreakdown.xyz/MCItemIDs
* Scoreboard https://www.youtube.com/redirect?v=BtjouFfQlig&event=video_description&redir_token=KR_cQ5awYWNY40d8sLHWmgTmxRB8MTU4ODM2NDg1MUAxNTg4Mjc4NDUx&q=https%3A%2F%2Fwww.spigotmc.org%2Fresources%2Fscoreboard.14754%2F
* Custom GUI https://www.youtube.com/redirect?v=BtjouFfQlig&event=video_description&redir_token=KR_cQ5awYWNY40d8sLHWmgTmxRB8MTU4ODM2NDg1MUAxNTg4Mjc4NDUx&q=https%3A%2F%2Fwww.spigotmc.org%2Fresources%2Fcommand-panels-custom-guis.67788%2F
* jobs reborn https://www.spigotmc.org/resources/jobs-reborn.4216/
* Advanced Achievments https://www.youtube.com/redirect?v=8bC-GRUF7h4&redir_token=ROaZPgqbtqvE5d9O50SNSndalCh8MTU4ODM2NDg2N0AxNTg4Mjc4NDY3&event=video_description&q=https%3A%2F%2Fgoo.gl%2FZ47rjS
* Advanced Ban https://www.youtube.com/redirect?q=https%3A%2F%2Fwww.spigotmc.org%2Fresources%2Fadvancedban.8695%2F&v=LUwl896ZfaQ&redir_token=ZvHls4FiGvQy363VHYIXITQTyEF8MTU4ODM2NDg3MUAxNTg4Mjc4NDcx&event=video_description
* Core Protect https://www.youtube.com/redirect?q=https%3A%2F%2Fwww.spigotmc.org%2Fresources%2Fcoreprotect.8631%2F&v=LUwl896ZfaQ&redir_token=ZvHls4FiGvQy363VHYIXITQTyEF8MTU4ODM2NDg3MUAxNTg4Mjc4NDcx&event=video_description
* TigerReports https://www.youtube.com/redirect?q=https%3A%2F%2Fwww.spigotmc.org%2Fresources%2Ftigerreports.25773%2F&v=LUwl896ZfaQ&redir_token=ZvHls4FiGvQy363VHYIXITQTyEF8MTU4ODM2NDg3MUAxNTg4Mjc4NDcx&event=video_description
* Staff+ https://www.youtube.com/redirect?q=https%3A%2F%2Fwww.spigotmc.org%2Fresources%2Fstaff-the-ultimate-moderation-plugin-1-7-1-13.41500%2F&v=LUwl896ZfaQ&redir_token=ZvHls4FiGvQy363VHYIXITQTyEF8MTU4ODM2NDg3MUAxNTg4Mjc4NDcx&event=video_description
* AdminGUI
* WorldBorder https://www.spigotmc.org/resources/worldborder.60905/
* DynMap
* Anti-Xray https://www.youtube.com/watch?v=JWP45MDgRLc
*Epic Spawner https://www.youtube.com/watch?v=f0Seg6JYMlc
* factions?
