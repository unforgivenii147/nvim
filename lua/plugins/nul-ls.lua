-- ~/.config/nvim/lua/plugins/null-ls.lua
return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "mason-org/mason.nvim", "jay-babu/mason-null-ls.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics

      null_ls.setup({
        sources = {
          -- Ruff as formatter and diagnostics
          formatting.ruff,
          diagnostics.ruff,
        },
        on_attach = function(client, bufnr)
          -- if client supports formatting, keep LSP format key mapped to vim.lsp.buf.format
        end,
      })
    end,
  },
}
