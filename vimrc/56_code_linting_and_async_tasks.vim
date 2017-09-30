" --> action: ADVANCED
" -->  group: PROGRAMMING

" used by other sections
augroup jobs_and_tasks | au! | augroup end

" --> start builds, test suites and linting in the background (async)
" --> provide a mapping to start (async) make tasks for current file
Plug 'neomake/neomake'
let g:neomake_open_list = 2
autocmd! BufWritePost * Neomake
Plug 'tpope/vim-dispatch'
nnoremap <F5> <silent> :Dispatch!<CR>

" --> auto format code whenever it is written
Plug 'Chiel92/vim-autoformat'
noremap <F4> :Autoformat<CR>
" Customize: enable auto formatting on all buffers when you write:
" augroup auto_format
"   au!
"   au BufWrite * :Autoformat
" augroup END
