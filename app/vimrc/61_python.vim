" --> action: RECOMMEND
" -->  group: PROGRAMMING

" --> provide Python integration environment for VIM
Plug 'klen/python-mode'

" --> enable auto completion for python
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype python setlocal omnifunc=pythoncomplete#Complete
  end
augroup end

" --> set whitespace settings for Python related files
augroup setup_whitespace
  au filetype python   setl ts=4 sw=4 sts=4 tw=80 et
augroup end

" --> warns when text width exceeds predefined width in Python files
augroup exceeded_text_width
  au filetype python match ErrorMsg '\%>80v.\+'
augroup end

" --> run current file (if script) when <F5> is pressed
augroup jobs_and_tasks
  au BufRead,BufEnter *.py if executable(expand("%:p")) &&
        \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
augroup end
