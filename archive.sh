#!/bin/bash

source ./archive.conf

logInfo() { local message="INFO: [$(date '+%y-%m-%d %H:%M:%S')] $1"; echo "$message"; echo "$message" >> "archive.log"; }

logError() { local message="ERROR: [$(date '+%y-%m-%d %H:%M:%S')] $1";   echo "$message"; echo "$message" >> "archive.log"; }

helper() { echo "archive.sh functions:" ; echo "Accepts two command-line arguments: $0 [Source_Directory] [Target_Directory]"; echo "Creates a new folder in Target_Directory with timestamps"; echo "Copies all files from [Source_Directory] to [Target_Directory]"; >
if [[ $1 == "-h" || $1 == "--help" ]]; then helper; exit 1; fi

if [[ -n "$1" ]]; then sourceDir="$1"; fi

if [[ -n "$2" ]]; then targetDir="$2"; fi

logInfo "Archive scipt started."

if [ ! -d $sourceDir ]; then logError "Source directory ($sourceDir) does not exist or is not readable. Exiting."; exit 1;
elif [ ! -d $targetDir ]; then logError "Target directory ($targetDir) does not exist or could not be created. Exiting."; exit 1;
else backup="$targetDir/backup_$(date +%y%m%d)_$(date +%H%M%S).tar.gz"; tar -czf "$backup" -C "$(dirname "$sourceDir")" "$(basename "$sourceDir")"; logInfo "Backing up from $sourceDir to $targetDir/backup_$(date +%y%m%d)_$(date +%H%M%S).tar.gz."
    if [[ $? -eq 0 ]]; then
        logInfo "Backup completed successfully."
    else
        logError "Backup failed during compression."
        exit 1
