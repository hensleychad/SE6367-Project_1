#!/bin/bash


### GLOBALS
WORKING_DIR=$1
SPELL_CMD=$2
INPUT_DIR="${WORKING_DIR}/input"
DICT_DIR="${WORKING_DIR}/dictionary"

LOG_DIR="${WORKING_DIR}/log"
OUTPUT_FILE="${LOG_DIR}/Hensley-Test.Output"
ERROR_FILE="${LOG_DIR}/Hensley-Test.Error"
ERROR_FILE_TMP="${LOG_DIR}/Hensley-Test.Error.tmp"
TEST_ARRAY=(test_number_sample test_multi_line_space_sample test_column_format_sample test_stock_sample test_help test_ispell_version test_spell_version test_other_dictionary test_ispell_program test_all_chains test_print_file_name test_print_numbers_on_lines test_print_words_not_literally_found test_print_stems test_empty_file  test_file_not_found test_unsupported_flag)

###############  START Pre-Flight checks  ###################3
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
    #echo -e "[`date`] - ${*}" >> ${OUTPUT_FILE}
    echo -e "[`date`] - ${1}" >> $2
  }

  mark_it() {
    echo -e "[`date`] - ${1}" >> $2
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

  clean_tmp_error_logs() {

   if [ -f $ERROR_FILE_TMP ]; then
     echo "Cleaning up error file ${ERROR_FILE_TMP}"
     rm ${ERROR_FILE_TMP}
   fi
  }

  add_buffer() {
    echo -e "[`date`] \n++\n++\n++\n++" >> ${OUTPUT_FILE}
  }

  merge_error_file() {
    log_it "############################################" ${ERROR_FILE}
    log_it "-- Start Error ouput for ${*} -- " ${ERROR_FILE} 
    cat ${ERROR_FILE_TMP} >> ${ERROR_FILE}
    log_it "-- End Error ouput for ${*} -- " ${ERROR_FILE} 
    log_it "############################################" ${ERROR_FILE}
  }

  pre_flight_check() {
    check_wrking_dir_exist
    spell_cmd_check
    check_input_dir_exist
    check_dict_dir_exist
    check_log_dir_exist
    clean_logs
    clean_error_logs
    clean_tmp_error_logs
  }

  run_tests() {
    echo "Test count  ${#TEST_ARRAY[@]}"
    echo "Results can be found in ${OUTPUT_FILE}"
    echo "Errors can be found in ${ERROR_FILE}"
    for test_method in "${TEST_ARRAY[@]}"
    do
      #log_it "-- Running ${test_method}"
      ${test_method}
    done
    clean_tmp_error_logs
  }

###############  END  Utils  ###################3

###############  START  Tests  ###################3
  test_number_sample() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_numbers 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_number_sample --" ${OUTPUT_FILE}
    log_it "Clean test - Test sample file against spell" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_numbers 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_number_sample --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_number_sample"
    add_buffer
 }
  test_multi_line_space_sample() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_ft 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_multi_line_space_sample --" ${OUTPUT_FILE}
    log_it "Clean test - Test sample file against spell" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_ft 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_multi_line_space_sample --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_multi_line_space_sample"
    add_buffer
  }

  test_column_format_sample() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/iso_sample 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_multi_line_space_sample --" ${OUTPUT_FILE}
    log_it "Clean test - Test sample file against spell" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/iso_sample 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_multi_line_space_sample --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_multi_line_space_sample"
    add_buffer
  }

  test_stock_sample() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_stock_sample --" ${OUTPUT_FILE}
    log_it "Clean test - Test sample file against spell" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_stock_sample --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_stock_sample"
    add_buffer
  }

  test_help() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} --help 2>> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_help --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} --help 2>${ERROR_FILE_TMP}`
    log_it "NOTE: test_help echos the the usage of spell STDOUT then writes the help menu to STDERR. See ${ERROR_FILE} for test_help output" ${OUTPUT_FILE}
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_help --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_help"
    add_buffer
  }

  test_ispell_version() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} -I 2>> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_ispell_version --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} -I 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_ispell_version --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_ispell_version"
    add_buffer
  }

  test_spell_version () {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} --version 2>>${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_spell_version  --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    log_it "NOTE: test_spell_version output will be empty. See ${ERROR_FILE} for test_spell_version output" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} --version 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_spell_version --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_spell_version"
    add_buffer
  }

  test_other_dictionary() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/iso_sample --dictionary=${DICT_DIR}/british-english 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_other_dictionary --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    log_it "NOTE: test_other_dictionary output will show usage  See ${ERROR_FILE} for test_other_dictionary output" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/iso_sample --dictionary=${DICT_DIR}/british-english 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_other_dictionary --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_other_dictionary"
    add_buffer
  }

  test_ispell_program() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample --ispell 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_ispell_program --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    log_it "NOTE: test_ispell_program will error since ispell may not be installed  See ${ERROR_FILE} for test_ispell_program output" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample --ispell 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End  test_ispell_program --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_ispell_program"
    add_buffer
  }

  test_all_chains() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_numbers -l 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_all_chains  --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_numbers -l 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End  test_all_chains --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_all_chains"
    add_buffer
  }

  test_print_file_name() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_ft --print-file-name 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_print_file_name --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_ft --print-file-name 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_print_file_name --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_print_file_name"
    add_buffer
  }

  test_print_numbers_on_lines() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_ft --number 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_print_numbers_on_lines --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_ft --number 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_print_numbers_on_lines --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_print_numbers_on_lines"
    add_buffer
  }

  test_print_stems() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/iso_sample --print-stems 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_print_stems --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/iso_sample --print-stems 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_print_stems --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_print_stems"
    add_buffer
  }

  test_print_words_not_literally_found() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_numbers -v 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_print_words_not_literally_found --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_numbers -v 2> ${ERROR_FILE_TMP}`
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_print_words_not_literally_found --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_print_words_not_literally_found"
    add_buffer
  }

  test_unsupported_flag() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample -q 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_unsupported_flag --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample -q 2> ${ERROR_FILE_TMP}`
    log_it "NOTE: test_unsupported_flag output will show usage  See ${ERROR_FILE} for test_unsupported_flag output" ${OUTPUT_FILE}
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_unsupported_flag --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_unsupported_flag"
    add_buffer
  }

  test_file_not_found() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/sample_none 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_file_not_found --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/sample_none 2> ${ERROR_FILE_TMP}`
    log_it "NOTE: test_file_not_found output will show nothing.  See ${ERROR_FILE} for test_file_not_found output" ${OUTPUT_FILE}
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_file_not_found --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_file_not_found"
    add_buffer
  }

  test_empty_file() {
    cmd=""  #keep variable clean
    cmd_string="${SPELL_CMD} ${INPUT_DIR}/empty_sample 2> ${ERROR_FILE_TMP}"
    log_it "############################################" ${OUTPUT_FILE}
    log_it "-- Start test_empty_file --" ${OUTPUT_FILE}
    log_it "Exeucting the following command: \n${cmd_string}" ${OUTPUT_FILE}
    cmd=`${SPELL_CMD} ${INPUT_DIR}/empty_sample 2> ${ERROR_FILE_TMP}`
    log_it "NOTE: test_empty_file test output will show nothing." ${OUTPUT_FILE}
    log_it "Output:\n$cmd" ${OUTPUT_FILE}
    log_it "-- End test_empty_file --" ${OUTPUT_FILE}
    log_it "############################################" ${OUTPUT_FILE}
    merge_error_file "test_empty_file"
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
