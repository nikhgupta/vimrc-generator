" --> action: RECOMMENDED
" -->  group: APPEARANCE

" --> enable TrueColor support
if &term =~# '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" --> provide some beautiful colorschemes for the editor
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'trevordmiller/nova-vim'
Plug '29decibel/codeschool-vim-theme'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'altercation/vim-colors-solarized'
