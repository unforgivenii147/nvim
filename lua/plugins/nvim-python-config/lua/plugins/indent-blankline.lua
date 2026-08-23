return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("ibl").setup({
      indent = { char = "│" },
      scope = { enabled = false },
      exclude = { filetypes = { "help", "packer" } },
    })
  end,
}
