return {
  {
    -- edge
    -- nightfox.nvim
    -- vscode.nvim
    -- everforest
    -- github-nvim-theme
    -- sonokai
    dir = "~/projects/lua/vscode.nvim",
    name = "vscode",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("vscode")
    end,
  },
}
