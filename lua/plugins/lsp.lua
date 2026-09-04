return {
  -- LSP Configuration
  {
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
          -- Linting only (no formatting to avoid conflict with conform)
          init_options = {
            settings = {
              lineLength = 88,
              lint = {
                select = { "E", "F", "W" },
              },
            },
          },
        },
      },
    },
  },

  -- Formatting with conform
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },
}
