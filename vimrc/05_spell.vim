" --> action: RECOMMENDED

" --> disable spell check by default
" --> spell check is enabled later using autocommands, where required.
if has('spell') | set nospell | endif

" --> use default word list provided by the OS
" --> use a `public`  dictionary file which can be versioned
" --> use a `private` dictionary file which can be opted out from versioning
if has('spell')
  set dictionary=/usr/share/dict/words
  set spellfile=~/.vim/spell/public.utf-8.add,~/.vim/spell/private.utf-8.add
endif

" --> manually added words are sent to `private` dictionary
if has('spell') | nnoremap zG 2zg | endif
