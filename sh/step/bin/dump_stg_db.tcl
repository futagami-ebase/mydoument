#!/usr/bin/expect

set current_dir [exec dirname $argv0]
source $current_dir/sub/_login.tcl
source $current_dir/../config/_step_config.tcl
source $current_dir/../config/_mysql_config.tcl
source $current_dir/../config/_dump_config.tcl

set timeout 60
if { [ file exists ${DUMP_FILE_DIR} ] != 1 } then {
  exec mkdir ${DUMP_FILE_DIR}
} else {
}
exec touch ${DUMP_FILE_DIR}${DUMP_FILE_NAME}

spawn ssh ${STEP_ID}@${STEP_HOST}
_login ${STEP_ID} ${STEP_HOST} ${STEP_PASS}
send "ssh ${SERVER_HOST}\n"
_login ${STEP_ID} ${SERVER_HOST} ${STEP_PASS}
expect "${PROMPT_SUFFIX}"
send "mysqldump -u ${DB_USER} -p${DB_PASS} -h ${DB_HOST} ${DB_NAME} > ${DUMP_FILE_NAME}\n"
expect "${PROMPT_SUFFIX}"
send "exit\n"
expect "Connection to ${SERVER_HOST} closed."
send "scp ${SERVER_HOST}:${DUMP_FILE_NAME} ${DUMP_FILE_NAME}\n"
_login ${STEP_ID} ${SERVER_HOST} ${STEP_PASS}
expect "${PROMPT_SUFFIX}"
send "ssh ${SERVER_HOST} rm ${DUMP_FILE_NAME}\n"
_login ${STEP_ID} ${SERVER_HOST} ${STEP_PASS}
expect "${PROMPT_SUFFIX}"
send "exit\n"
close

set timeout 60
spawn scp ${STEP_ID}@${STEP_HOST}:${DUMP_FILE_NAME} ${DUMP_FILE_NAME}
_login ${STEP_ID} ${STEP_HOST} ${STEP_PASS}
expect "${PROMPT_SUFFIX}"

set timeout 10
spawn ssh ${STEP_ID}@${STEP_HOST} rm ${DUMP_FILE_NAME}
_login ${STEP_ID} ${STEP_HOST} ${STEP_PASS}
expect "${PROMPT_SUFFIX}"
exec mv ${DUMP_FILE_NAME} ${DUMP_FILE_DIR}
exit
