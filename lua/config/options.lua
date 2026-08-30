local o = vim.opt

vim.g.lazydev_enabled = true

-- Basic options
o.autoindent = true
o.autoread = true
o.backup = false
o.breakindent = true
o.clipboard = "unnamedplus"
o.cmdheight = 2
o.completeopt:append("noselect")
o.confirm = true
o.cursorline = true
o.encoding = "UTF-8"
o.errorbells = false
o.expandtab = true
o.exrc = true
o.fileencoding = "UTF-8"
o.guicursor = {
  "n-v-c:block,i:ver25,ve:ver35,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait500-blinkoff400-blinkon250",
}
o.hidden = true
o.hlsearch = true
o.inccommand = "nosplit"
o.incsearch = true
o.joinspaces = false
o.jumpoptions = { "view" }
o.laststatus = 3
o.linebreak = true
o.listchars = { tab = "⭢ ", trail = "·", extends = "→", precedes = "←" }
o.magic = true
o.mouse = "a"
o.mousescroll = "ver:1,hor:6"
o.number = true
o.numberwidth = 2
o.path:append("**")
o.relativenumber = true
o.scrolloff = 4
o.secure = true
o.shiftwidth = 4
o.showbreak = "+++ "
o.showcmd = false
o.showcmdloc = "last"
o.showmatch = true
o.showmode = false
o.smartcase = true
o.smartindent = true
o.smarttab = true
o.smoothscroll = true
o.softtabstop = 4
o.spell = false
o.spelllang = "en_us"
o.splitbelow = true
o.syntax = "on"
o.tabstop = 4
o.termguicolors = true
o.timeoutlen = 300
o.undodir = vim.fn.stdpath("config") .. "/undo"
o.undofile = true
o.updatetime = 250
o.viminfo = "'1000,<50,s10,h"
o.wrap = false
o.signcolumn = "no"

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  --	signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Highlight groups
vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })

vim.cmd([[
  highlight SpellBad gui=undercurl guisp=#ff0000
  highlight SpellCap gui=undercurl guisp=#00ffff
  highlight SpellLocal gui=undercurl guisp=#00ff00
  highlight SpellRare gui=undercurl guisp=#ff00ff
]])

-- Autocmds
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "python", "json" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.fn.system("printf '\x1b[2 q'")
  end,
})
