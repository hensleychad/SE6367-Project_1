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
WORKING_DIR=$1
#SPELL_CMD="/usr/bin/spell"
SPELL_CMD=$2
INPUT_DIR="${WORKING_DIR}/input"

### Not sure this will be used
LOG_DIR="${WORKING_DIR}/log"
OUTPUT_FILE="${LOG_DIR}/Hensley-Test.Output"
ERROR_FILE="${LOG_DIR}/Hensley-Test.Error"


if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: $0 <Working Directory> <Shell Command Location e.g. /usr/bin/shell>"
    exit 1
fi

echo "###### Start input file testing #####

echo "############################################"
echo "Clean test - Test sample file against spell"
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample

echo "############################################"
echo "Destructive test - File empty"
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/empty_sample

echo "############################################"
echo "Destructive test - File does not exist"
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample_none

echo "###### End input file testing #####"


echo "###### Start  #####"
echo "############################################"
echo "Help test - Show help"
#   -h, --help                          Print a summary of the options.
echo "############################################"
${SPELL_CMD} -h
${SPELL_CMD} --help
echo "###### End  #####"


echo "###### Start  #####"
echo "############################################"
echo "   -I, --ispell-version                        Print Ispell's version."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -I
${SPELL_CMD} ${INPUT_DIR}/sample --spell-version
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "   -V, --version                               Print the version number."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -V
${SPELL_CMD} ${INPUT_DIR}/sample --version
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -b, --british                               Use the British dictionary."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -b
${SPELL_CMD} ${INPUT_DIR}/sample --british
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -d, --dictionary=FILE                       Use FILE to look up words."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -d
${SPELL_CMD} ${INPUT_DIR}/sample --dictionary
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -i, --ispell=PROGRAM                        Calls PROGRAM as Ispell."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -i
${SPELL_CMD} ${INPUT_DIR}/sample --ispell
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -l, --all-chains                    Ignored; for compatibility."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -l
${SPELL_CMD} ${INPUT_DIR}/sample --all-chains
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -n, --number                                Print line numbers before lines."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -n
${SPELL_CMD} ${INPUT_DIR}/sample --number
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -o, --print-file-name                       Print file names before lines."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -o
${SPELL_CMD} ${INPUT_DIR}/sample --print-file-name
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -D, --ispell-dictionary=DICTIONARY  Use DICTIONARY to look up words."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -D
${SPELL_CMD} ${INPUT_DIR}/sample --ispell-dictionary
echo "###### End  #####"

"###### Start  #####"
echo "############################################"
echo "#   -s, --stop-list=FILE                        Ignored; for compatibility."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -s
${SPELL_CMD} ${INPUT_DIR}/sample --stop-list
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -v, --verbose                               Print words not literally found."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -v
${SPELL_CMD} ${INPUT_DIR}/sample --verbose
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -x, --print-stems                   Ignored; for compatibility."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -x
${SPELL_CMD} ${INPUT_DIR}/sample --print-stems
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "#   -q 	unsupported flag
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -q
echo "###### End  #####"

