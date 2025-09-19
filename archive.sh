#!/bin/bash

helper() { echo "archive.sh functions:" ; echo "Accepts two command-line arguments: $0 [Source_Directory] [Target_Directory]"; echo "Creates a new folder in Target_Directory with timestamps"; echo "Copies all files from [Source_Directory] to [Target_Directory]"; echo "Input --help or -h for help"; }

if [[ $1 == "-h" || $1 == "--help" ]]; then helper;
else echo "Not a Command"; fi
