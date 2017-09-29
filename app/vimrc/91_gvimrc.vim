" --> action: OPTIONAL
" -->  group: GRAPHICAL_VIM

if g:is_gui

  " --> maximize editor window when using GUI
  set lines=999 columns=999   " maximize GUI window
  set guitablabel=%N/\ %t\ %M " show tab number, name and status

  " --> disable unnecessary interfaces in GUI
  set guioptions-=T   " Remove the toolbar
  set guioptions-=m   " Remove the menu
  set guioptions+=c   " Use console dialogs
  set guioptions-=r   " remove scrollbar
  set guioptions-=R   " remove scrollbar
  set guioptions-=l   " remove scrollbar
  set guioptions-=L   " remove scrollbar

  " --> set specific fonts for GUI VIM
  " --> download_macosx: Fira Code
  " --> download_ubuntu: Ubuntu Mono derivative Powerline
  if g:is_mac
    set macligatures
    set guifont=Fira\ Code:h16
  elseif g:is_ubuntu
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
  elseif g:is_nix
    set guifont=Monospace\ 11
  endif

endif
