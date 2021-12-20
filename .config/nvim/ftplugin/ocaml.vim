inoremap ,c (*  *)<ESC>2hi
set formatprg="ocamlformat --name \"%:p\" -"

nnoremap <leader>U :12split term://utop -init %<CR>i
