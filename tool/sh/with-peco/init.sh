#!/bin/bash -eu

MY_PECO_TOOLS_DIR=$(dirname $0)

. ${MY_PECO_TOOLS_DIR}/bin/command_history.sh
. ${MY_PECO_TOOLS_DIR}/bin/chrome_history.sh
. ${MY_PECO_TOOLS_DIR}/bin/chrome_bookmark.sh
. ${MY_PECO_TOOLS_DIR}/bin/current_fullpath_history.zsh

zle -N _local_command_history
zle -N _local_chrome_history
zle -N _local_chrome_bookmark
zle -N _local_current_fullpath_history

bindkey '^b' _local_command_history
bindkey '^b^b' _local_current_fullpath_history
bindkey '^b^g' _local_chrome_history
bindkey '^b^h' _local_chrome_bookmark
