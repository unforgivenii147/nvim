return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "mason-lspconfig.nvim",
    "blink.cmp",
  },
  opts = {
    diagnostics = { virtual_text = true },
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    require("mason-lspconfig").setup_handlers({
      function(server_name) lspconfig[server_name].setup({}) end,
    })
  end,
}
