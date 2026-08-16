-- ~/.config/nvim/lua/core/options.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
o.termguicolors = true
o.completeopt = { "menu", "menuone", "noselect" }
