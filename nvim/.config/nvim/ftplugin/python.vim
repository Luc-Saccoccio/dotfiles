augroup pyfiles
  au BufReadPre *.py setlocal foldmethod=indent
  au BufWinEnter *.py if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

set foldmethod=indent

nnoremap <leader>P :10split term://python -i %<CR>i
