#!/usr/bin/expect

set remote_host [lindex $argv 0]

set current_dir [exec dirname $argv0]
source $current_dir/sub/_login.tcl
source $current_dir/../config/_step_config.tcl

set timeout 10
spawn ssh ${STEP_ID}@${STEP_HOST}
_login ${STEP_ID} ${STEP_HOST} ${STEP_PASS}
if { ${remote_host} ne "" } then {
  send "ssh ${remote_host}\n"
  _login ${STEP_ID} ${remote_host} ${STEP_PASS}
}
interact
