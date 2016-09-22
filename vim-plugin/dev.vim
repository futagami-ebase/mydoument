"---------------------------------------------------
" Ext F Move
"---------------------------------------------------
"
" ========================================
" start 'ext f move mode' key
" f or g:ext_f_move_ defined by .vimrc
"
" If you don't need this function,
" define global variable below in .vimrc
"
" let g:ext_f_move_enable
"
" keymap of [f move mode]
" <C-F> : orientation switch key
" <Enter> or <Esc> : End ext f move mode

let s:save_cpo = &cpo
set cpo&vim

" default start ext f move mode key
let s:default_start_key = 'f'
let s:default_start_reverse_key = 'F'

" If you define 'g:ext_f_move_start_key' in .vimrc, 
" will be started resize window by 'g:win_resizer_start_key' 
let g:ext_f_move_start_key         = get(g:, 'ext_f_move_start_key', s:default_start_key)
let g:ext_f_move_start_reverse_key = get(g:, 'ext_f_move_start_reverse_key', s:default_start_reverse_key)
let g:ext_f_move_enable            = get(g:, 'ext_f_move_enable', 1)

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

exe 'nnoremap ' . g:ext_f_move_start_key . ' :call ExtFMoveStart(0)<CR>'
exe 'nnoremap ' . g:ext_f_move_start_reverse_key . ' :call ExtFMoveStart(1)<CR>'

let s:is_reverse = 0

function! ExtFMoveStart(is_rev)
  if g:ext_f_move_enable == 0
    return
  endif
  let s:is_reverse = a:is_rev

  call s:startFMove()

endfunction

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

function! s:showModeMessage()
    if s:is_reverse == 0
      echo '[f move mode]... "'.s:label_finish.'": End'
    else
      echo '[F move mode]... "'.s:label_finish.'": End'
    endif
endfunction

function! s:startFMove()

  highlight FMoveCursorColor ctermbg=green

  while 1
    call s:showModeMessage()

    let c = s:getchar()
    let m = matchadd("FMoveCursorColor", '\%#', -1)

    if c == g:ext_f_move_keycode_finish || (g:ext_f_move_finish_with_escape == 1 && c == g:ext_f_move_keycode_escape)
      break
    endif

    if c == g:ext_f_move_keycode_switch
      let s:is_reverse = !s:is_reverse
    endif
    exe 'normal! ' . (!s:is_reverse ? 'f' : 'F') . s:getKeyAlias(c)

    redraw
  endwhile

  echo ""
  call matchdelete(m)
  highlight clear FMoveCursorColor
  redraw
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
