return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "ruff",
        "debugpy",
        "pytest",
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      keys = {
        {
          "<leader>dPt",
          function()
            require("dap-python").test_method()
          end,
          desc = "Debug Method",
        },
        {
          "<leader>dPc",
          function()
            require("dap-python").test_class()
          end,
          desc = "Debug Class",
        },
      },
      config = function()
        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
      end,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
        },
        ruff = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end,
          },
        },
        pylsp = {
          mason = false,
          settings = {
            pylsp = {
              plugins = {
                rope_autoimport = {
                  enabled = true,
                },
              },
            },
          },
        },
      },
      setup = {
        pyright = function()
          require("snacks.util").lsp.on(function(client, _)
            if client.name == "pyright" then
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
        pylsp = function()
          vim.lsp.on(function(client, _)
            if client.name == "pylsp" then
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
        ruff = function()
          require("snacks.util").lsp.on(function(client, _)
            if client.name == "ruff" then
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_organize_imports" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
        },
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
    cmd = "VenvSelect",
    opts = {
      dap_enabled = true,
    },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>dP", name = "+Python" },
        { "<leader>f", group = "format/fix" },
        { "<leader>fr", "<cmd>lua vim.lsp.buf.format({name = 'ruff'})<cr>", desc = "Ruff Format" },
        { "<leader>rr", "<cmd>w | !python3 %<cr>", desc = "Run Python File" },
      },
    },
  },
}
