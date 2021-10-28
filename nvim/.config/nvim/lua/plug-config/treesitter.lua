local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    ensure_installed = "all",
    highlight = {
	    enable = true,
	    disable = { }
    }
}
