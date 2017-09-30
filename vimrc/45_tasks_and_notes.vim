" --> action: ADVANCED

" --> provide simple taskpaper (todolist) functionality
Plug 'irrationalistic/vim-tasks'
let g:TasksMarkerBase = '☐'
let g:TasksMarkerDone = '✔'
let g:TasksMarkerCancelled = '✘'
let g:TasksDateFormat = '%Y-%m-%d %H:%M'
let g:TasksAttributeMarker = '@'
let g:TasksArchiveSeparator = '＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿'
augroup task_plugin
  au!
  autocmd BufNewFile,BufReadPost *.TODO,TODO,*.todo,*.todolist,*.taskpaper,*.tasks set filetype=tasks
augroup end

" --> provide simple note-taking functionality
" --> environment_variable: SIMPLENOTE_USER, SIMPLENOTE_PASS
Plug 'mrtazz/simplenote.vim'
let g:SimplenoteUsername=$SIMPLENOTE_USER
let g:SimplenotePassword=$SIMPLENOTE_PASS
let g:SimplenoteFiletype="markdown"
let g:SimplenoteListHeight=30

" --> provide a scratchable buffer for scrappables
Plug 'duff/vim-scratch'
nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>
