return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    light_style = "day",
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark",
      floats = "dark",
    },
    day_brightness = 0.3,
    dim_inactive = true,
    lualine_bold = false,
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
    cache = true,
    plugins = {
      all = package.loaded.lazy == nil,
      auto = true,
      telescope = true,
    },

    require("lualine").setup({
      options = {
        theme = "tokyonight",
      },
    }),
  },
  vim.cmd.colorscheme("tokyonight"),
}
