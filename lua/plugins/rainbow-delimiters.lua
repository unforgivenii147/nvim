return {
  "HiPhish/rainbow-delimiters.nvim",
  dir = "/data/data/com.termux/files/home/projects/lua/rainbow",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("rainbow-delimiters.setup").setup({
      strategy = {
        [""] = require("rainbow-delimiters").strategy["global"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
        python = "rainbow-delimiters",
      },
    })
  end,
}
