#!/bin/bash


### GLOBALS
WORKING_DIR=$1
SPELL_CMD=$2
INPUT_DIR="${WORKING_DIR}/input"
DICT_DIR="${WORKING_DIR}/dictionary"

LOG_DIR="${WORKING_DIR}/log"
OUTPUT_FILE="${LOG_DIR}/Hensley-Test.Output"
ERROR_FILE="${LOG_DIR}/Hensley-Test.Error"
TEST_ARRAY=(standard_test help_test ispell_version spell_version other_dictionary ispell_program all_chains print_file_name print_numbers_on_lines print_words_not_literally_found print_stems test_empty_file  test_upsupported_flag)
ERROR_MSG="Check Error Log, ${ERROR_FILE}"


  log_it() {
    echo -e "[`date`] - ${*}" >> ${OUTPUT_FILE}
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


  standard_test() {
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start input file testing #####"
    log_it "############################################"
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
    cmd="${ERROR_MSG}"
    log_it "-- Start Show help test case #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${SPELL_CMD} --help 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End Show help test case #####"
    log_it "############################################"
    add_buffer
  }

  ispell_version() {
    cmd_string="${SPELL_CMD} -I 2> ${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start print ispell version #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${SPELL_CMD} -I 2> ${ERROR_FILE}`
    log_it "Output:\n$cmd"
    log_it "-- End print ispell version #####"
    log_it "############################################"
    add_buffer
  }

  spell_version () {
    cmd_string="${SPELL_CMD} --version 2>${ERROR_FILE}"
    cmd="${ERROR_MSG}"
    log_it "-- Start print version number  #####"
    log_it "############################################"
    log_it "Exeucting the following command: ${cmd_string}"
    cmd=`${cmd_string}`
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
    cmd=`${cmd_string}`
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
    for test_method in "${TEST_ARRAY[@]}"
    do
      log_it "Running ${test_method}"
      ${test_method}
    done
  }

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: $0 <Working Directory> <Shell Command Location e.g. /usr/bin/shell>"
    exit 1
fi

  clean_logs
  clean_error_logs
  run_tests
