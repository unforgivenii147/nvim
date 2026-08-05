return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cspell = {
          filetypes = { "markdown", "text", "lua", "python", "javascript" },
        },
      },
    },
  },
}
