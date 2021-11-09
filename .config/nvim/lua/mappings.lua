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

		{ 'S', "<cmd>colorscheme spaceduck<CR>" },
		{ 'B', "<cmd>colorscheme base16-seti<CR>" },
		{ 'L', "<cmd>colorscheme rusticated<CR>" },

		{ "<leader>", "<Esc>/<++><Enter>\"_c4l", mode = 'ni' },

		{ 'f', { -- Telescope
			{ 'c', "<cmd>Telescope fd cwd=$HOME/.config/nvim/<CR>" },
			{ 'd', "<cmd>Telescope lsp_document_symbols<CR>" },
			{ 'f', '<cmd>Telescope find_files<cr>' },
			{ 'g', {
				{ 'b', '<cmd>Telescope git_branches<CR>' },
				{ 'c', '<cmd>Telescope git_commits<CR>' },
				{ 's', '<cmd>Telescope git_status<CR>' },
			}},
			{ 'h', "<cmd>Telescope help_tags<CR>" },
			{ 'l', '<cmd>Telescope live_grep<cr>' },
			{ 'm', "<cmd>Telescope man_pages sections=1,2,3,7,8<CR>" },
			{ 'o', "<cmd>Telescope vim_options<CR>" },
			{ 'r', "<cmd>Telescope oldfiles<CR>" },
		}},
		{ 't', { -- Tabs
			{ "<Left>", "<cmd>tabfirst<CR>" },
			{ "<Right>", "<cmd>tablast<CR>" },
			{ 't', "<cmd>tabnew<CR>" },
			{ 'n', "<cmd>tabnext<CR>" },
			{ 'p', "<cmd>tabprev<CR>" }
		}},
		{ 'h', "<cmd>Dashboard<CR>" },
	}},
	{ 'c', {
		{ 'c', "<cmd>cclose<CR>" },
		{ 'p', "<cmd>cprevious<CR>" },
		{ 'n', "<cmd>cnext<CR>" },
		{ 'o', "<cmd>copen<CR>" },
		{ 'd', "<cmd>cd %:p:h<bar>lua print('current directory is ' .. vim.fn.getcwd())<CR>", silent = false },
		{ 'a', require('lspsaga.codeaction').code_action },
		{ 'i', require('lspsaga.diagnostic').show_line_diagnostics },
	}},
	{ 'K', require('lspsaga.hover').render_hover_doc },
	{ "<C-", {
		{ "w>", { -- Windows
				{ "<S-Up>", "<cmd>wincmd K<CR>" },
				{ "<S-Down>", "<cmd>wincmd J<CR>" },
				{ "<S-Left>", "<cmd>wincmd H<CR>" },
				{ "<S-Right>", "<cmd>wincmd L<CR>" },
		}},
		{ "-j>", ":m .+1<CR>==", mode='niv'},
		{ "-k>", ":m .-2<CR>==", mode='niv'},
		{ "-l>", "<cmd>TroubleToggle<CR>" },
		{ "-n>", "<cmd>NvimTreeToggle<CR>" },
		{ "-p>", "<cmd>SymbolsOutline<CR>" },
	}},
	{ "<Space>", "<cmd>nohlsearch<Bar>:echo<CR>" },
	{ "<Esc>", "<C-\\><C-n>", mode='t' },
	{ "<F5>", ":term<CR>" },
	{ "g", {
		{ "d", vim.lsp.buf.definition },
		{ "[", vim.lsp.diagnostic.goto_prev },
		{ "]", vim.lsp.diagnostic.goto_next },
	}},
	{ mode='i', options = { expr = true, noremap = true, silent = false }, {
		{ "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"' },
		{ "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"' },
	}}
})

map('c', 'vh', 'vert help ', { noremap = true, silent = false })
map('v', '<leader>a', ":lua require('scripts.align').align('", { noremap = true, silent = false })

--[[ map('n', 'cn', ':cnext<CR>', {})
map('n', 'cp', ':cprevious<CR>', {})

map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {noremap = true, expr = true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {noremap = true, expr = true})

map('n', 't<Left>', ':tabfirst<CR>', {})
map('n', 't<Right>', ':tablast<CR>', {})
map('n', 'tt', ':TablineTabNew<CR>', {})
map('n', 'tn', ':tabnext<CR>', {})
map('n', 'tp', ':tabprev<CR>', {})

map('n', '<C-p>', ':TagbarToggle<CR>', {})
map('n', '<C-n>', ':NvimTreeToggle<CR>', {})
map('n', '<C-l>', ':TroubleToggle<CR>', {})

map('n', '<F5>', ':term<CR>')

map('t', '<Esc>', '<C-\\><C-n>', {})

map('n', '<Space>', ':nohlsearch<Bar>:echo<CR>', {})

map('n', '<leader>F', ':setlocal spell spelllang=fr<CR>', {})
map('n', '<leader>E', ':setlocal spell spelllang=en<CR>', {})

map('n', '<C-w><S-Up>', ':wincmd K<CR>', {})
map('n', '<C-w><S-Down>', ':wincmd J<CR>', {})
map('n', '<C-w><S-Left>', ':wincmd H<CR>', {})
map('n', '<C-w><S-Right>', ':wincmd L<CR>', {})

map('i', '<leader><leader>', '<Esc>/<++><Enter>"_c4l', {})
map('n', '<leader><leader>', '<Esc>/<++><Enter>"_c4l', {})

map('n', '<C-j>', ':m .+1<CR>==', {})
map('n', '<C-k>', ':m .-2<CR>==', {})
map('i', '<C-j>', ':m .+1<CR>==', {})
map('i', '<C-k>', ':m .-2<CR>==', {})
map('v', '<C-j>', ':m .+1<CR>==', {})
map('v', '<C-k>', ':m .-2<CR>==', {})

map('i', '<C-a>', '<C-O>za', {})
map('n', '<C-a>', 'za', {})
map('o', '<C-a>', '<C-O>za', {})
map('v', '<C-a>', 'zf', {})

map('n', '<leader>S', ':colorscheme spaceduck<CR>', {})
map('n', '<leader>B', ':colorscheme base16-seti<CR>', {})
map('n', '<leader>L', ':colorscheme rusticated<CR>', {}) ]]
