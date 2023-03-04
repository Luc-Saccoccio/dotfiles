local parser_configs = require "nvim-treesitter.parsers".get_parser_configs()
local treesitter = require('nvim-treesitter.configs')

parser_configs.hare = {
  install_info = {
    url = "https://git.sr.ht/~ecmma/tree-sitter-hare",
    files = {"src/parser.c"}
  },
  filetype = "hare",
}

parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}

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
