return {
  "benlubas/molten-nvim",
  version = "^1.0.0",
  build = ":UpdateRemotePlugins",
  init = function()
    vim.g.molten_image_provider = "image.nvim"
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = false
  end,
  keys = {
    { "<leader>mi", "<cmd>MoltenInit<cr>", desc = "Initialize Molten" },
    { "<leader>me", "<cmd>MoltenEvaluateOperator<cr>", desc = "Evaluate operator" },
    { "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", desc = "Evaluate line" },
    { "<leader>mc", "<cmd>MoltenReevaluateCell<cr>", desc = "Reevaluate cell" },
    { "<leader>md", "<cmd>MoltenDelete<cr>", desc = "Delete cell" },
    { "<leader>mh", "<cmd>MoltenHideOutput<cr>", desc = "Hide output" },
    { "<leader>ms", "<cmd>MoltenShowOutput<cr>", desc = "Show output" },
  },
}
