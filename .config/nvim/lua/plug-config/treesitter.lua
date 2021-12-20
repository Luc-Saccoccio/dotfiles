-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
local treesitter = require('nvim-treesitter.configs')

--[[ parser_config.haskell = {
  install_info = {
    url = "~/path/to/tree-sitter-haskell",
    files = {"src/parser.c", "src/scanner.cc"}
  }
} ]]

treesitter.setup {
    ensure_installed = "all",
    highlight = {
	    enable = true,
	    disable = { "haskell" }
    }
}
