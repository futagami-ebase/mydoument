"---------------------------------------------------
" Ext F
"---------------------------------------------------
"
" ========================================
" start 'ext f mode' key
" f or g:ext_f_move_ defined by .vimrc
"
" If you don't need this function,
" define global variable below in .vimrc
"
" let g:ext_f_move_enable
"
" keymap of [f mode]
" <C-F> : orientation switch key
" <Enter> or <Esc> : End ext f mode

let s:save_cpo = &cpo
set cpo&vim

" default start ext f mode key
let s:default_start_key = 'f'

" If you define 'g:ext_f_move_start_key' in .vimrc, 
" will be started resize window by 'g:win_resizer_start_key' 
let g:ext_f_move_start_key = get(g:, 'ext_f_move_start_key', s:default_start_key)
let g:ext_f_move_enable    = get(g:, 'ext_f_move_enable', 1)

" ext f mode key mapping
let s:default_keycode = {
             \           'switch':'6',
             \           'finish':'13',
             \           'escape':'27',
             \          }

let g:ext_f_move_keycode_switch = get(g:, 'ext_f_move_keycode_switch', s:default_keycode['switch'])
let g:ext_f_move_keycode_finish = get(g:, 'ext_f_move_keycode_finish', s:default_keycode['finish'])
let g:ext_f_move_keycode_escape = get(g:, 'ext_f_move_keycode_escape', s:default_keycode['escape'])

" if <ESC> key downed, ext f mode
let g:ext_f_move_finish_with_escape = get(g:, 'ext_f_move_finish_with_escape', 1)

exe 'nnoremap ' . g:ext_f_move_start_key . ' :call ExtFMoveStart()<CR>'

fun! ExtFMoveStart()
  if g:ext_f_move_enable == 0
    return
  endif

  call s:startFMove()

endfun

" Note:
" \x80\xfd` seems to be sent by a terminal.
" Below is a workaround for the sequence.
function! s:getchar()
    while 1
        let cn = getchar()
        if type(cn) != type('') || cn !=# "\x80\xfd`"
            return cn
        endif
    endwhile
endfunction


function! s:startFMove()

  highlight FMoveCursorColor ctermbg=green

  echo '[F move mode]... "'.s:label_finish.'": End'

  while 1
    let c = s:getchar()
    let m = matchadd("FMoveCursorColor", '\%#', -1)

    if c == g:ext_f_move_keycode_finish || (g:ext_f_move_finish_with_escape == 1 && c == g:ext_f_move_keycode_escape)
      echo ""
      break
    else
      exe 'normal! f' . s:getKeyAlias(c)
      redraw
    endif
  endwhile

  redraw
  call matchdelete(m)
  highlight clear FMoveCursorColor
endfunction


fun! s:getKeyAlias(code)
  if a:code == 13
    let alias = "Enter"
  else
    let alias = nr2char(a:code)
  end
  return alias
endfun

let s:label_finish = s:getKeyAlias(g:ext_f_move_keycode_finish)
"let &cpo = s:save_cpo
