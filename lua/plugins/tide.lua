return {
  {
    name = "tide.nvim",
    dir = vim.fn.expand("~/projects/lua/Tide.nvim"),
    dev = true,

    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    opts = {
      keys = {
        leader = ";",
        panel = ";",
        add_item = "a",
        delete = "d",
        clear_all = "x",
        horizontal = "-",
        vertical = "|",
      },
      animation_duration = 300,
      animation_fps = 30,
      hints = {
        dictionary = "qwertzuiopsfghjklycvbnm",
      },
    },

    config = function(_, opts)
      require("tide").setup(opts)
    end,
  },
}
