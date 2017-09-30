" --> action: ADVANCED

" --> ignore whitespace in diff mode (focus on code changes only)
if has("diff") | set diffopt+=iwhite | endif

" --> view unsaved changes in the current buffer as a diff
if has("diff")
  function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  endfunction
  nnoremap <leader>ds :call DiffWithSaved()<CR>
endif
