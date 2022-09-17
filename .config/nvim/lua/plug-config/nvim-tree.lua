local tree = require('nvim-tree')

tree.setup {
	disable_netrw = true,
	hijack_netrw = true,
	-- auto_close = false,
	hijack_cursor = false,
	renderer = {
		icons = {
			show = {
				git = true,
				folder = true,
				file = true,
				folder_arrow = true,
			}
		}
	},
}
