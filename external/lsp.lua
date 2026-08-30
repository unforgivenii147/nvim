local capabilities = require("cmp_nvim_lsp").default_capabilities()

--require('lspconfig')['lua_ls'].setup {
--   capabilities = capabilities
--}

require("lspconfig")["ruff"].setup({
  capabilities = capabilities,
})

require("lspconfig")["pyright"].setup({
  capabilities = capabilities,
})
