" --> action: ADVANCED

" --> provide helpers to run simple unix commands from within the editor
Plug 'tpope/vim-eunuch'

" --> provide mappings to toggle specific editor features
" TODO: remove mappings obsolete because of this plugin
Plug 'tpope/vim-unimpaired'

" --> provide mapping to replay a macro linewise on a visual selection
"     NOTE: macro must be recorded in the `v` register
vnoremap <leader>qv :normal @v

" --> obfuscate the current buffer to hide from prying eyes
nnoremap <F9> mzggg?G'z

" --> provide a command to show the MD5 of the current buffer or range
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')
