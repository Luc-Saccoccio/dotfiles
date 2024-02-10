set foldmethod=indent
set expandtab
set shiftwidth=2
set tabstop=2
set smartindent
set autoindent
set formatprg=stylish-haskell
set keywordprg=doc\ haskell
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1
let g:necoghc_enable_detailed_browse = 1
let g:haskellmode_completion_ghc = 0
let b:ale_linters = ['hlint', 'stack_build', 'stack_ghc', 'cabal_ghc', 'brittany']

" colorscheme base16-seti
" lua require('lualine').setup{options={theme='aurora'}}

nnoremap <leader>G :10split term://ghci %<CR>i
nnoremap <leader>h :10split term://hlint %; read<CR>
