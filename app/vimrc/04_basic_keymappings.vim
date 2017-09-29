" --> action: RECOMMEND
" -->  group: BASIC

" --> define various `leader` keys
let mapleader      = ","     " change mapleader key from / to ,
let g:mapleader    = ","     " some plugins may require this variable to be set
let maplocalleader = "\\"    " used inside filetype settings

" --> map ; to :
" `;` key repeats latest movement command. Although useful, mapping this key to
" `:` is a real optimization for almost all Vim commands, since we save on
" pressing `Shift` key each time that slows almost all commands we use.
nnoremap ; :

" --> swap implementations of ` and ' jump to markers
nnoremap ' `
nnoremap ` '

" --> swap implementations of 0 and ^
nnoremap 0 ^
nnoremap ^ 0

" --> avoid accidental hits of <F1> while aiming for <Esc>
" --> <F1> displays message to use <K> key instead.
noremap  <F1> :echom "Use ". &keywordprg ." OR press 'K' to get help."<CR><Esc>
noremap! <F1> <Esc>:echom "Use ". &keywordprg ." OR press 'K' to get help."<CR><Esc>a

" --> avoid accidental hits of <Shift> key
cmap Tabe tabe
if has("user_commands")
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
endif
