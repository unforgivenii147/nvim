return {
  "neovim/nvim-lspconfig",
  dependencies = { "mason-org/mason-lspconfig.nvim", "saghen/blink.cmp" },
  opts = { diagnostics = { virtual_text = true } },
}
