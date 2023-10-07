local function my_on_attach(bufnr)
  local api  = require('nvim-tree.api')

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'o', api.node.run.system, opts('System open'))
end


return {
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
  system_open = {
    cmd = "xdg-open"
  },
    on_attach = my_on_attach,
}
