#!/bin/bash


### GLOBALS
WORKING_DIR=$1
SPELL_CMD=$2
INPUT_DIR="${WORKING_DIR}/input"
DICT_DIR="${WORKING_DIR}/dictionary"

LOG_DIR="${WORKING_DIR}/log"
OUTPUT_FILE="${LOG_DIR}/Hensley-Test.Output"
ERROR_FILE="${LOG_DIR}/Hensley-Test.Error"
#TEST_ARRAY=(test_standard test_help test_ispell_version test_spell_version test_other_dictionary test_ispell_program test_all_chains test_print_file_name test_print_numbers_on_lines test_+print_words_not_literally_found test_print_stems test_empty_file  test_file_not_found test_unsupported_flag)
TEST_ARRAY=(test_unsupported_flag)
ERROR_MSG="Check Error Log, ${ERROR_FILE}"

###############  START Pre-Flight checks  ###################3
  touch_error_file() {
   if [ ! -e ${ERROR_FILE} ]; then
    touch ${ERROR_FILE}
    echo "Creating error log, if not you miss first timestamp in error file"
   fi
  }

  check_input_dir_exist() {
   if [ ! -d ${INPUT_DIR} ]; then
    echo "${INPUT_DIR}: not found"
    exit 1
   else
    echo "Input directory is  ${INPUT_DIR}"
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
     rm ${OUTPUT_FILE}
   fi
  }

  clean_error_logs() {
   if [ -f $ERROR_FILE ]; then
     echo "Cleaning up error file ${ERROR_FILE}"
     rm ${ERROR_FILE}
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

###############  END  Utils  ###################3

###############  START  Tests  ###################3
  test_standard() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start input file testing #####"
    log_it "Clean test - Test sample file against spell"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End input file testing #####"
    log_it "############################################"
    add_buffer
  }

  test_help() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} --help 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start Show help test case #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} --help 2> ${ERROR_FILE}`
    log_it "NOTE: test_help echos the the usage of spell STDOUT then writes the help menu to STDERR. See ${ERROR_FILE} for test_help output"
    log_it "Output:\n$cmd"
    log_it "-- End Show help test case #####"
    log_it "############################################"
    add_buffer
  }

  test_ispell_version() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} -I 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start print ispell version #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} -I 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print ispell version #####"
    log_it "############################################"
    add_buffer
  }

  test_spell_version () {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} --version 2>${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start print version number  #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    log_it "NOTE: test_spell_version echos to both STDERR and STDOUT. See ${ERROR_FILE} for test_spell_version output"
    cmd=`${SPELL_CMD} --version 2>${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print version number #####"
    log_it "############################################"
    add_buffer
  }

  test_other_dictionary() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --dictionary=${DICT_DIR}/british-english 2> ${ERROR_FILE}"
    log_it "############################################"
    mark_it "Start ERROR from $cmd_string"
    log_it "-- Start  use other file to look up words #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    log_it "NOTE: The --dictionary/-d flag echos to both STDERR and STDOUT. See ${ERROR_FILE} for test_other_dictionary output"
    log_it "NOTE: test_other_dictionary output will show usage  See ${ERROR_FILE} for test_unsupported_flag output"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample --dictionary=${DICT_DIR}/british-english 2> ${ERROR_FILE}`
    mark_it "End ERROR from $cmd_string"
    log_it "Output:\n$cmd"
    log_it "-- End  use other file to look up words #####"
    log_it "############################################"
    add_buffer
  }

  test_ispell_program() {
    cmd=""  #keep variable clean
    log_it "############################################"
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --ispell 2> ${ERROR_FILE}"
    log_it "-- Start  Calls PROGRAM as Ispell #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample --ispell 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End  Calls PROGRAM as Ispell #####"
    log_it "############################################"
    add_buffer
  }

  test_all_chains() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample -l 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start caompatibility  #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample -l 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End  caompatibility #####"
    log_it "############################################"
    add_buffer
  }

  test_print_file_name() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --print-file-name 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start print-file-name #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample --print-file-name 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print-file-name #####"
    log_it "############################################"
    add_buffer
  }

  test_print_numbers_on_lines() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --number 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start print numbers before lines #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample --number 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print numbers before lines #####"
    log_it "############################################"
    add_buffer
  }

  test_print_stems() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --print-stems 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start print-stems #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample --print-stems 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print-stems #####"
    log_it "############################################"
    add_buffer
  }

  test_print_words_not_literally_found() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample -v 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start print words not literally found #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample -v 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print words not literally found #####"
    log_it "############################################"
    add_buffer
  }

  test_unsupported_flag() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample -q 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start test of unsupported flag #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample -q 2> ${ERROR_FILE}`
    log_it "NOTE: test_unsupported_flag output will show usage  See ${ERROR_FILE} for test_unsupported_flag output"
    log_it "Output:\n$cmd"
    log_it "-- End test of unsupported flag #####"
    log_it "############################################"
    add_buffer
  }

  test_file_not_found() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_none 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start does not exist #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_none 2> ${ERROR_FILE}`
    log_it "NOTE: test_file_not_found output will show nothing.  See ${ERROR_FILE} for test_file_not_found output"
    log_it "Output:\n$cmd"
    log_it "-- End does not exist #####"
    log_it "############################################"
    add_buffer
  }

  test_empty_file() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/empty_sample 2> ${ERROR_FILE}"
    log_it "############################################"
    log_it "-- Start empty file test #####"
    log_it "Exeucting the following command: \n${cmd_string}"
    cmd=`${SPELL_CMD} ${INPUT_DIR}/empty_sample 2> ${ERROR_FILE}`
    log_it "NOTE: test_empty_file test output will show nothing.  See ${ERROR_FILE} for test_empty_file output" 
    log_it "Output:\n$cmd"
    log_it "-- End empty file test #####"
    log_it "############################################"
    add_buffer
  }

###############  END  Tests  ###################3


if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: $0 <Working Directory> <Shell Command Location e.g. /usr/bin/shell>"
    exit 1
fi

  pre_flight_check
  run_tests
