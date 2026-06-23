return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = false, -- Explicitly disable ruff LSP
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
      },
      automatic_installation = false, -- Disable auto-install completely
    },
  },
}
