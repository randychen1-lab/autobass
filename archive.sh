#!/bin/bash

logInfo() { local message="INFO: [$(date '+%y-%m-%d %H:%M:%S')] $1"; echo "$message"; echo "$message" >> "archive.log"; }

logError() { local message="ERROR: [$(date '+%y-%m-%d %H:%M:%S')] $1";	 echo "$message"; echo "$message" >> "archive.log"; }

helper() { echo "archive.sh functions:" ; echo "Accepts two command-line arguments: $0 [Source_Directory] [Target_Directory]"; echo "Creates a new folder in Target_Directory with timestamps"; echo "Copies all files from [Source_Directory] to [Target_Directory]"; echo "Input --help or -h for help"; }

if [[ $1 == "-h" || $1 == "--help" ]]; then helper; fi
logInfo "Archive scipt started."
if [[ $1 == "" || $2 == "" ]]; then logError "Not a command.";
elif [[ ! -d $1 && ! -d $2 ]]; then logError "Source directory ($1) and target directory ($2) aren't existing directories.";
elif [ ! -d $1 ]; then logError "Source directory ($1) does not exist or is not readable. Exiting."; exit 1;
elif [ ! -d $2 ]; then logError "Target directory ($2) does not exist or could not be created. Exiting."; exit 1;
else backup="$2/backup_$(date +%y%m%d)_$(date +%H%M%S).tar.gz"; tar -czf "$backup" -C "$(dirname "$1")" "$(basename "$1")"; logInfo "Backing up from $1 to $2/backup_$(date +%y%m%d)_$(date +%H%M%S).tar.gz."
    if [[ $? -eq 0 ]]; then
        logInfo "Backup completed successfully."
    else
        logError "Backup failed during compression."
        exit 1
    fi
fi
