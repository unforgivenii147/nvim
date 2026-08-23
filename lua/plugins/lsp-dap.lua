-- lsp-dap.lua
-- Merged configuration for LSP and DAP (Python)
return {
  -- ============================================================================
  -- Mason: Package manager for LSP servers, DAP servers, linters, formatters
  -- ============================================================================
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
      PATH = "prepend",
      log_level = vim.log.levels.DEBUG,
      max_concurrent_installers = 4,
      registries = { "github:mason-org/mason-registry" },
      system_registries = { "github:mason-org/mason-system-registry" },
      registry_cache = { refresh = true, duration = 30 * 24 * 60 * 60 },
      firewall = { enabled = false, auto_managed = true },
      providers = { "mason.providers.registry-api", "mason.providers.client" },
      github = { download_url_template = "https://github.com/%s/releases/download/%s/%s" },
      pip = { upgrade_pip = false, install_args = {} },
      npm = { install_args = {} },
      ui = {
        check_outdated_packages_on_open = true,
        border = nil,
        backdrop = 60,
        width = 0.8,
        height = 0.9,
        icons = { package_installed = "◍", package_pending = "◍", package_uninstalled = "◍" },
        keymaps = {
          toggle_package_expand = "<CR>",
          install_package = "i",
          update_package = "u",
          check_package_version = "c",
          update_all_packages = "U",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
          toggle_package_install_log = "<CR>",
          toggle_help = "g?",
        },
      },
    },
  },
  -- ============================================================================
  -- mason-lspconfig: Bridge between Mason and nvim-lspconfig
  -- ============================================================================
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "pyright", "ruff_lsp", "ruff" },
      automatic_installation = true,
    },
  },
  -- ============================================================================
  -- nvim-lspconfig: LSP client configuration
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- for capabilities
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Common on_attach function for LSP keymaps
      local function on_attach(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        -- Ruff specific: disable hover (ruff provides diagnostics but not hover)
        if client.name == "ruff" or client.name == "ruff_lsp" then
          client.server_capabilities.hoverProvider = false
        end
      end
      -- Pyright setup
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              diagnosticSeverityOverrides = { reportUnusedVariable = "warning" },
            },
          },
        },
      })
      -- Ruff LSP (legacy, kept for compatibility)
      pcall(function()
        lspconfig.ruff_lsp.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          init_options = { settings = {} },
        })
      end)
      -- Ruff (newer, recommended)
      pcall(function()
        lspconfig.ruff.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          init_options = { settings = {} },
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  context = {
                    only = { "source.organizeImports" },
                  },
                  apply = true,
                })
              end,
              desc = "Organize Imports",
            },
          },
        })
      end)
    end,
  },
  -- ============================================================================
  -- nvim-dap: Debug Adapter Protocol client
  -- ============================================================================
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
      local dap = require("dap")
      -- Python adapter configuration
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      -- Python launch configurations
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return "python"
          end,
        },
      }
    end,
  },
  -- ============================================================================
  -- nvim-dap-python: Python-specific DAP enhancements
  -- ============================================================================
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- Try to use debugpy from mason if available, fallback to system python
      local debugpy_path = require("mason").get_package_path("debugpy")
      local python_path = debugpy_path and debugpy_path .. "/venv/bin/python" or "python"
      require("dap-python").setup(python_path)
      -- DAP keymaps
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map("n", "<F5>", require("dap").continue, opts)
      map("n", "<F9>", require("dap").toggle_breakpoint, opts)
      map("n", "<F10>", require("dap").step_over, opts)
      map("n", "<F11>", require("dap").step_into, opts)
      -- Additional debug keymaps for Python testing
      map("n", "<leader>dPt", function()
        require("dap-python").test_method()
      end, { desc = "Debug Method", ft = "python" })
      map("n", "<leader>dPc", function()
        require("dap-python").test_class()
      end, { desc = "Debug Class", ft = "python" })
    end,
  },
  -- ============================================================================
  -- Treesitter: Python syntax highlighting
  -- ============================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "lua", "python" } },
  },
  -- ============================================================================
  -- neotest: Testing framework integration (optional)
  -- ============================================================================
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {},
      },
    },
  },
  -- ============================================================================
  -- venv-selector: Python virtual environment management
  -- ============================================================================
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    cmd = "VenvSelect",
    ft = "python",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
  -- ============================================================================
  -- nvim-cmp: Auto-completion bracket handling for Python
  -- ============================================================================
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
  },
  -- ============================================================================
  -- conform.nvim: Python formatting with ruff (optional)
  -- ============================================================================
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["python"] = { "ruff_format", "ruff_organize_imports" },
      },
    },
  },
}
