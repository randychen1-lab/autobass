#!/bin/bash

helper() { echo "archive.sh functions:" ; echo "Accepts two command-line arguments: $0 [Source_Directory] [Target_Directory]"; echo "Creates a new folder in Target_Directory with timestamps"; echo "Copies all files from [Source_Directory] to [Target_Directory]"; echo "Input --help or -h for help"; }

if [[ $1 == "-h" || $1 == "--help" ]]; then helper;
elif [[ $1 == "" || $2 == "" ]]; then echo "Not a command";
elif [[ ! -d $1 && ! -d $2 ]]; then echo "$1 and $2 aren't existing directories";
elif [ ! -d $1 ]; then echo "$1 isn't an existing directory";
elif [ ! -d $2 ]; then echo "$2 isn't an existing directory";
else backup="$2/backup_$(date +%y%m%d)_$(date +%H%M%S)"; mkdir -p $backup;
fi
