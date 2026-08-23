-- lua/plugins/blink-cmp.lua
-- using blink.cmp (hypothetical plugin name) with LuaSnip + friendly-snippets
-- Replace "blink/cmp.nvim" with the actual plugin repo if different.
return {
  "blink/cmp.nvim",
  event = "InsertEnter",
  dependencies = {
     "blink/blink-compat",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-nvim-lsp", -- keep LSP source
    "hrsh7th/cmp-buffer",   -- keep buffer source
  },
  config = function()
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then return end
    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if not luasnip_ok then return end

    -- load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
      }),
    })
  end,
}
