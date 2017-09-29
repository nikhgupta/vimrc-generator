" --> action: RECOMMEND
" -->  group: VERSIONING, POWER_USER

" --> run git commands from within the editor
Plug 'tpope/vim-fugitive'

" --> display git diff for current buffer in gutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_enabled = 1      " enable gitgutter by default
let g:gitgutter_signs = 0        " but do not display signs by default
let g:gitgutter_diff_args = '-w' " ignore whitespace
let g:gitgutter_escape_grep = 1  " use the raw grep command
let g:gitgutter_realtime = 0     " let vim be snappier - don't lag.
let g:gitgutter_eager = 0        " do not lag
let g:gitgutter_map_keys = 0     " we will remap mappings
nmap ]h <Plug>GitGutterNextHunk<Plug>GitGutterPreviewHunk
nmap [h <Plug>GitGutterPrevHunk<Plug>GitGutterPreviewHunk
nmap <leader>hs  <Plug>GitGutterStageHunk
nmap <leader>hr  <Plug>GitGutterRevertHunk
nmap <leader>tgg :GitGutterSignsToggle<CR>

" --> manage Github Gists within the editor
" --> environment_variable: GITHUB_USER, GITHUB_TOKEN, NAME, EMAIL
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 0
let g:gist_get_multiplefile = 1
let g:gist_show_privates = 1
let g:github_user = $GITHUB_USER
let g:github_token = $GITHUB_TOKEN
let g:snips_author = "$NAME <$EMAIL>"

" --> provide repository viewer similar to `gitk`
Plug 'gregsexton/gitv'

" --> highlight conflict markers & provide mapping to jump to them
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
nmap <silent> <leader>co /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

" --> enable spell check and formatting options for Git commit buffers
augroup git_files
  au!
  autocmd BufRead,BufNewFile GHI_* set ft=gitcommit
  autocmd FileType gitcommit setlocal spell textwidth=72
augroup end
