-- File: lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
    { "neovim/nvim-lspconfig", opts = { servers = { pyright = {} } } },
    {
      "folke/lazy.nvim",
      opts = {
        install = {
          clone = "git clone --depth 1 --filter=blob:none {{url}} {{path}} 2>/dev/null || git clone --depth 1 {{url}} {{path}} 2>/dev/null || git clone {{url}} {{path}}",
          checkout = "git checkout {{commit}} 2>/dev/null || git checkout {{branch}} 2>/dev/null",
        },
        git = {
          clone = "git clone --depth 1 --filter=blob:none {{url}} {{path}}",
          timeout = 60,
        },
        performance = {
          cache = {
            enabled = true,
          },
          rtp = {
            disabled_plugins = {
              "gzip",
              "matchit",
              "matchparen",
              "netrwPlugin",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      },
    },
  },

  defaults = { lazy = true, version = false },
  install = {
    colorscheme = { "catppuccin" },
    clone = "git clone --depth 1 --filter=blob:none {{url}} {{path}} 2>/dev/null || git clone --depth 1 {{url}} {{path}} 2>/dev/null || git clone {{url}} {{path}}",
    checkout = "git checkout {{commit}} 2>/dev/null || git checkout {{branch}} 2>/dev/null",
  },
  checker = {
    enabled = false,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  git = {
    depth = 1,
    filter = "blob:none",
    clone = "git clone --depth 1 --filter=blob:none {{url}} {{path}}",
    timeout = 60,
  },
})
