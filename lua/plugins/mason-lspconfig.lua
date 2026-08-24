return {
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    ensure_installed = { "pyright", "ruff" },
    automatic_installation = false,
  },
}
