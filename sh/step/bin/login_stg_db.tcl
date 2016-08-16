#!/usr/bin/expect

set current_dir [exec dirname $argv0]
source $current_dir/sub/_login.tcl
source $current_dir/../config/_step_config.tcl
source $current_dir/../config/_mysql_config.tcl

set timeout 10
spawn ssh ${STEP_ID}@${STEP_HOST}
_login ${STEP_ID} ${STEP_HOST} ${STEP_PASS}
send "ssh ${SERVER_HOST}\n"
_login ${STEP_ID} ${SERVER_HOST} ${STEP_PASS}
expect "${PROMPT_SUFFIX}"
send "mysql -u ${DB_USER} -p${DB_PASS} -h ${DB_HOST} ${DB_NAME} --auto-rehash\n"
interact

