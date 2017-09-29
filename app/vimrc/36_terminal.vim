" --> action: RECOMMEND
" -->  group: BASIC

" --> integrate with the user's login shell
  " NOTE: DO NOT ENABLE INTERACTIVE SHELL OR TERMINAL VIM WILL SUSPEND ITSELF.
  " NOTE: place environment variables in ~/.zshenv so that VIM can read them.
if !g:is_windows
  if !empty('$SHELL')
    set shell=$SHELL\ -l
  elseif executable('zsh')
    set shell=zsh\ -l
  elseif executable('bash')
    set shell=bash\ -l
  else
    set shell=/bin/sh
  endif
endif
Plug 'Shougo/vimshell.vim'

" --> use faster tty (terminal) & sets it title as per the file {{{
  set title
  set ttyfast
" --> set appropriate terminal colors for the terminal
if &t_Co > 2 && &t_Co < 16
  set t_Co =16
elseif &t_Co > 16
  set t_Co =256
endif

" --> provide function to run shell commands and capture their output in buffer
Plug 'sjl/clam.vim'
