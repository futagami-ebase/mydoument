#!/usr/local/bin/zsh
# ディレクトリ移動時、絶対パスの履歴を保存を行う

FULLPATH_HISTORY_DB=${HOME}/.fullpath_history.sqlite    # 保存先

# 保存用のDB作成(sqlite)
if [  ! -e ${FULLPATH_HISTORY_DB} ]; then
   touch ${FULLPATH_HISTORY_DB}
   sqlite3 ${FULLPATH_HISTORY_DB} "create table main_data(fullpath text primary key);"
fi
# 移動時に履歴をテーブルに登録(重複時は除去後に再登録)
autoload -Uz add-zsh-hook
function _add_current_fullpath_history {
    local fullpath=$(pwd)
    local add_sql="replace into main_data(fullpath) values('${fullpath}');"
    sqlite3 ${FULLPATH_HISTORY_DB} "${add_sql}"
}
add-zsh-hook chpwd _add_current_fullpath_history

function _local_current_fullpath_history {
  local selected_path=$(sqlite3 ${FULLPATH_HISTORY_DB} "select fullpath from main_data;" | tail -r | peco)
  if [ -n "$selected_path" ]; then
    BUFFER="cd ${selected_path}"
    CURSOR=$#BUFFER
  fi
}

