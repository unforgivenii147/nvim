return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    -- Load the fzf extension after setup
    telescope.load_extension("fzf")
  end,
}
