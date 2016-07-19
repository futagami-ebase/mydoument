if exists("g:loaded_seq_f")
  finish
endif
let g:loaded_seq_f = 1
let s:save_cpo = &cpo
set cpo&vim

" 処理記載

let &cpo = s:save_cpo
unlet s:save_cpo
