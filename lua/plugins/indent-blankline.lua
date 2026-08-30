return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = {
      char = "│",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
      },
    },
  },
}
