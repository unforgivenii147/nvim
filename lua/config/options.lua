vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

vim.opt.smartcase = false
vim.opt.showmode = false
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.signcolumn = "number"
vim.opt.smoothscroll = true
vim.opt.verbose = 16
vim.opt.verbosefile = "/data/data/com.termux/files/home/nvim.log"

-- Disable autoformat for lua files
--vim.api.nvim_create_autocmd({ "FileType" }, {
--  pattern = { "lua" },
--  callback = function()
--    vim.b.autoformat = false
--  end,
--})

