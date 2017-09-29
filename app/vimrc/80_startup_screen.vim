" --> action: RECOMMEND
" -->  group: APPEARANCE

" --> customize: dotfiles location
let g:dotfiles_dir = '~/Code/dotcastle'    " customize location to dotfiles directory

" --> provides a beautiful startup screen for VIM
Plug 'mhinz/vim-startify'

" --> do not display intro message on Vim startup
set shortmess+=I
" --> show bookmarks to dotfiles on startup screen
let g:startify_bookmarks = [ '~/.vimrc', '~/.zshrc', '~/.zshenv', g:dotfiles_dir ]
" --> display upto 10 recent files on Startup screen
let g:startify_files_number = 7
" --> skip some files from the recent files list in Startup screen
let g:startify_skiplist = [ 'COMMIT_EDITMSG', $VIMRUNTIME .'/doc', 'bundle/.*/doc', '/tmp' ]

" --> when a bookmark is opened via Startup screen, switch to its directory
let g:startify_change_to_dir = 1
" --> change to the root repository path, if any, when opening files
let g:startify_change_to_vcs_root = 1

" --> enable 'empty buffer', and 'quit' commands in Startup screen
let g:startify_enable_special = 0
" --> allow <o> key to open an empty buffer
let g:startify_empty_buffer_key = 'o'
" --> first 4 bookmarks on Startup screen can be opened via Home row
let g:startify_custom_indices = [ 'a', 'd', 'f', 'l' ]

" --> use the specified session directory for restoring sessions
let g:startify_session_dir = expand("~/.vim") . "/tmp/sessions/"

" --> display bookmarks in a specific order
let g:startify_list_order = [
      \ ['   Your bookmarks:'], 'bookmarks',
      \ ['   Your sessions:'], 'sessions',
      \ ['   Your recently opened files (from current directory):'], 'dir',
      \ ['   Your recently opened files (all of them):'], 'files',
      \ ]

" --> display a nice VIM ASCII text at the bottom of Startup screen
let g:startify_custom_footer = [  '', '',
      \  '    ██╗   ██╗ ██╗ ███╗   ███╗    ',
      \  '    ██║   ██║ ██║ ████╗ ████║    ',
      \  '    ██║   ██║ ██║ ██╔████╔██║    ',
      \  '    ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║    ',
      \  '     ╚████╔╝  ██║ ██║ ╚═╝ ██║    ',
      \  '      ╚═══╝   ╚═╝ ╚═╝     ╚═╝    '  ]

" --> allow Startup screen to be opened via <leader>as
nmap <silent> <leader>as :Startify<CR>

" auto commands
augroup startup_screen
  au!
  au User Startified setl colorcolumn=0 buftype=
augroup end

" specify colors for startup screen
hi! default link StartifyBracket LineNr
hi! default link StartifyFile    Keyword
hi! default link StartifyFooter  String
hi! default link StartifyHeader  String
hi! default link StartifyNumber  Function
hi! default link StartifyPath    LineNr
hi! default link StartifySection Special
hi! default link StartifySelect  LineNr
hi! default link StartifySlash   LineNr
hi! default link StartifySpecial Special
