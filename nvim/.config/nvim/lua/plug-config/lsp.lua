lspconfig = require('lspconfig')
completion_callback = require('completion').on_attach

lspconfig.hls.setup{
	on_attach = completion_callback,
	root_dir = vim.loop.cwd}
lspconfig.pylsp.setup{completion_callback}
lspconfig.clangd.setup{completion_callback}
lspconfig.ocamllsp.setup{completion_callback}
lspconfig.texlab.setup{completion_callback}
lspconfig.gopls.setup{completion_callback}
lspconfig.sqls.setup{completion_callback}
