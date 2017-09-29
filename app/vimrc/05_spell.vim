" --> action: RECOMMEND
" -->  group: BASIC

if has('spell')

  " --> disable spell check by default - (enabled using autocommands later)
  " --> spell check is enabled later using autocommands, where required.
  set nospell

  " --> use default word list provided by the OS
  " --> use a `public`  dictionary file which can be versioned
  " --> use a `private` dictionary file which can be opted out from versioning
  set dictionary=/usr/share/dict/words
  set spellfile=~/.vim/spell/public.utf-8.add,~/.vim/spell/private.utf-8.add

  " --> manually added words are sent to `private` dictionary
  nnoremap zG 2zg

endif

