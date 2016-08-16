#!/bin/bash -eu

MY_TOOLS_OF_SERVER_DIR=$(cd $(dirname $0) && pwd)

function step()
{
 local host1=''
 local host2=''

  case $1 in-
    "-host1" )  ${MY_TOOLS_OF_SERVER_DIR}/bin/login_remote_server_via_step.tcl $host1;;
    "-host2" )  ${MY_TOOLS_OF_SERVER_DIR}/bin/login_remote_server_via_step.tcl $host2;;
    "-mysql" )  ${MY_TOOLS_OF_SERVER_DIR}/bin/login_stg_db.tcl;;
    "-dbdump" ) ${MY_TOOLS_OF_SERVER_DIR}/bin/dump_stg_db.tcl;;
    * )         ${MY_TOOLS_OF_SERVER_DIR}/bin/login_remote_server_via_step.tcl;;
  esac
}

compdef _step_cmd step

function _step_cmd {
  local -a cmds
  cmds=('host1' 'host2' 'mysql' 'dbdump')
  compadd -P '-' $cmds
  return 1;
}
