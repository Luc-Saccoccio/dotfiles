local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.hls.setup({ capabilities = capabilities })
lspconfig.ocamllsp.setup({ root_dir = vim.loop.cwd, capabilities = capabilities })
lspconfig.pylsp.setup({ capabilities = capabilities })
lspconfig.sumneko_lua.setup({ cmd = {"/usr/bin/lua-language-server"}, capabilities = capabilities, autostart = false })
lspconfig.texlab.setup({ capabilities = capabilities, autostart = false })
lspconfig.rust_analyzer.setup({ root_dir = vim.loop.cwd, capabilities = capabilities })
lspconfig.zls.setup({ root_dir = vim.loop.cwd, capabilities = capabilities })
