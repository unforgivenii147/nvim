return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      -- Empty list = nothing gets auto-installed
      opts.ensure_installed = {}
      -- Disable auto-update
      opts.auto_update = false
      return opts
    end,
  },
  -- Optional: Also configure mason if needed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.PATH = "prepend"
      opts.providers = {
        mason = { priority = 1 },
        native = { priority = 50 },
      }
      return opts
    end,
  },
}
