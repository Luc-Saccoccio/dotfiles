local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
local treesitter = require('nvim-treesitter.configs')

parser_config.hare = {
  install_info = {
    url = "https://git.sr.ht/~ecmma/tree-sitter-hare",
    files = {"src/parser.c"}
  },
  filetype = "hare",
}

treesitter.setup {
    ensure_installed = "all",
    highlight = {
	    enable = true,
	    disable = { "haskell" }
    }
}
