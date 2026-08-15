-- ~/.config/nvim/lua/core/options.lua
local o = vim.opt

-- Basic sensible options (inspired by Astro/NvChad/LazyVim)
o.encoding = "utf-8"
o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.mouse = "a"
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true
o.termguicolors = true
o.updatetime = 250
o.signcolumn = "yes"
o.splitright = true
o.splitbelow = true
o.wrap = false
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.completeopt = { "menu", "menuone", "noselect" }

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Minimal provider tweaks (like AstroNvim)
vim.g.python3_host_prog = vim.fn.getenv("PYENV_ROOT") and (vim.fn.getenv("PYENV_ROOT") .. "/shims/python") or nil
