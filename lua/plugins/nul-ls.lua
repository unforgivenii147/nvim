return {
  {

    "folke/null-ls.nvim",
    dependencies = { "mason-org/mason.nvim", },
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local completion = null_ls.builtins.completion

      null_ls.setup({
        sources = {
          formatting.ruff,
          diagnostics.ruff,
        },
        on_attach = function(client, bufnr)
        end,
      })
    end,
  },
}


