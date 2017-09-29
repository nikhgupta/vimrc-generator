" --> action: OPTIONAL
" -->  group: POWER_USER

" used by other sections
augroup jobs_and_tasks | au! | augroup end

" --> start builds, test suites and linting in the background (async)
" --> provide a mapping to start (async) make tasks for current file
Plug 'neomake/neomake'
let g:neomake_open_list = 2
autocmd! BufWritePost * Neomake
Plug 'tpope/vim-dispatch'
nnoremap <F5> <silent> :Dispatch!<CR>
