#!/bin/bash -eu

function _local_chrome_history()
{
  local DEST_FILE=${HOME}/.chrome_history.sqlite
  local GET_URLS_FOR_SQL="
            select distinct
             case 
              when length(title) > 25 then substr(title, 1, 25)||\"...\"
              when length(title) = 25 then substr(title, 1, 25) 
              else title
              end,
              url
            from urls order by last_visit_time desc;"

  cat ${HOME}/Library/Application\ Support/Google/Chrome/Default/History > ${DEST_FILE}

  sqlite3 ${DEST_FILE} "${GET_URLS_FOR_SQL}" | \
                                        peco | \
                                         rev | \
                           cut -d "|" -f 1-1 | \
                                         rev | xargs open
}
