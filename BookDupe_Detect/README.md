## BookDupe Detector
This script will aid in catching players with one or more of the needed resources to execute the common duplication bug in your minecraft server.
The script has to be ran on the machine hosting the minecraft server, or you'll need to constantly need an up-to-date download of all playerdata files on the machine you wish to run it on.

# What?
The script checks for player data files which are larger than a specific size (default, 20kb)
as players have to create something called a Dupe Book, which has 50 pages of random characters that minecraft cannot compress.
With only one book I have found it to grow the player file to a bit more than 20 Kiliobytes,
which is very unusual for a playerdata file (usual sizes vary around 7kb).

# How does it help?
The player file that triggered the detector will get uploaded to a FTP server that you specify so that in the case where
the player tries to destroy/hide all evidence of the books, you will have a cached copy of the moment it was caught.
All you would need to do is look through the NBT data for INV or EnderChest Items matching a book with 50 pages of characters.

# Dependancies
The following are all required.
* IFTTT account with a webhook applet created for this
* lftp
* Minecraft server

You will also need an NBT viewer of your choice.
You could try [DriveHQ}(https://drivehq.com) for the FTP server as you get 1GB free, whcih is plenty.
