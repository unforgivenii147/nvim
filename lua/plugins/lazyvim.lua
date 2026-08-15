-- ~/.config/nvim/lua/plugins/style_lazyvim.lua
-- LazyVim-style performance & startup friendly tweaks
return {
  {
    -- handy file explorer loaded lazily
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = "Neotree",
    config = function() require("neo-tree").setup({}) end,
  },
  {
    -- a small plugin to speed up startup by caching module results (like some LazyVim optimizations)
    "lewis6991/impatient.nvim",
    event = "VimEnter",
    config = function() pcall(require, "impatient") end,
  },
}
