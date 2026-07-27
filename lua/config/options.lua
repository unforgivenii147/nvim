vim.g.mapleader = " "
vim.g.maplocalleader = " "

--vim.cmd.colorscheme("tokyonight")

-- vim.opt.syntax = "on"
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

-- Enable file position restoration
vim.opt.viminfo = "'1000,<50,s10,h"

vim.opt.guicursor = {
  "n-v-c:block,i:ver25,ve:ver35,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait500-blinkoff400-blinkon250",
}

--vim.api.nvim_create_autocmd("VimLeavePre", {
--  callback = function()
-- \x1b[5 q = underline (normal in Termux)
-- \x1b[3 q = vertical bar
-- \x1b[0 q = default (usually block)
--    vim.fn.system("printf '\x1b[5 q'")
--  end,
--(})

vim.diagnostic.config({
  virtual_text = true, -- Show inline error messages
  signs = true, -- Show gutter markers
  underline = true, -- Underline problematic code
  update_in_insert = false, -- Update diagnostics while typing
  severity_sort = true, -- Sort by severity
})
