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
--[[ g.repl = {
    python = {
        bin = 'python',
        args = '',
        syntax = 'python',
        title = 'Python REPL',
    },
    haskell = {
        bin = 'ghci',
        args = '',
        syntax = 'haskell',
        title = 'Haskell REPL',
    },
    ocaml = {
        bin = 'utop',
        args = '',
        syntax = 'ocaml',
        title = 'OCaml REPL',
    }
} ]]
g.slime_target = "neovim"

-- LSP
bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
o.completeopt = 'menuone,noinsert,noselect'
g.completion_enable_auto_popup = 1
cmd('set shortmess+=c')

-- Miscellaneous
o.clipboard = 'unnamedplus'
o.guifont = 'FiraCode Nerd Font:h15'
g.nocompatible = true
g.loaded_netrwPlugin = true
o.title = true
o.mouse = 'a'
cmd('colorscheme spaceduck')
o.number = true
g.vimtex_compiler_engine = 'xelatex'
g.c_syntax_for_h = true
o.foldmethod = 'indent'
g.python3_host_prog = "/usr/bin/python3"
g.python_host_prog = "/usr/bin/python"

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
cmd('autocmd BufEnter *.Rmd set spell spelllang=fr')
cmd('autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %')
cmd('autocmd FileType ocaml,haskell inoremap ,l λ')
cmd('autocmd BufWritePre * :%s/\\s\\+$//e')
cmd('command C !compiler %')
cmd('command O !opout %')
cmd('command CO !compiler % && opout %')
