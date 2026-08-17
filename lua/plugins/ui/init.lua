return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-web-devicons" },
    opts = {},
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { { path = "luvit-meta/library", words = { "vim%.uv" } } },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-web-devicons" },
    opts = {
      options = { theme = "auto" },
    },
  },
  {
    "benlubas/molten-nvim",
    dependencies = {
      "3rd/image.nvim",
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-web-devicons" },
    opts = {},
  },
  { import = "lazyvim.plugins.extras.lang.python" },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
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
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
