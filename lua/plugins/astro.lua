-- ~/.config/nvim/lua/plugins/style_astro.lua
-- Non-invasive AstroNvim-inspired tweaks (no external Astro dependency)
return {
  {
    -- lightweight convenience: floating terminal toggle like Astro
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "Term" },
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        shade_terminals = true,
        direction = "float",
      })
    end,
  },
  {
    -- quick project root commands similar to Astro ergonomics
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function() require("dressing").setup({}) end,
  },
}
