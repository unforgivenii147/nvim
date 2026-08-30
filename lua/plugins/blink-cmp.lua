return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    opts = function(_, opts)
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)

      opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
        preset = "default",

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },

        ["<Enter>"] = {
          "select_and_accept",
          "fallback",
        },
      })

      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 150,
        },
        ghost_text = {
          enabled = true,
        },
      })

      return opts
    end,
  },
}
