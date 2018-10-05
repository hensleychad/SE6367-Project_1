#!/bin/bash


### GLOBALS
WORKING_DIR=$1
SPELL_CMD=$2
INPUT_DIR="${WORKING_DIR}/input"
DICT_DIR="${WORKING_DIR}/dictionary"

LOG_DIR="${WORKING_DIR}/log"
OUTPUT_FILE="${LOG_DIR}/Hensley-Test.Output"
ERROR_FILE="${LOG_DIR}/Hensley-Test.Error"
#TEST_ARRAY=(standard_test help_test ispell_version spell_version other_dictionary ispell_program all_chains print_file_name print_numbers_on_lines print_words_not_literally_found print_stems test_empty_file  test_upsupported_flag)
TEST_ARRAY=(other_dictionary)
ERROR_MSG="Check Error Log, ${ERROR_FILE}"

WHICH_CMD="/usr/bin/which"
TOUCH_CMD=`${WHICH_CMD} touch`
RM_CMD="${WHICH_CMD} rm"
ECHO_CMD="${WHICH_CMD} echo"



###############  START Pre-Flight checks  ###################3
  touch_error_file() {
   if [ ! -e ${ERROR_FILE} ]; then
    touch ${ERROR_FILE}
    ${ECHO_CMD} "Creating error log, if not you miss first timestamp in error file"
   fi
  }

  check_input_dir_exist() {
   if [ ! -d ${INPUT_DIR} ]; then
    echo "${INPUT_DIR}: not found"
    exit 1
   else
    ${ECHO_COMMAND} "Input directory is  ${INPUT_DIR}"
   fi
  }

  check_wrking_dir_exist() {
   if [ ! -d ${WORKING_DIR} ]; then
    echo "${WORKING_DIR}: not found"
    usage
    exit 1
   else
    echo "Working directory is  ${WORKING_DIR}"
   fi
  }

  check_dict_dir_exist() {
   if [ ! -d ${DICT_DIR} ]; then
    echo "${DICT_DIR}: not found"
    exit 1
   else
    echo "Dictionary files can be found at ${DICT_DIR}"
   fi
  }

  check_log_dir_exist() {
   if [ ! -d ${LOG_DIR} ]; then
    echo "${LOG_DIR}: not found"
    exit 1
   else
    echo "Output and error logs can be found at ${LOG_DIR}"
   fi
  }

  spell_cmd_check() {
   if [ ! -f ${SPELL_CMD} ]; then
    echo ":${SPELL_CMD}: not found"
    usage
    exit 1
   else
    echo "Using spell command: ${SPELL_CMD}"
   fi
  }

###############  END  Pre-Flight checks  ###################3

###############  START  Utils  ###################3

  usage() {
    echo "Usage: $0 <Working Directory> <Shell Command Location e.g. /usr/bin/shell>"
  }

  log_it() {
    echo -e "[`date`] - ${*}" >> ${OUTPUT_FILE}
  }

  mark_it() {
    echo -e "[`date`] - ${*}" >> ${ERROR_FILE}
  }

  clean_logs() {
   if [ -f $OUTPUT_FILE ]; then
     echo "Cleaning up log file ${OUTPUT_FILE}"
     ${RM_CMD} ${OUTPUT_FILE}
   fi
  }

  clean_error_logs() {
   if [ -f $ERROR_FILE ]; then
     echo "Cleaning up error file ${ERROR_FILE}"
     ${RM_CMD} ${ERROR_FILE}
   fi
  }

  add_buffer() {
    echo -e "[`date`] \n++\n++\n++\n++" >> ${OUTPUT_FILE}
  }

  pre_flight_check() {
    check_wrking_dir_exist
    spell_cmd_check
    check_input_dir_exist
    check_dict_dir_exist
    check_log_dir_exist
    clean_logs
    clean_error_logs
    touch_error_file
  }

###############  END  Utils  ###################3

###############  START  Tests  ###################3
  standard_test() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start input file testing #####"
    log_it "Clean test - Test sample file against spell"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End input file testing #####"
    log_it "############################################"
    add_buffer
  }

  help_test() {
    cmd_string="${SPELL_CMD} --help 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start Show help test case #####"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${SPELL_CMD} --help 2> ${ERROR_FILE}`
    log_it "NOTE: The help flag echos the the usage of spell STDOUT then writes the help menu to STDERR. See ${ERROR_FILE} for help menu output"
    log_it "Output:\n$cmd"
    log_it "-- End Show help test case #####"
    log_it "############################################"
    add_buffer
  }

  ispell_version() {
    cmd_string="${SPELL_CMD} -I 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start print ispell version #####"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${SPELL_CMD} -I 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print ispell version #####"
    log_it "############################################"
    add_buffer
  }

  spell_version () {
    cmd_string="${SPELL_CMD} --version 2>${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start print version number  #####"
    log_it "Exeucting the following command: ${cmd_string}"
    log_it "NOTE: The --version flag echos version output to STDERR and nothing to STDOUT. See ${ERROR_FILE} for version output"
    cmd=`${SPELL_CMD} --version 2>${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print version number #####"
    log_it "############################################"
    add_buffer
  }

  other_dictionary() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --dictionary=${DICT_DIR}/british-english 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start  use other file to look up words #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    log_it "NOTE: The --dictionary/-d flag echos to both STDERR and STDOUT. See ${ERROR_FILE} for error output"
    mark_it "Start ERROR from $cmd_string"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample --dictionary=${DICT_DIR}/british-english 2> ${ERROR_FILE}`
    mark_it "End ERROR from $cmd_string"
    log_it "Output:\n$cmd"
    log_it "-- End  use other file to look up words #####"
    log_it "############################################"
    add_buffer
  }

  ispell_program() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --ispell 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start  Calls PROGRAM as Ispell #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${cmd_string}`
    log_it "Output:\n$cmd"
    log_it "-- End  Calls PROGRAM as Ispell #####"
    log_it "############################################"
    add_buffer
  }

  all_chains() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample -l 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start caompatibility  #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${cmd_string}`
    log_it "Output:\n$cmd"
    log_it "-- End  caompatibility #####"
    log_it "############################################"
    add_buffer
  }

  print_file_name() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --print-file-name 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start print-file-name #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${cmd_string}`
    log_it "Output:\n$cmd"
    log_it "-- End print-file-name #####"
    log_it "############################################"
    add_buffer
  }

  print_numbers_on_lines() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --number 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start print numbers before lines #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${cmd_string}`
    log_it "Output:\n$cmd"
    log_it "-- End print numbers before lines #####"
    log_it "############################################"
    add_buffer
  }

  print_stems() {
    cmd_tring="${SPELL_CMD} ${INPUT_DIR}/sample --print-stems 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start print-stems #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${cmd_string}`
    log_it "Output:\n$cmd"
    log_it "-- End print-stems #####"
    log_it "############################################"
    add_buffer
  }

  print_words_not_literally_found() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample -v 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start print words not literally found #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${cmd_string}`
    log_it "Output:\n$cmd"
    log_it "-- End print words not literally found #####"
    log_it "############################################"
    add_buffer
  }

  test_upsupported_flag() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample -q 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start test of unsupported flag #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample -q 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End test of unsupported flag #####"
    log_it "############################################"
    add_buffer
  }

  test_empty_file() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_none 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "############################################"
    log_it "-- Start does not exist #####"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_none 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End does not exist #####"
    log_it "############################################"
    add_buffer
  }

  run_tests() {
    echo "Test count  ${#TEST_ARRAY[@]}"
    echo "Results can be found in ${OUTPUT_FILE}"
    echo "Errors can be found in ${ERROR_FILE}"
    for test_method in "${TEST_ARRAY[@]}"
    do
      log_it "Running ${test_method}"
      ${test_method}
    done
  }

###############  END  Tests  ###################3

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: $0 <Working Directory> <Shell Command Location e.g. /usr/bin/shell>"
    exit 1
fi

  touch_error_file
  #pre_flight_check
  #run_tests
