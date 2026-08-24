return {
  "stevearc/conform.nvim",
  lazy = true,
  opts = {
    formatters_by_ft = {
      ["python"] = { "ruff_format", "ruff_organize_imports" },
    },
  },
}
