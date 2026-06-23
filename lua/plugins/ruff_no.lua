return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = false,
      },
    },
  },
}
