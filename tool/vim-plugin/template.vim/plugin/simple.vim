if exists("g:loaded_simple")
  finish
endif
let g:loaded_simple = 1
let s:save_cpo = &cpo
set cpo&vim

" 処理記載
" sample start
fu! s:Done(line)
  echo a:line
endf

command! -nargs=0 MyTaskToggle call s:Done(getline('3'))
" sample end

let &cpo = s:save_cpo
unlet s:save_cpo
