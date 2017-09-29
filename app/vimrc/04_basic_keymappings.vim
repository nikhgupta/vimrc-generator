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
