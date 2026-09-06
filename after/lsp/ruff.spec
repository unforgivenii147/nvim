-- Ruff LSP configuration for Neovim
vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  init_options = {
    settings = {
      -- Logging
      logLevel = "debug",
      logFile = "~/path/to/ruff.log",

      -- Configuration source
      configuration = "~/.config/ruff/ruff.toml",
      configurationPreference = "filesystemFirst",

      -- File handling
      exclude = { "**/tests/**" },
      lineLength = 100,

      -- Features
      fixAll = false,
      organizeImports = false,
      showSyntaxErrors = false,

      -- Code actions
      codeAction = {
        disableRuleComment = { enable = false },
        fixViolation = { enable = false },
      },

      -- Linting
      lint = {
        enable = false,
        preview = true,
        select = { "E", "F" },
        extendSelect = { "W" },
        ignore = { "E4", "E7" },
      },

      -- Formatting
      format = {
        backend = "internal",
      },
    },
  },
})

-- Disable hover from Ruff in favor of Pyright
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

-- Pyright configuration
vim.lsp.config("pyright", {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
      },
    },
  },
})

-- Set LSP log level to debug
vim.lsp.log.set_level("debug")
