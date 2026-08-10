-- Borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "single" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = "single" })

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
    vim.keymap.set('n', '<C-s>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<C-s>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<C-s>gr', vim.lsp.buf.references, opts)
  end,
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = {'n:i', 'v:s'},
  desc = 'Disable diagnostics in insert and select mode',
  callback = function(e) vim.diagnostic.enable(false, {bufnr = e.buf}) end
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = 'i:n',
  desc = 'Enable diagnostics when leaving insert mode',
  callback = function(e) vim.diagnostic.enable(true, {bufnr = e.buf}) end
})


return

function()

  vim.lsp.enable('clangd')
  vim.lsp.enable('gopls')
  vim.lsp.enable('hls')
  vim.lsp.enable('leanls')
  -- vim.lsp.enable('ocamllsp', { root_dir = vim.loop.cwd })
  vim.lsp.enable('pylsp', { root_dir = vim.loop.cwd })
  vim.lsp.enable('rust_analyzer', { root_dir = vim.loop.cwd })
  vim.lsp.enable('texlab')
  vim.lsp.enable('asm_lsp', { filetypes = { "asm", "vmasm", "nasm" }})
  -- vim.lsp.enable('zls', { root_dir = vim.loop.cwd })

end
