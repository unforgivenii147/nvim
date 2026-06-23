return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        -- Override default handler to skip ruff
        function(server_name)
          if server_name == "ruff" then
            return -- Don't set up ruff
          end
          require("mason-lspconfig").default_setup(server_name)
        end,
      },
    },
  },
}
