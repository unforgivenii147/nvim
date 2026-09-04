return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "ruff_organize_imports" },
      lua = { "stylua" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      -- Add more file types if needed:
      -- toml = { "taplo" },
      -- sh = { "shfmt" },
      -- javascript = { "prettier" },
      -- typescript = { "prettier" },
      -- html = { "prettier" },
      -- css = { "prettier" },
    },
    formatters = {
      ruff_format = {
        command = "ruff",
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
        stdin = true,
      },
      ruff_organize_imports = {
        command = "ruff",
        args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
        stdin = true,
      },
    },

    -- Optional: Format on save (uncomment if you want auto-formatting)
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },

    -- Optional: Log level
    -- log_level = vim.log.levels.DEBUG,

    -- Optional: Notify on format
    -- notify_on_error = true,
  },
}
