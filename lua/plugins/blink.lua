-- ~/.config/nvim/lua/plugins/blink.lua
-- Completion plugin: saghen/blink.cmp (replaces nvim-cmp)
return {
  {
    "saghen/blink.cmp",
    -- branch = "v1", -- uncomment to pin to stable branch if desired
    dependencies = {
      "L3MON4D3/LuaSnip", -- snippet engine (optional)
    },
    config = function()
      local ok, blink = pcall(require, "blink")
      if not ok then
        vim.notify("blink.cmp not available", vim.log.levels.WARN)
        return
      end

      blink.setup({
        sources = {
          { name = "lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        },
        -- Keep mappings minimal and let users tune; blink defaults are reasonable.
        -- If you want custom mappings, add mapping table here per blink docs.
      })
    end,
  },
}
