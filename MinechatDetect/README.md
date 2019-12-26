# MineChat message detector
This script is to react to the default login message that MineChat outputs.
e.g Send a different welcome message.

## How to run
* Set up a datapack function to be executed for this purpose in the minecraft server.
* First, review all settings in script.sh and run.sh.
* run ./run.sh
* Enjoy outdoors.

## Notes:
* It'll only work on players who have the lite version of the app, or have the pro version without removing the login message.
* Will work cross-language, as 'MineChat' is the name of the app and has no translation for it.
* Regular players can trigger it by saying 'MineChat', but only if the M and the C is capitalized.

## To-Do
* Add minor redundancies to invalid settings

## Requirements:
* Linux server running a [minecraft server](http://minecraft.net/download/server/) and is accessable via SSH.
* To have both script.sh and 2script.sh in the same directory.
* Have a id_rsa file for the SSH host.

# Dependencies
* expect - We need to use the command [unbuffer](http://manpages.ubuntu.com/manpages/eoan/en/man1/expect_unbuffer.1.html) from it.
* [Tmux](https://linux.die.net/man/1/tmux) - We use this instead of screen, as we need to have it export the script output to a known file.
* [mcrcon](https://github.com/Tiiffi/mcrcon) - We need this in order to send rcon commands to the server to execute a function.

## Disclaimer
I am personally using an earlier version of this script, and I cleaned it up for easier use by the public but I have not tried this with the edits.
It should still work fine, I didn't add features -- only settings and vairables in-place of manual commands.

