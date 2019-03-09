## Minecraft solutions

This repository is a collection of small scripts that aid managing a minecraft server,
most scripts should be only single files, and do a specific task.
You will most likely have to manually schedule them using crontab.

## Book Dupe Detector

This script will help you catch players trying to exploit a Duplication bug, which is very easily catchable as long
as you can find them before they place them in a chest (outside of their NBT playerdata).

It will upload a copy of their data file for your viewing, as the player can easily dump the book while you have a copy of
when they had it on them or in their ender chest.

[BookDupe Detector](BookDupe_detector/README.md)
