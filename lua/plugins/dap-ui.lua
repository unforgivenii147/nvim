return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-dap", "nvim-nio" },
  config = function() require("dapui").setup() end,
}
