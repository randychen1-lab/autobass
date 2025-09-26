#!/bin/bash

source ./archive.conf

logInfo() { local message="INFO: [$(date '+%y-%m-%d %H:%M:%S')] $1"; 
    echo "$message";
    echo "$message" >> "archive.log"; }

logError() { local message="ERROR: [$(date '+%y-%m-%d %H:%M:%S')] $1";
    echo "$message";
    echo "$message" >> "archive.log"; }

helper() { echo "archive.sh functions:";
    echo "Accepts two command-line arguments: $0 [Source_Directory] [Target_Directory]";
    echo "Creates a new folder in Target_Directory with timestamps";
    echo "Copies all files from [Source_Directory] to [Target_Directory]";
    echo "Input $0 --dryRun [Source Directory] [Target Directory] or -d [Source Directory] [Target Directory]";
    echo "Input $0 --help or $0 -h for help"; }

if [[ $1 == "-h" || $1 == "--help" ]]; then helper; exit 1; fi

dryrun=false
if [[ $1 == "-d" || $1 == "--dry-run" ]]; then dryrun=true; shift; fi

if [[ -n "$1" ]];
    then sourceDir="$1"; fi

if [[ -n "$2" ]];
    then targetDir="$2"; fi

logInfo "Archive script started."

if [[ -f ".bassignore" ]]; then
    while IFS= read -r file; do
        [[ -z "$file" || "$file" =~ ^# ]] && continue
        exclude_args+=("--exclude=$file");
    done < ".bassignore"
fi

if [[ ! -d $sourceDir ]]; then
    logError "Source directory ($sourceDir) does not exist or is not readable. Exiting.";
    exit 1;
elif [[ ! -d $targetDir ]]; then logError "Target directory ($targetDir) does not exist or could not be created. Exiting."; exit 1;
elif $dryrun; then 
    logInfo "Dry-run enabled. Simulating backup.";
    echo "Runs:";
    echo "backup=$targetDir/backup_$(date +%y%m%d)_$(date +%H%M%S).tar.gz";
    echo "tar -czf ${exclude_args[@]} $backup -C $(dirname $sourceDir)";
    echo "$(basename $sourceDir)""; echo INFO: [$(date '+%y-%m-%d %H:%M:%S')] Backing up from $sourceDir to $targetDir/backup_$(date +%y%m%d)_$(date +%H%M%S).tar.gz.X"
else
    backup="$targetDir/backup_$(date +%y%m%d)_$(date +%H%M%S).tar.gz";
    tar -czf "$backup" "${exclude_args[@]}" -C "$(dirname "$sourceDir")" "$(basename "$sourceDir")";
    logInfo "Backing up from $sourceDir to $targetDir/backup_$(date +%y%m%d)_$(date +%H%M%S).tar.gz.";
    if [[ $? -eq 0 ]]; then
        logInfo "Backup completed successfully."
    else
        logError "Backup failed during compression."
        exit 1
    fi
fi
