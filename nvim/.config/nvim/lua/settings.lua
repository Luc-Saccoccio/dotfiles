local o = vim.o
local w = vim.wo
local bo = vim.bo
local g = vim.g
local cmd = vim.cmd

-- Colors
o.termguicolors = true
o.syntax = 'on'

-- Buffers
o.hidden = true
o.splitbelow = true
o.splitright = true
o.updatetime = 100

-- Files
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'

-- LSP
bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
o.completeopt = 'menuone,noinsert,noselect'
g.completion_enable_auto_popup = 1
cmd('set shortmess+=c')

-- Miscellaneous
o.clipboard = 'unnamedplus'
g.nocompatible = true
o.mouse = 'a'
cmd('colorscheme spaceduck')
o.number = true
g.c_syntax_for_h = true
o.foldmethod = 'indent'

g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    }
g.tmuxline_preset = {
      a    = '#S',
      b    = '#T',
      c    = '#(whoami)',
      win  = '#I #W',
      cwin = {'#I', '#W', '#F'},
      x    = '',
      y    = {'%T', '%a', '%Y'},
      z    = '#(battery)'}
g.vimwiki_list = {
	{ path = '~/.local/share/vimwiki',
	path_html = '~/.local/share/vimwiki/html'},
	{ path = '~/.local/share/vimwikin',
	path_html = '~/.local/share/vimwikin/html'}}
cmd('autocmd BufEnter *.Rmd set spell spelllang=fr')
cmd('autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %')
cmd('autocmd FileType ocaml,haskell inoremap ,l λ')
cmd('command C !compiler %')
cmd('command O !opout %')
cmd('command CO !compiler % && opout %')
-- cmd('autocmd bufenter * if (("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')
