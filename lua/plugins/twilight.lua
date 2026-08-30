return {
  "folke/twilight.nvim",
  cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  opts = {
    dimming = {
      alpha = 0.25,
      color = { "Normal", "#ffffff" },
      term_bg = "#000000",
      inactive = true,
    },
    context = 10,
    treesitter = true,
    expand = {
      "function",
      "method",
      "table",
      "if_statement",
      "for_statement",
      "while_statement",
      "with_statement",
      "try_statement",
      "except_clause",
    },
  },
}
