return {
  dir = "~/projects/lua//hex",
  name = "hex",
  lazy = true,
  config = function()
    require("hex").setup({
      keymaps = {
        enable = "<leader>hx", -- Enable hex mode
        disable = "<leader>hX", -- Disable hex mode
        toggle = "<leader>ht", -- Toggle hex mode
      },
    })
  end,
}
