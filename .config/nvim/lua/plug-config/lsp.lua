-- Borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "single"
  }
)

vim.diagnostic.config{
  float = { border = "single" }
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings. <C-s> prefix for lsp
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<C-s>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<C-s>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<C-s>K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-s>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-s><C-k>', vim.lsp.buf.signature_help, opts)
    --[[ vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts) ]]
    vim.keymap.set('n', '<C-s>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<C-s>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<C-s>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<C-s>gr', vim.lsp.buf.references, opts)
  end,
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = {'n:i', 'v:s'},
  desc = 'Disable diagnostics in insert and select mode',
  callback = function(e) vim.diagnostic.disable(e.buf) end
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = 'i:n',
  desc = 'Enable diagnostics when leaving insert mode',
  callback = function(e) vim.diagnostic.enable(e.buf) end
})


return

function()

  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')

  lspconfig.clangd.setup{}
  lspconfig.gopls.setup{}
  lspconfig.hls.setup{}
  lspconfig.leanls.setup{}
  -- lspconfig.ocamllsp.setup{ root_dir = vim.loop.cwd }
  lspconfig.pylsp.setup{ root_dir = vim.loop.cwd }
  lspconfig.rust_analyzer.setup{ root_dir = vim.loop.cwd }
  lspconfig.texlab.setup{}
  lspconfig.asm_lsp.setup{ filetypes = { "asm", "vmasm", "nasm" }}
  -- lspconfig.zls.setup{ root_dir = vim.loop.cwd }

end
