" --> action: RECOMMENDED
" -->  group: PROGRAMMING, LANGUAGE
" -->   name: JavaScript/Node.js

" --> enable runtimes for Javascript family
Plug 'pangloss/vim-javascript'        " Javascript
Plug 'mxw/vim-jsx'                    " JSX templates
Plug 'kchmck/vim-coffee-script'       " Coffeescript
Plug 'itspriddle/vim-jquery'          " jQuery
Plug 'mmalecki/vim-node.js'           " Node.js

" --> detect correct file types and syntax for JS related extensions
augroup detect_filetypes
  au BufNewFile,BufRead *.json setl ft=json
  au BufNewFile,BufRead *.coffee{,script} setl ft=coffee
  " javascript syntax should be enhanced via jquery syntax
  au syntax   javascript         setl syntax=jquery
  au filetype json,javascript    setl syntax=javascript
augroup end

" --> detect correct syntax range inside Riot.js components
augroup riot_js
  au!
  au BufNewFile,BufRead *.js.tag setl ft=html
  au filetype html :call SyntaxRange#Include("<style>", "</style>", "css")
  au filetype html :call SyntaxRange#Include("<style.*sass.*>", "</style>", "scss")
  au filetype html :call SyntaxRange#Include("<style.*scss.*>", "</style>", "scss")
  au filetype html :call SyntaxRange#Include("<style.*less.*>", "</style>", "less")
  au filetype html :call SyntaxRange#Include("<script>", "</script>", "javascript")
  au filetype html :call SyntaxRange#Include("<script.*coffee.>", "</script>", "coffee")
  au filetype html :call SyntaxRange#Include("<script.*coffeescript.>", "</script>", "coffee")
augroup END

" --> enable auto completion for javascript
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  end
augroup end

" --> set whitespace settings for Javascript related files
" --> make whitespace visible in cofeescript and javascript
augroup setup_whitespace
  au filetype json,javascript,coffee  setl ts=2 sw=2 sts=2 tw=80 et
  au filetype coffee,javascript setl listchars=trail:·,extends:#,nbsp:·
augroup end

" --> dictate how to create folds for Javascript files
augroup create_folds
  au filetype coffee     setl fdm=indent fdls=1
  au filetype javascript setl fdm=syntax fdls=1
augroup end

" --> run current file (if script) when <F5> is pressed
" --> TODO: tidy up javascript otherwise
augroup jobs_and_tasks
  au BufRead,BufEnter *.js if executable(expand("%:p")) &&
        \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
augroup end
