return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap-python",
  },
  branch = "regexp",
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select virtualenv" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select cached virtualenv" },
  },
  opts = {
    name = { "venv", ".venv", "env", ".env" },
    auto_refresh = true,
  },
}
