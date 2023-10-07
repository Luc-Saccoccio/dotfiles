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

Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } " Python syntax
Plug 'nvim-lua/completion-nvim'
Plug 'dense-analysis/ale' " ALE
Plug 'lervag/vimtex', { 'for': ['tex', 'latex'] }
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } " Nerdtree file manager
Plug 'bling/vim-airline', "Vim-airline
Plug 'vim-airline/vim-airline-themes' "Themes for vim-airline
  let g:airline_theme='lucius' " Use lucius theme
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
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-signify' " Git
Plug 'machakann/vim-sandwich'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'romgrk/barbar.nvim'
Plug 'wfxr/minimap.vim'
Plug 'dstein64/vim-startuptime'

call plug#end()

" ===================== GENERAL ============================ "

set encoding=utf-8 " Use utf-8 encoding
set mouse=a " Use all mouse options
" set nohlsearch " Don't hightlight all when searching
nnoremap <Space> :nohlsearch<Bar>:echo<CR>
set clipboard=unnamedplus " Use system clipboard
set nocompatible " Use Vim settings instead of Vi settings
filetype plugin on " Autodetect filetype
syntax enable " Enable syntax highlighting
set termguicolors " Set termguicolors
set hidden
colorscheme spaceduck " Use spaceduck colorscheme
set number "relativenumber
set splitbelow splitright
set history=10
set shada='100,f0
" set rtp+=/home/luc/.opam/default/share/merlin/vim
let mapleader = "µ" " Use a different map leader
set conceallevel=0
set updatetime=100

lua << EOF
lspconfig = require('lspconfig')
completion_callback = require'completion'.on_attach

lspconfig.hls.setup{
  on_attach = completion_callback,
  root_dir = vim.loop.cwd
  }
lspconfig.pylsp.setup{completion_callback}
lspconfig.clangd.setup{completion_callback}
lspconfig.ocamllsp.setup{
  on_attach = completion_callback
  }
lspconfig.texlab.setup{completion_callback}
EOF

set omnifunc=v:lua.vim.lsp.omnifunc
set shortmess+=c
set completeopt=menuone,noinsert,noselect

let g:python3_host_prog = '/usr/bin/python'

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
let g:vimwiki_list = [{'path': '~/.local/share/vimwiki', 'path_html': '~/.local/share/vimwiki/html'}, {'path': '~/.local/share/vimwikin', 'path_html': '~/.local/share/vimwikin/html'}]

function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()

" ===================== BINARY ===================== "

command -bar Hexmode call ToggleHex()

function ToggleHex()
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    let b:oldft=&ft
    let b:oldbin=&bin
    setlocal binary
    silent :e
    let &ft="xxd"
    let b:editHex=1
    %!xxd
  else
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    let b:editHex=0
    %!xxd -r
  endif
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction


if has("autocmd")
  augroup Binary
    au!
    au BufReadPre *.bin,*.hex setlocal binary
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif
    au BufReadPost *
          \ if &binary | Hexmode | endif
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif
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

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! RandomLine() range
  ruby first_line = (VIM::evaluate 'a:firstline').to_i
  ruby last_line = (VIM::evaluate 'a:lastline').to_i
  ruby VIM::command(((rand last_line - first_line + 1) + first_line).to_s)
  ruby VIM::command("mark '")
endfunction
command! -range=% RandomLine <line1>,<line2>call RandomLine()
nnoremap gr :RandomLine<CR>


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
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Tab navigation
nnoremap t<Left> :tabfirst<CR>
nnoremap t<Right> :tablast<CR>
nnoremap tt :tabnew<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>
nnoremap <F8> :tabn<CR>

" Term
nnoremap <F5> :term<CR>

" Quickfix
nnoremap cc :cclose<CR>
nnoremap cp :cprevious<CR>
nnoremap cn :cnext<CR>
nnoremap co :copen<CR>

" Advanced Searching
nnoremap <leader>/ :BLines<CR>

" Shellcheck
nnoremap <leader>aS :sp term://shellcheck %<cr>:resize 15<cr>

nnoremap cn :cnext<CR>
nnoremap cp :cprevious<CR>

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

" Both, laziness go brrrrrrrrr
command CO !compiler % && opout %
