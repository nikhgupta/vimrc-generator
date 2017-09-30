" --> action: ADVANCED

" --> enable indentation guides via Plugin
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size  = 1
let g:indent_guides_start_level = 2

" --> provide a toggle key for displaying indentation guides
nmap <silent> <Leader>tig <Plug>IndentGuidesToggle

