" --> action: RECOMMEND
" -->  group: BASIC, DEFAULTS

" --> provide mapping to turn on a dedicate mode for pasting clipboard
set pastetoggle=<F2>

" --> provide mapping to paste code, format it and select it for further operations
function! PasteWithPasteMode(keys)
  if &paste
    execute("normal " . a:keys)
  else
    " Enable paste mode and paste the text, then disable paste mode.
    set paste
    execute("normal " . a:keys)
    set nopaste
  endif
endfunction
nnoremap <silent> <leader>p :call PasteWithPasteMode('p')<CR>`[v`]=`[v`]
nnoremap <silent> <leader>P :call PasteWithPasteMode('P')<CR>`[v`]=`[v`]

" --> share clipboard between VIM and OS
if g:is_nix && has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif

" --> store and cycle through previous clipboard entries
Plug 'maxbrunsfeld/vim-yankstack'
let g:yankstack_map_keys = 0           " we will remap keys

" --> provide mapping to cycle through previous pastes
nmap <leader>pc <Plug>yankstack_substitute_older_paste

" --> provide mapping to view all clipboard entries
nnoremap <leader>tys :Yanks<CR>

" --> provide mapping to reselect text that was just selected (or pasted)
nnoremap <leader>gv `[v`]

" --> replace text when pasting in visual mode
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
