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
        init_options = {
          settings = {
            args = {},
          },
        },
      },

      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              mccabe = { enabled = false },
              pylsp_mypy = { enabled = true, live_mode = true },
              pylsp_black = { enabled = false },
              pylsp_isort = { enabled = false },
            },
          },
        },
      },
    },
    setup = {
      ruff = function()
        local on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false

          vim.api.nvim_buf_create_user_command(bufnr, "RuffFormat", function()
            vim.lsp.buf.format({ async = true })
          end, { desc = "Format with Ruff" })
        end

        require("lspconfig").ruff.setup({
          on_attach = on_attach,
        })

        return true
      end,
    },
  },
}
