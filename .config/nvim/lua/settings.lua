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
o.relativenumber = true

-- Files
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
g.nvim_agda_settings = {
  agda = "/home/luc/.local/bin/agda",
}
g.asmsyntax = "nasm"

-- LSP
bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
o.completeopt = 'menuone,noinsert,noselect'
g.completion_enable_auto_popup = 1
cmd('set shortmess+=c')

-- Tabs
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

-- Miscellaneous
o.clipboard = 'unnamedplus'
o.lazyredraw = true
o.guifont = 'FiraCode Nerd Font:h12'
g.nocompatible = true
g.loaded_netrwPlugin = true
o.title = true
o.mouse = 'a'
cmd('colorscheme base16-seti')
o.number = true
g.c_syntax_for_h = true
o.foldmethod = 'indent'
g.python3_host_prog = "/usr/bin/python3"
g.python_host_prog = "/usr/bin/python"


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
   { path = '~/notes/home',
   path_html = '~/notes/home/html'},
   { path = '~/notes/work',
   path_html = '~/notes/work/html'}}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  command = "setlocal nofoldenable",
})

cmd('autocmd BufEnter *.Rmd set spell spelllang=fr')
cmd('autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %')
cmd('autocmd FileType ocaml,haskell inoremap ,l λ')
cmd('autocmd BufWritePre * :%s/\\s\\+$//e')
cmd('command O !opout %')
cmd([[
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
augroup END]])

-- spaceduck
--[[ cmd('hi NormalFloat guifg=#ecf0c1 ctermfg=255 guibg=#0f111b ctermbg=233 gui=NONE cterm=NONE')
cmd('hi FloatBorder guifg=#ecf0c1 ctermfg=255 guibg=#0f111b ctermbg=233 gui=NONE cterm=NONE') ]]
