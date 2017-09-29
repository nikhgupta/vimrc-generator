" " --> action: OPTIONAL
" " -->  group: POWER_USER, WRITERS

" " --> function to return first argument if day time, otherwise second argument
" function! DayOrNight(day, night)
"   let curr_hour = strftime("%H")
"   return curr_hour > 7 && curr_hour < 19 ? a:day : a:night
" endfunction

" " --> make current theme distraction-free in Thematic
" function! DistractionFree(theme)
"   let l:theme = {
"         \     'ruler': 1,
"         \     'laststatus': 0,
"         \     'sign-column-color-fix': 1,
"         \     'fold-column-color-mute': 1,
"         \     'number-column-color-mute': 1,
"         \ }
"   call extend(l:theme, a:theme)
"   return l:theme
" endfunction

" " --> function to switch themes in Thematic depending upon time of day
" function! AddDayNightThemeForThematic(name)
"   let g:thematic#themes[a:name] = DayOrNight(
"         \ g:thematic#themes[a:name . "-light"],
"         \ g:thematic#themes[a:name . "-dark" ]
"         \ )
" endfunction

" " --> set defaults for Thematic plugin
" Plug 'reedes/vim-thematic'
" let g:thematic#defaults = { }
" let g:thematic#defaults["linespace"]  = 0

" " --> use a Solarized theme in day and Base16 theme in night for StatusLine
" let g:thematic#defaults['airline-theme'] = DayOrNight("solarized", "nova")

" " --> fix Thematic issues with fullscreen windows
" if g:is_macvim
"   let g:thematic#defaults["fullscreen"] = &fullscreen
"   let g:thematic#defaults["fullscreen-background-color-fix"] = &fullscreen
" else
"   let g:thematic#defaults["fullscreen"] = 1
"   let g:thematic#defaults["fullscreen-background-color-fix"] = 1
" endif

" " --> set default day and night time themes for our VIM configuration
" let g:thematic#themes["default-dark"] = {
"       \ 'colorscheme'  : 'nova',
"       \ 'background'   : 'dark',
"       \ 'airline-theme': 'nova' }
" let g:thematic#themes["default-light"] = {
"       \ 'colorscheme'  : 'solarized',
"       \ 'background'   : 'light',
"       \ 'airline-theme': 'solarized' }

" " --> use darker theme for terminal VIM and switch themes for GUI
" let g:thematic#theme_name = g:is_gui ? 'default-light' : 'default-dark'
" call AddDayNightThemeForThematic('default')

" " --> provide a convenient key to switch back to this Thematic config
" nmap <silent> <leader>atd :Thematic default<CR>
