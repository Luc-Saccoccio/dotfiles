local indent = require('indent_blankline')

vim.opt.list = true
table.insert(vim.opt.listchars, "space:⋅")
table.insert(vim.opt.listchars, "eol:↴")

indent.setup {
	char = "|",
	buftype_exclude = {"terminal"},
	filetype_exclude = { "help", "dashboard", "packer", "NvimTree" },
	context_patterns = { "^if", "^for", "class", "return", "function", "method", "^while", "else_cause", "if_statement", "block", "arguments", "try_statement", "catch_clause", "import_statement", "operation_type", "^match" },
	space_char_blankline = " ",
	show_current_context = true,
	use_treesitter = true,
	show_end_of_line = true,
	show_first_indent_level = false,
}
