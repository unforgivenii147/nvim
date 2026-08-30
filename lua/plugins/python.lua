return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {},
      },
    },
  },
  -- Configure formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_organize_imports" },
      },
    },
  },
  -- Running code: Use 'overseer.nvim' or simple keymaps
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>f", group = "format/fix" },
        { "<leader>fr", "<cmd>lua vim.lsp.buf.format({name = 'ruff'})<cr>", desc = "Ruff Format" },
        { "<leader>rr", "<cmd>w | !python3 %<cr>", desc = "Run Python File" },
      },
    },
  },
}
