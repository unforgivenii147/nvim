return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    toggler = {
      line = "gcc",
      block = "gbc",
    },
    opleader = {
      line = "gc",
      block = "gb",
    },
  },
}
