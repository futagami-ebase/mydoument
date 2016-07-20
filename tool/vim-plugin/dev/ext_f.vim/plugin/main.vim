"" =============================================================================
"" File:          plugin/
"" Description:   
"" Author:        
"" Version:       0.7
"" ReleaseDate:   2013-03-10
"" License:       MIT License (see below)
""
"" Copyright (C) 2013 Vic Goldfeld under the MIT License.
""
"" =============================================================================

"let cursor  = getpos('.')
"let cursor1 = getpos('.')[1:2]
"let pos = l:cursor[2]
"let pos = col('.')
"let line = getline('.')
"call cursor(line('.'), 4)
"call search()
"call setpos()
"get(g:, 'seek_char_aliases', ''))
"let s:charAliases = {}
"
"  function! s:seekindex(text, c1, c2, start, seekfn, comparefn)
"    let Index = function(a:seekfn)
"    return Index(a:text, nr2char(a:c1).nr2char(a:c2), a:start)
"  endfunction
"
" 1.モード判定(normal or visiual)
" 2.入力文字判定(f or F)
" 3.highlight設定
"  f : 現在位置から右端を色切替
"  F : 現在位置から左端を色切替
" 4.keymap一時的に無効
" 5.入力文字待ち状態に移行
" 6.入力文字取得
" 7.入力した文字にカーソル移動
" 8.ctrl-hで移動を一つ戻る, ctrl-lで移動を(ctrl-hで進んだ分)進める
" 9.Enter or ESCキーで入力待ち状態解除
"
if exists("g:loaded_ext_f")
  finish
endif
let g:loaded_ext_f = 1
let s:save_cpo = &cpo
set cpo&vim

" 処理記載
" sample start
fu! s:Done(line)
  echo a:line
endf

command! -nargs=0 MyTaskToggle call s:Done(getline('4'))
" sample end

let &cpo = s:save_cpo
unlet s:save_cpo
