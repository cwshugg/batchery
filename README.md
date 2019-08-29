# A Fresh Batch of ... Batches
This is a repository I'm using to hold some of the more involved batch scripts I've written for my Windows computer. I put them on GitHub in the event that someone like you could benefit from them!

# The Scripts
Here are some brief summaries of the scripts I've uploaded:
## gsync
This is a relatively simple script that starts and stops Google Backup & Sync when run. As my Google Drive became more and more full, I got sick of Backup & Sync taking up half my CPU for 2 hours straight to keep up with all my ~~garbage~~ files. So, I disabled Backup & Sync from running automatically, and wrote this script to trigger it whenever I felt like giving my compuer the time needed to sync everything up.
#### Running
To run this, call it's name in CMD, and that's it. Depending on if the "googledrivesync.exe" process is running or not, it will be started or stopped.

## gsynct
This is a more involved version of gsync, but with a built-in timer. This takes in up to 2 command-line arguments, the main one being a time (number of seconds). This launches Backup & Sync, waits for the given amount of seconds, then closes Backup & Sync. The third command-line argument is optional: "-s". If this argument is provided, the script will shut down Windows after the given time interval.
#### Running
To run: type "gsynct [time] [shutdown?]", with [time] being some number (of seconds), and [shutdown?] being either "-s" or blank. You can also simply type "gsynct", and it will default to running Backup & Sync for 3600 seconds (1 hour) without the automatic shutdown.

## clean
This script empties out the recycling bin and the downloads folder, and launches Window's built-in disk-cleanup script.

## clean_setup
A set-up script that launches the Window's disk-cleanup script in configuration mode, allowing you to choose what files you want to be cleaned when Disk Cleanup is run.
