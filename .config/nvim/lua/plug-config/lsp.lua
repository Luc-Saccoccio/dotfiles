local M = {}

M.config = function()

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')

  lspconfig.clangd.setup({ capabilities = capabilities, autostart = false })
  lspconfig.gopls.setup({ capabilities = capabilities })
  lspconfig.hls.setup({ capabilities = capabilities })
  lspconfig.leanls.setup({ capabilities = capabilities })
  lspconfig.ocamllsp.setup({ root_dir = vim.loop.cwd, capabilities = capabilities })
  lspconfig.pylsp.setup({ root_dir = vim.loop.cwd, capabilities = capabilities })
  lspconfig.rust_analyzer.setup({ root_dir = vim.loop.cwd, capabilities = capabilities })
  lspconfig.texlab.setup({ capabilities = capabilities, autostart = false })
  lspconfig.zls.setup({ root_dir = vim.loop.cwd, capabilities = capabilities })

end

return M
