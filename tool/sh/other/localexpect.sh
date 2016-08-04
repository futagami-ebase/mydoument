#!/bin/sh
 
expect -c "
spawn $SHELL
send \"cd\"
interact
"
