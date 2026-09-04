return {
  -- Theme switcher keybindings
  {
    "catppuccin",
    keys = {
      {
        "<leader>tc",
        function()
          vim.cmd.colorscheme("catppuccin")
          vim.notify("Theme: Catppuccin", "info", { title = "Theme Changed" })
        end,
        desc = "Catppuccin",
      },
      {
        "<leader>tC",
        function()
          local current = require("catppuccin").options.flavour
          local flavours = { "latte", "frappe", "macchiato", "mocha" }
          local next = flavours[(vim.tbl_contains(flavours, current) and (vim.fn.index(flavours, current) + 1) % 4) + 1]
          vim.g.catppuccin_flavour = next
          vim.cmd.colorscheme("catppuccin")
          vim.notify("Catppuccin flavour: " .. next, "info", { title = "Theme Changed" })
        end,
        desc = "Toggle Catppuccin Flavour",
      },
    },
  },

  {
    "tokyonight.nvim",
    keys = {
      {
        "<leader>tt",
        function()
          vim.cmd.colorscheme("tokyonight")
          vim.notify("Theme: Tokyo Night", "info", { title = "Theme Changed" })
        end,
        desc = "Tokyo Night",
      },
      {
        "<leader>tT",
        function()
          local styles = { "night", "storm", "day", "moon" }
          local current = vim.g.tokyonight_style or "night"
          local idx = vim.fn.index(styles, current)
          local next = styles[(idx % #styles) + 1]
          vim.g.tokyonight_style = next
          vim.cmd.colorscheme("tokyonight")
          vim.notify("Tokyo Night style: " .. next, "info", { title = "Theme Changed" })
        end,
        desc = "Toggle Tokyo Night Style",
      },
    },
  },

  -- Set default theme on startup
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin", -- Change this to your preferred default
    },
  },
}
