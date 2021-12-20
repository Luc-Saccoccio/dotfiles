local function lsp_status()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
        end
    end
    return msg
end

require('lualine').setup {
	options = {
		theme = 'spaceduck',
		section_separators = { left = '', right = '' },
		component_separators = {left = '', right = ''},
		icons_enabled = true,
	},
	sections = {
		lualine_a = { {'mode', {upper = true,},}, },
		lualine_b = { {'branch', {icon = '',}, }, },
		lualine_c = {
			{'filename', file_status = true, separator = ''},
			{'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = { error = ' ', warn = ' ', info = ' ' },
				separator = ''
			},
			{ '%=', separator = '' },
                        { lsp_status, icon = ' LSP:'},
			-- color = { fg = '#ffffff', gui = 'bold' },
		},
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
	inactive_sections = {
		lualine_a = {  },
		lualine_b = {  },
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {  },
		lualine_z = {  },
	},
	extensions = {'nvim-tree'}
}
