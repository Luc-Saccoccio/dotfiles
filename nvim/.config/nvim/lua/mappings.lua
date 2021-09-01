local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<Space>', ':nohlsearch<Bar>:echo<CR>', {})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {noremap = true, expr = true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {noremap = true, expr = true})

map('n', '<leader>F', ':setlocal spell spellang=fr<CR>', {})
map('n', '<leader>E', ':setlocal spell spellang=en<CR>', {})

map('n', '<C-p>', ':TagbarToggle<CR>', {})
-- map('n', '<C-n>', ':NERDTreeToggle<CR>', {})
map('n', '<C-n>', ':NvimTreeToggle<CR>', {})
map('n', '<C-l>', ':TroubleToggle<CR>', {})

map('i', '<leader><leader>', '<Esc>/<++><Enter>"_c4l', {})
map('n', '<leader><leader>', '<Esc>/<++><Enter>"_c4l', {})

map('n', '<A-Up>', ':wincmd k<CR>', {})
map('n', '<A-Down>', ':wincmd j<CR>', {})
map('n', '<A-Left>', ':wincmd h<CR>', {})
map('n', '<A-Right>', ':wincmd l<CR>', {})
map('n', '<A-S-Up>', ':wincmd K<CR>', {})
map('n', '<A-S-Down>', ':wincmd J<CR>', {})
map('n', '<A-S-Left>', ':wincmd H<CR>', {})
map('n', '<A-S-Right>', ':wincmd L<CR>', {})

map('n', '<C-j>', ':m .+1<CR>==', {})
map('n', '<C-k>', ':m .-2<CR>==', {})
map('i', '<C-j>', ':m .+1<CR>==', {})
map('i', '<C-k>', ':m .-2<CR>==', {})
map('v', '<C-j>', ':m .+1<CR>==', {})
map('v', '<C-k>', ':m .-2<CR>==', {})

map('n', 't<Left>', ':tabfirst<CR>', {})
map('n', 't<Right>', ':tablast<CR>', {})
map('n', 'tt', ':tabnew<CR>', {})
map('n', 'tn', ':tabnext<CR>', {})
map('n', 'tp', ':tabprev<CR>', {})
map('n', '<F8>', ':tabn<CR>', {})

map('n', '<F5>', ':term<CR>')

map('i', '<C-a>', '<C-O>za', {})
map('n', '<C-a>', 'za', {})
map('o', '<C-a>', '<C-O>za', {})
map('v', '<C-a>', 'zf', {})

map('n', 'cn', ':cnext<CR>', {})
map('n', 'cp', ':cprevious<CR>', {})

map('n', '<leader>D', ':colorscheme spaceduck<CR>', {})
map('n', '<leader>B', ':colorscheme base16-seti<CR>', {})
map('n', '<leader>L', ':colorscheme rusticated<CR>', {})
