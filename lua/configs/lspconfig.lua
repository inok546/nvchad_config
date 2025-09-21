local nvlsp = require "nvchad.configs.lspconfig"

vim.lsp.config('clangd', {
  capabilities = nvlsp.capabilities,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
})

vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')

