return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "telescope-fzf-native.nvim",
    "telescope-symbols.nvim",
  },
  opts = {
    defaults = {
      file_ignore_patterns = { "node_modules", ".git" },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
