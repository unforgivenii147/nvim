return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  lazy = true,
  config = function()
    require("mason").setup()
  end,
}
