#!/bin/bash


### GLOBALS
WORKING_DIR=$1
SPELL_CMD=$2
INPUT_DIR="${WORKING_DIR}/input"
DICT_DIR="${WORKING_DIR}/dictionary"

### Not sure this will be used
LOG_DIR="${WORKING_DIR}/log"
OUTPUT_FILE="${LOG_DIR}/Hensley-Test.Output"
ERROR_FILE="${LOG_DIR}/Hensley-Test.Error"
TEST_ARRAY=(standard_test help_test ispell_version)

  logit() 
  {
    echo "[`date`] - ${*}" >> ${OUTPUT_FILE}
    #echo "[${USER}][`date`] - ${*}" >> ${OUTPUT_FILE}
  }

  add_buffer() {
    echo "" >> ${OUTPUT_FILE}
    echo "" >> ${OUTPUT_FILE}
    echo "" >> ${OUTPUT_FILE}
    echo "" >> ${OUTPUT_FILE}
  }


  standard_test() {
    logit "############################################"
    logit "###### Start input file testing #####"

    logit "############################################"
    logit "Clean test - Test sample file against spell"
    logit "############################################"
    logit "Executing ${SPELL_CMD} ${INPUT_DIR}/sample"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample`
    logit "$cmd"
    logit "###### End input file testing #####"
    add_buffer
  }

  help_test() {
    logit "############################################"
    logit "###### Start Show help test case #####"
    logit "############################################"
    logit "Help test - Show help"
    logit "   -h, --help                          Print a summary of the options."
    logit "############################################"
    cmd=`${SPELL_CMD} --help`
    logit "$cmd"
    logit "###### End Show help test case #####"
  }

  ispell_version() {
    logit "############################################"
    logit "###### Start print ispell version #####"
    logit "############################################"
    logit "   -I, --ispell-version                        Print Ispell's version."
    logit "############################################"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample -I`
    logit "$cmd"
    logit "###### End print ispell version #####"
  }

  for test_method in "${TEST_ARRAY[@]}"
  do
    echo "${test_method}"
    ${test_method}
  done

exit 0

  logit "###### Start print version number  #####"
  logit "############################################"
  logit "   -V, --version                               Print the version number."
  logit "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample --version
  logit "###### End print version number #####"
  logit "\n\n\n\n"


echo "###### Start  #####"
echo "############################################"
echo "#   -b, --british                               Use the British dictionary."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -b
${SPELL_CMD} ${INPUT_DIR}/sample --british
echo "###### End  #####"
echo ""
echo ""
echo ""
echo ""

echo "###### Start  #####"
echo "############################################"
echo "#   -d, --dictionary=FILE                       Use FILE to look up words."
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample --dictionary=${DICT_DIR}/british-english
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
echo "#   -q 	unsupported flag"
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample -q
echo "###### End  #####"

echo "###### Start  #####"
echo "############################################"
echo "Destructive test - File empty"
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/empty_sample

echo "############################################"
echo "Destructive test - File does not exist"
echo "############################################"
${SPELL_CMD} ${INPUT_DIR}/sample_none
echo "###### End  #####"
}


if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: $0 <Working Directory> <Shell Command Location e.g. /usr/bin/shell>"
    exit 1
fi

runTests
