" --> action: RECOMMEND
" -->  group: PROGRAMMING

" --> provide PHP integration environment for VIM
Plug 'spf13/PIV'

" --> detect correct file types for uncommon PHP extensions
augroup detect_filetypes
  au BufNewFile,BufRead *.ctp setl ft=ctp
  au filetype ctp setl syntax=php
augroup end

" --> provide autocompletion for PHP
Plug 'shawncplus/phpcomplete.vim'

" --> set whitespace settings for PHP related files
augroup setup_whitespace
    au filetype php,ctp                 setl ts=4 sw=4 sts=4 tw=80 et
augroup end

" --> run current PHP file when <F5> is pressed if script otherwise lint it
augroup jobs_and_tasks
  au filetype php setl makeprg=php\ -l\ %
  au BufRead,BufEnter *.php if executable(expand("%:p")) &&
        \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
augroup end
