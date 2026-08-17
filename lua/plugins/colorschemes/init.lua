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
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "sainnhe/edge",
    priority = 900,
  },
  {
    "sainnhe/everforest",
    priority = 900,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 900,
  },
  {
    "navarasu/onedark.nvim",
    priority = 900,
    opts = { style = "dark" },
    config = function(_, opts)
      require("onedark").setup(opts)
      vim.cmd.colorscheme("onedark")
    end,
  },
  {
    "artart222/CodeArt",
    priority = 900,
  },
  {
    "sainnhe/sonokai",
    priority = 900,
  },
  {
    "projekt0n/github-nvim-theme",
    priority = 900,
  },
}
