-- Small NvChad-inspired UX additions
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = { theme = "auto", section_separators = "", component_separators = "" },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function() require("indent_blankline").setup({ char = "▏", show_trailing_blankline_indent = false }) end,
  },
}
