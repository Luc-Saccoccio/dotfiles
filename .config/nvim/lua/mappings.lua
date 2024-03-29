local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local nest = require('nest')

nest.applyKeymaps({
  { "<leader>", {
    { 'F', "<cmd>setlocal spell spelllang=fr<CR>" },
    { 'E', "<cmd>setlocal spell spelllang=en<CR>" },

    { 'S', "<cmd>colorscheme spaceduck<CR><cmd>lua require('lualine').setup { options = { theme = 'spaceduck'}}<CR>" },
    { 'L', "<cmd>colorscheme rusticated<CR>" },

    { "<leader>", "<Esc>/<++><Enter>\"_c4l", mode = 'ni' },

    { 'c', {
      { 'c', "<cmd>cclose<CR>" },
      { 'd', "<cmd>cd %:p:h<bar>lua print('current directory is ' .. vim.fn.getcwd())<CR>", silent = false },
      { 'l', vim.diagnostic.setloclist },
      { 'n', "<cmd>cnext<CR>" },
      { 'o', "<cmd>copen<CR>" },
      { 'p', "<cmd>cprevious<CR>" },
    }},

    { 'f', { -- Telescope
      { 'c', "<cmd>Telescope fd cwd=$HOME/.config/nvim/ hidden=true no_ignore=true<CR>" },
      { 'd', "<cmd>Telescope fd cwd=$HOME/.dotfiles hidden=true no_ignore=true<CR>" },
      { 'f', '<cmd>Telescope find_files<cr>' },
      { 'g', {
        { 'b', '<cmd>Telescope git_branches<CR>' },
        { 'c', '<cmd>Telescope git_commits<CR>' },
        { 's', '<cmd>Telescope git_status<CR>' },
      }},
      { 'h', "<cmd>Telescope hoogle<CR>" },
      { 'l', '<cmd>Telescope live_grep<cr>' },
      { 'm', "<cmd>Telescope man_pages sections=1,2,3,7,8<CR>" },
      { 'o', "<cmd>Telescope vim_options<CR>" },
      { 'r', "<cmd>Telescope oldfiles<CR>" },
      { 'b', "<cmd>Telescope buffers<CR>" },
    }},
  }},
  { "<C-", {
    { "w>", { -- Windows
        { "<S-Up>", "<cmd>wincmd K<CR>" },
        { "<S-Down>", "<cmd>wincmd J<CR>" },
        { "<S-Left>", "<cmd>wincmd H<CR>" },
        { "<S-Right>", "<cmd>wincmd L<CR>" },
    }},
    { "-n>", "<cmd>NvimTreeFindFileToggle<CR>" },
  }},
  { "<Space>", "<cmd>nohlsearch<Bar>:echo<CR>" },
  { "<Esc>", "<C-\\><C-n>", mode='t' },
  { "<F5>", ":term<CR>" },
  { "g", {
    { "d", vim.lsp.buf.definition },
    { 'l', vim.diagnostic.open_float },
  }},
  { mode='i', options = { expr = true, noremap = true, silent = false }, {
    { "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"' },
    { "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"' },
  }}
})

map('c', 'vh', 'vert help ', { noremap = true, silent = false })
map('c', 'vg', 'vert helpgrep', { noremap = true, silent = false })
map('c', 'hg', 'helpgrep', { noremap = true, silent = false })
