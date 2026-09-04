return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              autoImportCompletions = true,
              completeFunctionParens = true,
            },
          },
        },
      },

      ruff = {
        -- Ruff LSP for linting only (formatting handled by conform)
        init_options = {
          settings = {
            lineLength = 88,
            lint = {
              select = { "E", "F", "W" }, -- pyflakes, pycodestyle
            },
          },
        },
      },
    },

    setup = {
      ruff = function(server, opts)
        -- Disable hover provider since pyright handles it
        opts.on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
          
          -- You can add custom commands here if needed
          -- But formatting is handled by conform.nvim
        end
        
        -- Return true to skip LazyVim's default setup for this server
        return true
      end,
    },
  },
}