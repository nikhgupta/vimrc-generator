" --> action: REQUIRED, IGNORED
" -->  group: COMPLEX, SOMETHING

" --> this is a sample title for a feature
set somefeature

" --> this is a sample title for another feature
" --> I have multiple headers ;)
" --> another additional title
set someotherfeature

function TestFunc(args,...)
  echom 'I am a test!'
endfunction

" --> this feature depends on ruby
if has('ruby')
  set rubyspecificfeature
  set anotherrubyfeature
endif

" --> ensuring that parser doesnt mess up this code
set someotherfeature

function TestFunc(args,...)
  echom 'I am a test!'
endfunction

if has('ruby')
  set afeature
endif

" --> section depends on python
if has('python')
  set pythonspecificfeature
endif

" --> so does this one
" --> this one has multiple indented headers
if has('python')
  set anotherpythonfeature
endif

" --> this section has all config commented out
" set obsolete
" function! ObsoleteFunc()
"   set somethinghere
" endfunction
