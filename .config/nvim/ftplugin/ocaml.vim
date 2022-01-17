setlocal tabstop=2
setlocal expandtab
setlocal shiftwidth=2
inoremap ,c (*  *)<ESC>2hi
setlocal formatprg=ocamlformat\ --impl\ --enable-outside-detected-project\ -
setlocal rtp^="/home/luc/.opam/default/share/ocp-indent/vim"
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

nnoremap <leader>U :12split term://utop -init %<CR>i
