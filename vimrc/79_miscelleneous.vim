" --> action: RECOMMENDED
" -->  group: PROGRAMMING, LANGUAGE

" --> provide syntax highlighting and filetype detection for CSV files
Plug 'vim-scripts/csv.vim'

" --> detect correct file types for various file extensions
augroup detect_filetypes
  " elixir
  au BufNewFile,BufRead *.ex,*.exs setl ft=elixir
  au BufNewFile,BufRead *.html.eex setl ft=html
augroup end

" --> enable auto completion for various file types
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd filetype java setlocal omnifunc=javacomplete#Complete
    autocmd filetype haskell setlocal omnifunc=necoghc#omnifunc
  end
augroup end

" --> set whitespace settings for various file types
augroup setup_whitespace
  au filetype make  setl noet " make uses real tabs
augroup end

" --> dictate how to create folds for various file types
augroup create_folds
  au filetype conf setl fdm=marker fmr={{{,}}} fdls=0 fdl=0
augroup end
