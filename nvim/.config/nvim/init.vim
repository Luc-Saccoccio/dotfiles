" ┏━┓━┏┓━━━━━━━━━━━━━━━━━━
" ┃┃┗┓┃┃━━━━━━━━━━━━━━━━━━
" ┃┏┓┗┛┃┏━━┓┏━━┓┏┓┏┓┏┓┏┓┏┓
" ┃┃┗┓┃┃┃┏┓┃┃┏┓┃┃┗┛┃┣┫┃┗┛┃
" ┃┃━┃┃┃┃┃━┫┃┗┛┃┗┓┏┛┃┃┃┃┃┃
" ┗┛━┗━┛┗━━┛┗━━┛━┗┛━┗┛┗┻┻┛
" ━━━━━━━━━━━━━━━━━━━━━━━━
" ━━━━━━━━━━━━━━━━━━━━━━━━

" ===================== PLUGINS ============================ "

call plug#begin('~/.config/nvim/plugged')

Plug 'TaDaa/vimade'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } " Python syntax
Plug 'dense-analysis/ale' " ALE
Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } " Nerdtree file manager
Plug 'bling/vim-airline', "Vim-airline
Plug 'vim-airline/vim-airline-themes' "Themes for vim-airline
	let g:airline_theme='lucius' " Use murmur theme
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'edkolev/tmuxline.vim' " Tmux matching nvim
Plug 'ryanoasis/vim-devicons' "Have icons in vim
Plug 'lilydjwg/colorizer' " Colorize HTML codes
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
Plug 'ObserverOfTime/discord.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'tomtom/tcomment_vim' " Commenting
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim', 'for': 'haskell', 'on': 'Ghcid' } " Haskell ghcid
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' } " Better Haskell syntax Highlightinh and other stuff
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' } " Spaceduck theme
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'copy/deoplete-ocaml', { 'for' : 'haskell' } " OCaml sources for deoplte
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' } " Python sources for completion
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' } " Haskell Completion
Plug 'alx741/vim-stylishask', { 'for': 'haskell' } " Prettier Haskell
Plug 'vimwiki/vimwiki'
Plug 'racer-rust/vim-racer', { 'for': 'rust' } " Rust completion sources
" WAITING FOR NIGHTLY
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'romgrk/barbar.nvim'

call plug#end()

" ===================== GENERAL ============================ "

set encoding=utf-8 " Use utf-8 encoding
set mouse=a " Use all mouse options
" set nohlsearch " Don't hightlight all when searching
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set clipboard=unnamedplus " Use system clipboard
set nocompatible " Use Vim settings instead of Vi settings
filetype plugin on " Autodetect filetype
syntax enable " Enable syntax highlighting
set termguicolors " Set termguicolors
colorscheme spaceduck " Use spaceduck colorscheme
set number "relativenumber
set splitbelow splitright
set history=10
set shada='100,f0
set rtp+=/home/luc/.opam/default/share/merlin/vim
let mapleader = "µ" " Use a different map leader
set conceallevel=0
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = "complete"
call deoplete#custom#option('auto_complete_delay', 0)
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc shiftwidth=4 softtabstop=4 expandtab

" Airline
let g:airline_symbols = {}
let g:airline_symbols.linenr = 'Ξ'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#whitespace#symbol= '!'

" Sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Vimwiki
let g:vimwiki_list = [{'path': '~/.local/share/vimwiki', 'path_html': '~/.local/share/vimwiki/html'}]

" ========================== TMUX ========================== "

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#T',
      \'c'    : '#(whoami)',
      \'win'  : '#I #W',
      \'cwin' : ['#I', '#W', '#F'],
      \'x'    : '',
      \'y'    : ['%T', '%a', '%Y'],
      \'z'    : '#(battery)'}

" ===================== MAPPINGS =========================== "

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
tnoremap <Esc> <C-\><C-n>

" Spell Verification
map <leader>F :setlocal spell spelllang=fr<CR>
map <leader>E :setlocal spell spelllang=en<CR>

" Tagbar
map <C-p> :TagbarToggle<CR>

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Navigating between marks
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

" FZF options
map <leader>ff :Files<Enter>
map <leader>fb :Buffers<Enter>
map <leader>fc :Colors<Enter>
map <leader>fm :Marks<Enter>
map <leader>fw :Windows<Enter>
map <leader>fc :Commands<Enter>
map <leader>fi :Filetypes<Enter>

" Moving between windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <silent> <A-S-Up> :wincmd K<CR>
nmap <silent> <A-S-Down> :wincmd J<CR>
nmap <silent> <A-S-Left> :wincmd H<CR>
nmap <silent> <A-S-Right> :wincmd L<CR>

" Moving lines 
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Tab navigation
nnoremap t<Left> :tabfirst<CR>
nnoremap t<Down> :tabnext<CR>
nnoremap t<Up> :tabprev<CR>
nnoremap t<Right> :tablast<CR>
nnoremap tn :tabnew<CR>
nnoremap <F8> :tabn<CR>

" Term
nnoremap <F5> :term<CR>

" Folding
inoremap <C-a> <C-O>za
nnoremap <C-a> za
onoremap <C-a> <C-C>za
vnoremap <C-a> zf

" Advanced Searching
nnoremap <leader>/ :BLines<CR>

" Shellcheck
nnoremap <leader>aS :sp term://shellcheck %<cr>:resize 15<cr>

" ====================== AUTOCMD ============================ "

" Spell verification on md
autocmd BufEnter *.Rmd set spell spelllang=fr
autocmd bufenter * if (("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" xrdb when posting changes to xressources and xdefaults files
autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

autocmd FileType ocaml,haskell inoremap ,l λ

" ======================== FZF ============================== "

let $FZF_DEFAULT_COMMAND =  "rg --files --hidden"

" ===================== SCHEMES =========================== "

map <leader>D :colorscheme spaceduck<CR>
map <leader>B :colorscheme base16-seti<CR>
map <leader>L :colorscheme rusticated<CR>


" ================== USUALS FOR DOCUMENTS ================== "

" Compile
command C !compiler %

" View the result
command O !opout %

" Both, laziness fo brrrrrrrrr
command CO !compiler % && opout %
