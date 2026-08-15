-- ~/.config/nvim/lua/plugins/catppuccin.lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          lsp_trouble = true,
          cmp = true,
          dap = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
