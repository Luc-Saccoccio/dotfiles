inoremap ,c (*  *)<ESC>2hi
set formatprg="ocamlformat --name \"%:p\" -"
set rtp^="/home/luc/.opam/default/share/ocp-indent/vim"
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

nnoremap <leader>U :12split term://utop -init %<CR>i
