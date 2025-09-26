AutoBass Project Description:
Help tool: -h or --help to prompt a help tool.
Compression: Compresses files and subfolders found in source directory into a tar.gz file found in target directory.
Logging and Error detection: Archives all commands and events (successes and errors) in "archive.log".
Configuration: Implementation of source and target default paths that can be found in "archive.conf".
Exclusions: Excludes the file types found in the ".bassignore" file.
Dry Run: -d or --dry-run with Source and Target directories to prompt a dry run. 

Installation instructions:
Download:
You can clone the repository from github (command prompt):
git clone https://github.com/randychen1-lab/autobass.git (if using URL)
git clone git@github.com:randychen1-lab/autobass.git (if using SSH)
cd autobass

Make script executable:
chmod +x archive.sh

Usage (command prompt):
./archive.sh -h or ./archive.sh --help prompts help tool
./archive.sh -d [Source Directory] [Target Directory] or ./archive.sh --dry-run [Source Directory] [Target Directory] to dry run potential compression
./archive.sh [Source Directory] [Target Directory] to run compression 

Configuration
config file (archive.conf): Allows you to change the source and target default paths by replacing file name enclosed in quotations ("").
exclude file (.bassignore): Allows you to change the excluded file types, simply type in file type, one per line.
Can access and edit file by typing: nano [file_name]

