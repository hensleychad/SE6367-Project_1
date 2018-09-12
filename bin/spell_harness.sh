#!/bin/sh


# spell --help
# Usage: spell [OPTION]... [FILE]...
# This is GNU Spell, a Unix spell emulator.

#   -I, --ispell-version                        Print Ispell's version.
#   -V, --version                               Print the version number.
#   -b, --british                               Use the British dictionary.
#   -d, --dictionary=FILE                       Use FILE to look up words.
#   -h, --help                          Print a summary of the options.
#   -i, --ispell=PROGRAM                        Calls PROGRAM as Ispell.
#   -l, --all-chains                    Ignored; for compatibility.
#   -n, --number                                Print line numbers before lines.
#   -o, --print-file-name                       Print file names before lines.
#   -D, --ispell-dictionary=DICTIONARY  Use DICTIONARY to look up words.
#   -s, --stop-list=FILE                        Ignored; for compatibility.
#   -v, --verbose                               Print words not literally found.
#   -x, --print-stems                   Ignored; for compatibility.

# Please use Info to read more (type `info spell').


### GLOBALS
WORKING_DIR="/home/vagrant/SE6367-Project_1"
SHELL_CMD="/usr/bin/spell"
FILES_DIR="${WORKING_DIR}/files"

echo "############################################"
echo "Clean test - Test sample file against spell"
echo "############################################"
${SHELL_CMD} ${FILES_DIR}/sample


echo "############################################"
echo "Help test - Show help"
echo "############################################"
${SHELL_CMD} --help


echo "############################################"
echo "Show version -   -I, --ispell-version                     Print Ispell's version."
echo "############################################"
${SHELL_CMD} sample -I

echo "############################################"
echo "Destructive test - File empty"
echo "############################################"
${SHELL_CMD} ${FILES_DIR}/empty_sample

echo "############################################"
echo "Destructive test - File does not exist"
echo "############################################"
${SHELL_CMD} ${FILES_DIR}/sample_none

echo "############################################"
#echo "Destructive test - No file"
echo "############################################"
#${SHELL_CMD}
