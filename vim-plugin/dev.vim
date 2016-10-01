"TODO
" - プラグイン化
" - 移動時の表示処理設定
" - コードの整理(整形およびコメント整理)
"---------------------------------------------------
" Ext F Move
"---------------------------------------------------
"
" ========================================
" start 'f monitor' key
" f or g:f_monitor_ defined by .vimrc
"
" If you don't need this function,
" define global variable below in .vimrc
"
" let g:f_monitor_enable
"
" keymap of [f monitor]
" <C-F> : orientation switch key
" <Enter> or <Esc> : End f monitor

"let s:save_cpo = &cpo
"set cpo&vim

" default start key
let s:default_small_f_monitor_start_key = 'f'
let s:default_large_f_monitor_start_key = 'F'

" If you define 'g:f_monitor_start_key' in .vimrc,
let g:small_f_monitor_start_key = get(g:, 'small_f_monitor_start_key', s:default_small_f_monitor_start_key)
let g:large_f_monitor_start_key = get(g:, 'large_f_monitor_start_key', s:default_large_f_monitor_start_key)
let g:f_monitor_enable          = get(g:, 'f_monitor_enable', 1)

" f mode key mapping
let s:default_keycode = {
             \           'switch':'6',
             \           'finish':'13',
             \           'escape':'27',
             \          }

let g:f_monitor_keycode_switch = get(g:, 'f_monitor_keycode_switch', s:default_keycode['switch'])
let g:f_monitor_keycode_finish = get(g:, 'f_monitor_keycode_finish', s:default_keycode['finish'])
let g:f_monitor_keycode_escape = get(g:, 'f_monitor_keycode_escape', s:default_keycode['escape'])

" highright configs
let g:f_monitor_mark_cursor_color = get(g:, 'f_monitor_mark_cursor_color', 'Cursor')

" 仮設定値
  hi MyCursor term=reverse cterm=reverse
  let g:f_monitor_mark_cursor_color  = 'MyCursor'
"

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
  let l:f_type   = s:is_reverse == 0 ? 'f' : 'F'
  let l:mode     = s:current_mode == 'v' ? ' VISUAL' : ''
  let l:operator = s:current_mode == 'o' ? s:operator : ''

  echo '-- ' . l:operator . l:f_type . ' MOVE' . l:mode . ' --'
endfunction

command! -nargs=+ CallMonitorFStart call MonitorFStart(<args>)
exe 'nnoremap ' . g:small_f_monitor_start_key . ' :CallMonitorFStart 0, "n"<CR>'
exe 'nnoremap ' . g:large_f_monitor_start_key . ' :CallMonitorFStart 1, "n"<CR>'
exe 'xnoremap ' . g:small_f_monitor_start_key . ' :CallMonitorFStart 0, "v"<CR>'
exe 'xnoremap ' . g:large_f_monitor_start_key . ' :CallMonitorFStart 1, "v"<CR>'
exe 'onoremap ' . g:small_f_monitor_start_key . ' :CallMonitorFStart 0, "o"<CR>'
exe 'onoremap ' . g:large_f_monitor_start_key . ' :CallMonitorFStart 1, "o"<CR>'

function! MonitorFStart(is_rev, current_mode)
  if g:f_monitor_enable == 0
    return
  endif
  let s:is_reverse   = a:is_rev
  let s:current_mode = a:current_mode
  let s:operator     = v:operator

  exe 'highlight link FMoveCursorColor ' . g:f_monitor_mark_cursor_color

  call s:startFMoveMode()

endfunction

function! s:startFMoveMode()

  if s:current_mode == 'o' | exe "normal! \<Esc>v\<Esc>" | endif

  while 1
    call s:showModeMessage()

    let c = s:getchar()
    let l:cursor_mark = matchadd("FMoveCursorColor", '\%#', 999)

    if c == g:f_monitor_keycode_escape | break | endif

    if c == g:f_monitor_keycode_finish
      if s:current_mode == 'o' | exe "normal! \<Esc>gv" . s:operator | endif
      break
    endif

    if c == g:f_monitor_keycode_switch
      let s:is_reverse = !s:is_reverse
    endif

    if s:current_mode == 'v' || s:current_mode == 'o' | exe "normal! \<Esc>gv" | endif

    exe 'normal! ' . (!s:is_reverse ? 'f' : 'F') . s:getKeyAlias(c)

    redraw
  endwhile

  echo ""
  call matchdelete(l:cursor_mark)
  highlight link FMoveCursorColor NONE
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

let s:label_finish = s:getKeyAlias(g:f_monitor_keycode_finish)
"let &cpo = s:save_cpo
