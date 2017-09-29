" --> action: RECOMMEND
" -->  group: PROGRAMMING

" --> enable runtimes for HTML and CSS families
Plug 'othree/html5.vim'                 " html 5
Plug 'hail2u/vim-css3-syntax'           " CSS3
Plug 'groenewege/vim-less'              " Less
Plug 'cakebaker/scss-syntax.vim'        " SCSS
Plug 'tpope/vim-haml'                   " haml, sass and scss
Plug 'mustache/vim-mustache-handlebars' " mustache and handlebars

" --> expand emmet snippets to full HTML using <C-y>,
"     try typing: html:5<C-y>,p#active>span.text-hidden*5<C-y>,
Plug 'mattn/emmet-vim'
" plugin mappings: <C-y>,

" --> provide mappings to escape/unescape HTML
Plug 'skwp/vim-html-escape'
" plugin mappings: <leader>he => escape | <leader>hu => unescape

" --> detect correct file types for HTML and CSS family
augroup detect_filetypes
  au BufNewFile,BufRead *.less setl ft=less
  au BufNewFile,BufRead *.scss setl ft=scss
  au BufNewFile,BufRead *.sass setl ft=sass
augroup end

" --> enable auto completion for HTML and CSS
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype css  setlocal omnifunc=csscomplete#CompleteCSS
    autocmd filetype html setlocal omnifunc=htmlcomplete#CompleteTags
  end
augroup end

" --> set whitespace settings for HTML and CSS family
augroup setup_whitespace
  au filetype html,xhtml,haml     setl ts=2 sw=2 sts=2 tw=0  et
  au filetype css,less,sass,scss  setl ts=2 sw=2 sts=2 tw=80 et
augroup end

" --> dictate how to create folds for HTML and CSS files
augroup create_folds
  au filetype css,less,sass,scss setl fdm=marker fmr={,}
augroup end

" --> TODO: tidy up HTML/CSS files when <F5> is pressed
" augroup jobs_and_tasks
"   au filetype css,less,sass,scss,html if executable(expand("%:p")) &&
"         \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
" augroup end
