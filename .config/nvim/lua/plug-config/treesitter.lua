local parser_configs = require "nvim-treesitter.parsers".get_parser_configs()
local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
        disable = { "haskell" }
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}
