" --> action: RECOMMENDED
" -->  group: APPEARANCE

" --> define whether to enable tabline? (default: true)
" --> customize: enable/disable tabline?
let g:enable_tabline = 1

set cmdheight=2                 " use a status bar that is 2 rows high
set laststatus=2                " tell VIM to always put a status line in

" --> report number of lines changed by a command whenever possible
set report=0
" --> abbreviate messages provided by VIM (no 'hit enter') :)
set shortmess+=filmnrxoOtT

" --> do not show vim mode anywhere else (statusline will do that for you)
set noshowmode

" --> show ruler and other relevant information in statusline
if has('cmdline_info')
  set ruler                     " Show the ruler
  set showcmd                   " show (partial) command in the last line of the screen
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
endif

" --> use/fallback to a simple statusline when Airline is disabled
if has('statusline') && !exists('g:loaded_airline')
  set stl=\ \ \[_%{mode()}_]\ \ \ [%Y/%{&ff}]\ %F\ %m%r\
        \ %=[%{g:ui_type}]\ %-17.(%l,%c%V%)\ %p\%\%\ \ \ %LL\ TOTAL
endif

" --> provides a beautiful status line for VIM via Airline
Plug 'bling/vim-airline'
let g:airline_inactive_collapse = 1
let g:airline_section_y = "%{airline#util#wrap(airline#parts#ffenc() . ' ' . g:ui_type, 0)}"
" --> enable powerline symbols in status line
let g:airline_powerline_fonts = 1

" --> set a default status line theme
if !exists('g:airline_theme') | let g:airline_theme = 'gruvbox' | endif
if !is_gui | let g:airline_theme = 'dark' | endif

" --> provide an optional tabline for tabs
if g:enable_tabline && exists('g:loaded_airline')
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#tab_min_count = 2
  let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#show_close_button = 1
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline#extensions#tabline#right_sep = ''
  let g:airline#extensions#tabline#right_alt_sep = ''
  let g:airline#extensions#tabline#excludes = ['*NERD*', '*Tagbar*', 'ControlP']
endif

" auto commands
augroup startup_screen
  au User Startified AirlineRefresh
augroup end
