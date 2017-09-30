" --> action: RECOMMENDED
" -->  group: PROGRAMMING, LANGUAGE

" --> provide Ruby integration environment for VIM
" --> enable support for RBenv, Rails, Rake and RSpec
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'thoughtbot/vim-rspec'

" NOTE: `vim-bundler` uses 2 system commands that are expensive.
"       Therefore, we replace it with autocmds instead.
"
" Plugin 'tpope/vim-bundler'
" ' system('ruby -rubygems -e "print Gem.path.join(%(;))"')
" ' system('ruby -rrbconfig -e "print RbConfig::CONFIG[\"ruby_version\"]"')

" --> provide helpers to refactor ruby code
Plug 'ecomba/vim-ruby-refactoring'

" --> detect correct file types for ruby related extensions
augroup detect_filetypes
  au BufNewFile,BufRead gemrc setl ft=yaml
  au BufNewFile,BufRead *.thor,*.rabl setl ft=ruby
  au BufNewFile,BufRead config.ru,.autotest,.irbrc,.pryrc,.simplecov setl ft=ruby
  au BufNewFile,BufRead Rakefile,Capfile,Gemfile,Guardfile,VagrantFile,Thorfile setl ft=ruby
augroup end

" --> provide autocompletion for ruby files
augroup omni_complete
  if exists('+omnifunc')
    autocmd filetype ruby setlocal omnifunc=rubycomplete#Complete
    autocmd filetype ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd filetype ruby,eruby let g:rubycomplete_rails = 1
    autocmd filetype ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd filetype ruby,eruby let g:rubycomplete_include_object = 1
    autocmd filetype ruby,eruby let g:rubycomplete_include_objectspace = 1
  end
augroup end

" --> set whitespace settings for Ruby related files
augroup setup_whitespace
  au filetype ruby,eruby setl ts=2 sw=2 sts=2 tw=80 et
augroup end

" --> dictate how to create folds for ruby files
augroup create_folds
  au filetype ruby,eruby setl fdm=syntax
augroup end

" --> provide proper/additional help for ruby files
let g:investigate_use_url_for_ruby=1
let g:investigate_syntax_for_rspec="ruby"
let g:investigate_url_for_ruby="http://ruby-doc.com/search.html?q=^s"

" --> use documentation for Rails when inside a Rails buffer
augroup documentor_ruby
  au!
  au User Rails silent! let g:investigate_syntax_for_ruby="rails"
  au BufLeave *.rb silent! let g:investigate_syntax_for_ruby="ruby"
augroup end

" --> run current file (if script) when <F5> is pressed
augroup jobs_and_tasks
  au BufRead,BufEnter *.rb if executable(expand("%:p")) &&
        \ ( &makeprg == "make" ) | setl makeprg=%:p | endif
augroup end

" --> persist ruby gem ctags when we move inside gem directories
augroup gem_ctags
  au!
  au BufEnter *.rb setl tags+=$RBENV_ROOT/versions/*/lib/ruby/gems/*/gems/*/tags
  au BufLeave *.rb setl tags-=$RBENV_ROOT/versions/*/lib/ruby/gems/*/gems/*/tags
augroup END

" --> provide mappings to run RSpec for current buffer
function! RunSpecs(...)
  let l:inside_app   = expand("%:h") =~ "app"
  let l:is_spec_file = expand("%:h") =~ "spec"
  if l:is_spec_file
    let l:path = expand("%")
  else
    let l:path = "spec/" . expand("%:h:t") . "/" . expand("%:t:r:r:r:r:r") . "_spec.rb"
    let l:path = substitute(l:path, "_spec_spec.rb", "_spec.rb", "g")
  end
  if filereadable(l:path)
    let l:path = a:0 && !empty(a:1) ? fnamemodify(l:path, a:1) : l:path
    let l:path = a:0 < 2 || empty(a:2) || l:inside_app ? l:path : l:path . a:2
    echo "Running specs: " . l:path
    execute substitute(g:rspec_command, "{spec}", l:path, "g")
  else
    echohl WarningMsg | echo "No such file found: " . l:path | echohl None
  endif
endfunction
let g:rspec_runner = "os_x_iterm2"
let g:rspec_command = "Dispatch bundle exec rspec {spec}"
map <Leader>rsf :call RunSpecs()<CR>
map <Leader>rsn :call RunSpecs("", ":" . line("."))<CR>
map <Leader>rsl :call RunLastSpec()<CR>
map <Leader>rsa :call RunSpecs(":h:h")<CR>
map <Leader>rsg :call RunSpecs(":h")<CR>
