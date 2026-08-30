return {
  {
    -- select from:
    -- edge
    -- glance
    -- nightfox
    -- vscode
    -- everforest
    -- github-nvim-theme
    -- sonokai
    dir = "~/projects/lua/glance",
    name = "glance",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("glance")
    end,
  },
}
