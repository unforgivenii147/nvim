return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = function()
    local lspconfig = require("lspconfig")

    local on_attach = function(client, bufnr)
      local opts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    end

    lspconfig.pyright.setup({
      on_attach = on_attach,
      settings = {
        python = {
          analysis = { typeCheckingMode = "off" },
        },
      },
    })

    pcall(function() lspconfig.ruff_lsp.setup({ on_attach = on_attach }) end)
  end,
}
