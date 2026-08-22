vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.lazydev_enabled = true
vim.opt.syntax = "on"

vim.opt.spell = true
vim.opt.spelllang = "en"

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait0-blinkoff0-blinkon0-Cursor/lCursor,sm:block-blinkwait0-blinkoff0-blinkon0"
vim.opt.guifont = { "CaskaydiaCove Nerd Font", "Source Han Sans SC", ":h12" }
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.path:append("**")
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.showbreak = "+++ "
vim.opt.signcolumn = "no"
vim.opt.smartcase = false
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.wrap = false

vim.opt.viminfo = "'1000,<50,s10,h"

vim.opt.guicursor = {
  "n-v-c:block,i:ver25,ve:ver35,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait500-blinkoff400-blinkon250",
}

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "<filetype>" },
  callback = function()
    vim.treesitter.start()
  end,
})

-- Enable spell checking for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "python", "json" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Customize highlight colors
vim.cmd([[
  highlight SpellBad gui=undercurl guisp=#ff0000
  highlight SpellCap gui=undercurl guisp=#00ffff
  highlight SpellLocal gui=undercurl guisp=#00ff00
  highlight SpellRare gui=undercurl guisp=#ff00ff
]])
