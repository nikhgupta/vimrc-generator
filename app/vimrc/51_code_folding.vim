" --> action: RECOMMEND
" -->  group: PROGRAMMING

" --> enabled code folding based on indentation by default
set nofoldenable       " do not enable folding, by default
set foldcolumn=0       " add a fold column to the left of line-numbers
set foldlevel=0        " folds with a higher level will be closed
set foldlevelstart=10  " start out with everything open
set foldmethod=indent  " create folds based on indentation
set foldnestmax=7      " deepest fold is 7 levels
set foldminlines=1     " do not fold single lines, fold everything else

" --> toggle fold on the current fold using <SPACE> key
nnoremap <Space> za
vnoremap <Space> za

" --> auto-unfold folds when specific commands are triggered
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" --> display informative text on code-foldings
function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
  return line . ' ' . repeat("-",fillcharcount) . ' ' . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" --> allow folding code/text to a specific level
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" --> take care not to screw up existing folds when inserting text
" read more: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
augroup FixFoldInsert
  au!
  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod |
        \ setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') |
        \ let &l:foldmethod=w:last_fdm |
        \ unlet w:last_fdm | endif
augroup end

" for use by other sections
augroup create_folds | au! | augroup end
