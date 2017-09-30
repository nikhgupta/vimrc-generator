" --> action: RECOMMENDED
" -->  group: PROGRAMMING

" --> provide documentation for code/files via <K> key
Plug 'Keithbsmiley/investigate.vim'
map K :call investigate#Investigate()<CR><CR>

" --> avoid accidental hits of <F1> while aiming for <Esc>
" --> <F1> displays message to use <K> key instead.
noremap  <F1> :echom "Use ". &keywordprg ." OR press 'K' to get help."<CR><Esc>
noremap! <F1> <Esc>:echom "Use ". &keywordprg ." OR press 'K' to get help."<CR><Esc>a

" --> use 3rd party applications for viewing documentation if available
let g:investigate_use_dash=1
" NOTE: This does not work at the moment, as 'open' encodes the URL wrongly.
" map docs for the following languages to http://devdocs.io
" for fs in [ 'c', 'cpp', 'css', 'django', 'go', 'haskell', 'html',
"           \ 'javascript', 'php', 'python', 'ruby', 'rails' ]
"   execute( 'let g:investigate_url_for_'.fs.'="http://devdocs.io/#q='.fs.' ^s"')
" endfor
" let g:investigate_url_for_coffee = 'http://devdocs.io/#q=coffeescript ^s'
