#!/bin/bash -eu

function _local_chrome_bookmark()
{
  local PHP_READ_CHROME_BOOKMARKS=${MY_PECO_TOOLS_DIR}/bin/sub/chrome_bookmarks.php

  php ${PHP_READ_CHROME_BOOKMARKS} | \
                              peco | \
                               rev | \
                 cut -d "|" -f 1-1 | \
                               rev | xargs open
}
