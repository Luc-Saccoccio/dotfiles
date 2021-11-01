augroup pyfiles
  au BufReadPre *.py setlocal foldmethod=indent
  au BufWinEnter *.py if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

set foldmethod=indent
let b:ale_linters = ['pylint']

nnoremap <F9> :60vsplit term://ipython -i %<CR>i
inoremap <F9> :60vsplit term://ipython -i %<CR>i
