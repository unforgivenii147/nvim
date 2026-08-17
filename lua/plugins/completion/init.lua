return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.compat",
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    },
    version = "*",
    opts = {
      keymap = { preset = "default" },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
}
