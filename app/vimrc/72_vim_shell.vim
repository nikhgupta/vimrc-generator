" --> action: RECOMMEND
" -->  group: PROGRAMMING

" --> detect correct file types for various shell files
augroup detect_filetypes
  au BufNewFile,BufRead *vimrc,*.vim setl ft=vim
  au BufNewFile,BufRead *zshrc,*zprofile,*zlogout,*zlogin,*zshenv,*.zsh-theme setl ft=sh
augroup end

" --> set whitespace settings for Vim and Shell files
augroup setup_whitespace
  au filetype sh  setl ts=2 sw=2 sts=2 tw=72 et
  au filetype vim setl ts=2 sw=2 sts=2 tw=72 et
augroup end

" --> dictate how to create folds for vim and shell files
augroup create_folds
  au filetype sh  setl fdm=marker fmr={{{,}}} fdls=0 fdl=0
  au filetype vim setl fdm=marker fmr={{{,}}} fdls=0 fdl=0
augroup end

" --> provide additional help for vim files via <gK> mapping
function! AdditionalHelpForVim()
  let g:investigate_use_url_for_vim = 1
  call investigate#Investigate()
  let g:investigate_use_url_for_vim = 0
endfunction
augroup documentor_vim | au!
  au filetype vim silent! nmap <silent> gK :call AdditionalHelpForVim()<CR>
augroup end

" --> run Shell files when <F5> is pressed
augroup jobs_and_tasks
  au filetype sh  setl makeprg=chmod\ +x\ %:p\ &&\ %:p
augroup end

" --> TODO: add selected lines to ~/.vimrc.local when <F5> is pressed
" augroup jobs_and_tasks
"   au filetype vim setl makeprg=
" augroup end

" --> provide mappings to edit and source vim config on fly
" edit the vimrc file
nmap <leader>e. :vs<CR>:e $MYVIMRC<CR>
" source the current file
nmap <leader>bs :source %<CR>:set foldenable<CR>:e!<CR>
" source a visual range
vmap <leader>bs y:@"<CR>:echo 'Sourced the selected range.'<CR>

" --> provide mapping to open URL for plugin on current line
"     FIXME: this can be improved using a function.
"            - specifically, use `gx` for all the niceties it provides
augroup vim_plugin_browser
  au!
  au filetype vim noremap <buffer> <F6>
        \ :normal ^f'ahttps://github.com/<Esc>:normal ^f'lgxu<CR>
augroup end

" --> provide mappings to navigate HELP in an easier manner
"     try pressing: <K> on any keyword to bring help,
"     and then press <q> to quit it right away ;)
augroup help_window
  au!
  au filetype help nnoremap <buffer><cr> <c-]>
  au filetype help nnoremap <buffer><bs> <c-T>
  au filetype help nnoremap <buffer>q    :q<CR>
augroup end
