" --> action: RECOMMENDED
" -->  group: PROGRAMMING

" --> provide snippet extensions when editing code
Plug 'Shougo/neosnippet'
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet-snippets'
" enable snipmate compatibility for neosnippet
let g:neosnippet#enable_snipmate_compatibility = 1
" tell NeoSnippet about other snippets
let g:neosnippet#snippets_directory = [
      \ expand('~/.vim') . '/bundle/vim-snippets/snippets',
      \ expand('~/.vim') . '/data/snippets' ]

" --> provide mapping to edit snippets for current file type
noremap <leader>nse :NeoSnippetEdit -vertical -split -direction=belowright<CR>

" --> allow <Tab> key to jump between snippet placeholders
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : "\<TAB>"
