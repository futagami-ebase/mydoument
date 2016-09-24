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

"let s:save_cpo = &cpo
"set cpo&vim

" default start ext f move mode key
let s:default_small_f_start_key = 'f'
let s:default_large_f_start_key = 'F'

" If you define 'g:ext_f_move_start_key' in .vimrc, 
" will be started resize window by 'g:win_resizer_start_key' 
let g:ext_small_f_move_start_key = get(g:, 'ext_small_f_move_start_key', s:default_small_f_start_key)
let g:ext_large_f_move_start_key = get(g:, 'ext_large_f_move_start_key', s:default_large_f_start_key)
let g:ext_f_move_enable          = get(g:, 'ext_f_move_enable', 1)

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

let s:is_reverse   = 0
let s:current_mode = "n"
let s:operator     = ""

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

exe 'nnoremap ' . g:ext_small_f_move_start_key . ' :call ExtFMoveStart(0, "n")<CR>'
exe 'nnoremap ' . g:ext_large_f_move_start_key . ' :call ExtFMoveStart(1, "n")<CR>'
exe 'xnoremap ' . g:ext_small_f_move_start_key . ' :call ExtFMoveStart(0, "v")<CR>'
exe 'xnoremap ' . g:ext_large_f_move_start_key . ' :call ExtFMoveStart(1, "v")<CR>'
exe 'onoremap ' . g:ext_small_f_move_start_key . ' :call ExtFMoveStart(0, "o")<CR>'
exe 'onoremap ' . g:ext_large_f_move_start_key . ' :call ExtFMoveStart(1, "o")<CR>'

function! ExtFMoveStart(is_rev, current_mode)
  if g:ext_f_move_enable == 0
    return
  endif
  let s:is_reverse   = a:is_rev
  let s:current_mode = a:current_mode
  let s:operator     = v:operator

  call s:startFMoveMode()

endfunction

function! s:startFMoveMode()

  highlight FMoveCursorColor ctermbg=green

  if s:current_mode == 'o' | exe "normal! \<Esc>v\<Esc>" | endif

  while 1
    call s:showModeMessage()

    let c = s:getchar()
    let cursor_mark = matchadd("FMoveCursorColor", '\%#', -1)

    if c == g:ext_f_move_keycode_finish || (g:ext_f_move_finish_with_escape == 1 && c == g:ext_f_move_keycode_escape)
      if s:current_mode == 'o' | exe "normal! \<Esc>gv" . s:operator | endif
      break
    endif

    if c == g:ext_f_move_keycode_switch
      let s:is_reverse = !s:is_reverse
    endif

    if s:current_mode == 'v' || s:current_mode == 'o' | exe "normal! \<Esc>gv" | endif

    exe 'normal! ' . (!s:is_reverse ? 'f' : 'F') . s:getKeyAlias(c)

    redraw
  endwhile

  echo ""
  call matchdelete(cursor_mark)
  highlight clear FMoveCursorColor
  redraw
endfunction


function! s:getKeyAlias(code)
  if a:code == 13
    let alias = "Enter"
  else
    let alias = nr2char(a:code)
  end
  return alias
endfunction

let s:label_finish = s:getKeyAlias(g:ext_f_move_keycode_finish)
"let &cpo = s:save_cpo
