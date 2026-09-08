vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  init_options = {
    settings = {
      logLevel = "debug",
      logFile = "~/tmp/apps/ruff.log",

      configuration = "~/.config/ruff/ruff.toml",
      configurationPreference = "filesystemFirst",

      exclude = { "**/tests/**" },
      lineLength = 100,

      fixAll = false,
      organizeImports = false,
      showSyntaxErrors = false,

      codeAction = {
        disableRuleComment = { enable = false },
        fixViolation = { enable = false },
      },

      lint = {
        enable = false,
        preview = true,
        select = { "E", "F" },
        extendSelect = { "W" },
        ignore = { "E4", "E7" },
      },

      format = {
        backend = "internal",
      },
    },
  },
})

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

vim.lsp.config("pyright", {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
})

vim.lsp.log.set_level("debug")
