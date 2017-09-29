" --> action: OPTIONAL
" -->  group: POWER_USER

" --> provide toggle key to display all avialable location marks in gutter
Plug 'xsunsmile/showmarks'
let g:showmarks_enable = 0
map <silent> <leader>tsm :ShowMarksToggle<CR>
"
" following mappings are available, as well:
"   <leader>mt : Toggles ShowMarks on and off.
"   <leader>mh : Hides an individual mark.
"   <leader>ma : Hides all marks in the current buffer.
"   <leader>mm : Places the next available mark.
