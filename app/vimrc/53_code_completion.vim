" --> action: RECOMMEND
" -->  group: PROGRAMMING

" --> enable code completion for buffers
set completeopt+=menu,longest     " select first item, follow typing in autocomplete
set complete=.,w,b,u,t            " do lots of scanning on tab completion,  FIXME?
set pumheight=6                   " Keep a small completion window

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2
  set concealcursor=i
endif

" --> show extra information about completion selection in preview window
set completeopt+=preview

" -> provide syntax based auto completion by default
augroup omni_complete
  au!
  if exists('+omnifunc')
    autocmd filetype * if &omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
  end
augroup end

" -!-> disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise especially when splits are used.
" set completeopt-=preview

" -!-> enable YouCompleteMe plugin
" Plugin 'Valloric/YouCompleteMe'
" " enable completion from tags
" let g:ycm_collect_identifiers_from_tags_files = 1
" " enable completion for keywords in current language
" let g:ycm_seed_identifiers_with_syntax = 0

" if has('lua')
"   Plugin 'Shougo/neocomplete.vim'
"   let g:neocomplete#enable_at_startup = 1                 " enable at startup
"   let g:neocomplete#enable_ignore_case = 1                " ignore case when completing
"   let g:neocomplete#sources#syntax#min_keyword_length = 4 " use a minimum syntax keyword length
"   let g:neocomplete#force_overwrite_completefunc = 1
"   " do not complete automatically on files matching this pattern
"   " let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"   " let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"   inoremap <expr><C-g>     neocomplete#undo_completion()
"   inoremap <expr><C-l>     neocomplete#complete_common_string()

"   " <CR>: close popup and save indent.
"   inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"   function! s:my_cr_function()
"     return neocomplete#smart_close_popup() . "\<CR>"
"     " For no inserting <CR> key.
"     "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"   endfunction

"   " <TAB>: completion.
"   inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"   " <C-h>, <BS>: close popup and delete backword char.
"   inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"
"   inoremap <expr><BS>   neocomplete#smart_close_popup()."\<C-h>"
"   inoremap <expr><C-y>  neocomplete#close_popup()
"   inoremap <expr><C-e>  neocomplete#cancel_popup()
" else
"   Plugin 'Shougo/neocomplcache.vim'
"   let g:neocomplcache_enable_at_startup  = 1               " enable at startup
"   let g:neocomplcache_enable_ignore_case = 1               " ignore case when completing
"   let g:neocomplcache_min_syntax_length  = 4               " use a minimum syntax keyword length
"   " do not complete automatically on files matching this pattern
"   " let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"   " if !exists('g:neocomplcache_keyword_patterns')
"     " let g:neocomplcache_keyword_patterns = {}
"   " endif
"   " let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"   inoremap <expr><C-g>     neocomplcache#undo_completion()
"   inoremap <expr><C-l>     neocomplcache#complete_common_string()

"   " <CR>: close popup and save indent.
"   inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"   function! s:my_cr_function()
"     return neocomplcache#smart_close_popup() . "\<CR>"
"     " For no inserting <CR> key.
"     "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"   endfunction

"   " <TAB>: completion.
"   inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"   " <C-h>, <BS>: close popup and delete backword char.
"   inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
"   inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
"   inoremap <expr><C-y>  neocomplcache#close_popup()
"   inoremap <expr><C-e>  neocomplcache#cancel_popup()
" endif
