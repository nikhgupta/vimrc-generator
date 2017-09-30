" --> action: ADVANCED

" --> enable line numbers with maximum 4 gutter columns
set number
set numberwidth=4

" --> provide toggle key for displaying relative line numbers (RLN)
nnoremap <leader>trn :set relativenumber!<cr>

" --> use absolute line numbers everywhere
" --> only display relative line numbers in current buffer when not editing text
augroup relative_line_numbers
  au!
  autocmd FocusLost,BufLeave,InsertEnter   * if &number | :setl norelativenumber | endif
  autocmd FocusGained,BufEnter,InsertLeave * if &number | :setl relativenumber   | endif
augroup end
