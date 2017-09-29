  " " Function: Return first argument if day time, otherwise second argument {{{
  " function! DayOrNight(day, night)
  "   let curr_hour = strftime("%H")
  "   return curr_hour > 7 && curr_hour < 19 ? a:day : a:night
  " endfunction
  " " }}}
  " " Function: Quick distraction-free theme setup for Thematic {{{
  " function! DistractionFree(theme)
  "   let l:theme = {
  "   \     'ruler': 1,
  "   \     'laststatus': 0,
  "   \     'sign-column-color-fix': 1,
  "   \     'fold-column-color-mute': 1,
  "   \     'number-column-color-mute': 1,
  "   \ }
  "   call extend(l:theme, a:theme)
  "   return l:theme
  " endfunction
  " " }}}
  " " Function: Add a day night theme to thematic {{{
  "   function! AddDayNightThemeForThematic(name)
  "     let g:thematic#themes[a:name] = DayOrNight(
  "           \ g:thematic#themes[a:name . "-light"],
  "           \ g:thematic#themes[a:name . "-dark" ]
  "           \ )
  "   endfunction
  " " }}}
" let g:thematic#defaults['airline-theme'] = DayOrNight("solarized", "base16")
" Advanced:    can account for time of day, and switch themes accordingly {{{
  " Plugin 'reedes/vim-thematic'
  " use 256 colorspace support, since we want to use a base16 colorscheme.
  " NOTE: this requires `base16-shell` to be sourced by our ZSH configuration,
  " so that the terminal program can support 256 colorspace, as well.
  " let base16colorspace = 256
  " let g:base16_shell_path = $BASE16_SHELL

  " let g:thematic#defaults["linespace"]  = 0
  " if g:is_macvim
  "   let g:thematic#defaults["fullscreen"] = &fullscreen
  "   let g:thematic#defaults["fullscreen-background-color-fix"] = &fullscreen
  " else
  "   let g:thematic#defaults["fullscreen"] = 1
  "   let g:thematic#defaults["fullscreen-background-color-fix"] = 1
  " endif

  " let g:thematic#themes["default-dark"] = {
  "       \ 'colorscheme'  : 'base16-eighties',
  "       \ 'background'   : 'dark',
  "       \ 'airline-theme': 'base16' }
  " let g:thematic#themes["default-light"] = {
  "       \ 'colorscheme'  : 'solarized',
  "       \ 'background'   : 'light',
  "       \ 'airline-theme': 'solarized' }
  " call AddDayNightThemeForThematic('default')

  " " switch theme on GUI as per day/night, but use dark version for terminal vim
  " let g:thematic#theme_name = g:is_gui ? 'default-light' : 'default-dark'

  " nmap <silent> <leader>atd :Thematic default<CR>

