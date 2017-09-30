" --> action: RECOMMENDED
" -->  group: PROGRAMMING, LANGUAGE
" -->   name: GO

" --> provide runtimes for Go language
Plug 'fatih/vim-go'
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" --> detect correct file types for Go extensions
augroup detect_filetypes
  au BufNewFile,BufRead *.go setl ft=go
augroup end

" --> run current file (if script) when <F5> is pressed
augroup jobs_and_tasks
  au BufRead,BufEnter *.go if executable(expand("%:p")) &&
        \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
augroup end
