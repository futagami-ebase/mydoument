fu! s:Done(line)
  echo a:line
endf

command! -nargs=0 MyTaskToggle call s:Done(getline('3'))
