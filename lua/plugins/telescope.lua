return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup({})
    require("plugins.telescope")
  end,
}
