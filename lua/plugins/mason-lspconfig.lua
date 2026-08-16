return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = { "mason.nvim" },
  opts = {
    ensure_installed = { "lua_ls", "pyright" },
  },
}
