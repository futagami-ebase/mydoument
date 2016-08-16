" 挿入モードの表示設定
augroup insertmode-colorsheme
  autocmd!
  autocmd InsertEnter * call SetInsertmodeColorsheme(1)
  autocmd InsertLeave * call SetInsertmodeColorsheme(0)
augroup END
function! SetInsertmodeColorsheme(is_insert)
  if a:is_insert == 1
    hi CursorLine term=underline cterm=underline ctermbg=234
    hi CursorLineNr ctermbg=200
  else
    hi CursorLine term=NONE cterm=NONE ctermbg=234
    hi CursorLineNr ctermbg=234
  endif
endfunction
syntax on
hi LineNr ctermfg=245
hi VertSplit ctermfg=214 guifg=#303030

"keymaps
""other
nnoremap ZZ <Nop>
function! SwitchRelativeNumber()
  if &relativenumber == 0
    set nonu|set rnu
  else 
    set nu|set nornu
  endif
endfunction
noremap <C-n> :call SwitchRelativeNumber()<CR>
nnoremap Z :source ~/.vimrc<CR>

"" add commands
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

"" 無視検索リスト
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v(^|[\/])(\.git|\.svn|\.vagrant|\.atom|\.settings|node_modules)$',
\ 'file': '\v\.(exe|so|dmg|png|jpg|gif|swp|zip|gz|bz|jar|war|app)$',
\ 'link': '/here/write/some_bad_symbolic_links'
\}
"" ファイル検索コマンド変更(ag使用)
let g:ctrlp_user_caching = 0
let g:ctrlp_user_command = 'ag %s -U -i --nocolor --nogroup --hidden -g ""'
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

"" net rw設定
let g:netrw_liststyle = 3 " netrwのデフォルトをtree view
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " .で始まるファイルは表示しない
let g:netrw_altv = 1 " 'v'のデフォルトを右側
let g:netrw_alto = 1 " 'o'のデフォルトを下側
" netrwのkeymap設定
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
  noremap <buffer> - <Nop>
  noremap <buffer> h :Ntree ..<CR>
  noremap <buffer> l :Ntree<CR>
  noremap <buffer> X <Nop>
  noremap <buffer> <C-j> 5j
  noremap <buffer> <C-k> 5k
  noremap <buffer> K $2F<Bar>f "zy0?^<C-R>z [^<Bar>]<CR>
endfunction

if filereadable($LOCAL_MYVIMRC)
endif
if g:is_set_dev_plugin
endif
