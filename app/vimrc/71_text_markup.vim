" --> action: RECOMMEND
" -->  group: PROGRAMMING

" --> enable runtimes for markdown and textile formats
Plug 'tpope/vim-markdown'
Plug 'timcharper/textile.vim'
" --> prefer Github flavored Markdown syntax
Plug 'jtratner/vim-flavored-markdown'

" --> detect correct file types for various markup file extensions
augroup detect_filetypes
  au BufNewFile,BufRead *.yml,*.yaml setl ft=yaml
  au BufNewFile,BufRead *.md,*.mdown,*.markdown setl ft=ghmarkdown
augroup end

" --> highlight YAML front matter as comments
augroup yaml_front_matter
  au!
  au filetype ghmarkdown,textile syntax region frontmatter start=/\%^---$/ end=/^---$/
  au filetype ghmarkdown,textile highlight link frontmatter Comment
augroup end

" --> enable auto completion for markdown
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype ghmarkdown setlocal omnifunc=htmlcomplete#CompleteTags
  end
augroup end

" --> set whitespace settings for markup files
" --> make whitespace invisible in markup files
augroup setup_whitespace
  au filetype rst        setl ts=4 sw=4 sts=4 tw=74 et
  au filetype yaml       setl ts=2 sw=2 sts=2 tw=72 et
  au filetype ghmarkdown setl ts=4 sw=4 sts=4 tw=72 et
  au filetype textile    setl ts=4 sw=4 sts=4 tw=72 et
  au filetype ghmarkdown,textile,text,rst setl nolist
augroup end

" --> dictate how to create folds for markup files
augroup create_folds
  au filetype yaml setl fdm=marker fmr={{{,}}} fdls=0 fdl=0
augroup end

" --> turn on spell checking and automatic wrap for text markup files
augroup text_files
  au!
  au filetype ghmarkdown             setl formatoptions+=w
  au filetype ghmarkdown,textile,rst setl formatoptions+=qat
  au filetype ghmarkdown,textile,rst setl formatoptions-=cro
  au filetype ghmarkdown,textile,rst setl wrap wrapmargin=2
augroup end

" --> warns when text width exceeds predefined width in RST files
augroup exceeded_text_width
  au filetype rst match ErrorMsg '\%>74v.\+'
augroup end

" --> open HTML converted markups files when <F5> is pressed
augroup jobs_and_tasks
  au filetype rst setl makeprg=rst2html.py\ %\ /tmp/%:r.html\ &&\ open\ /tmp/%:r.html
  au filetype ghmarkdown setl makeprg=rdiscount\ %\ >\ /tmp/%:r.html\ &&\ open\ /tmp/%:r.html
augroup end
