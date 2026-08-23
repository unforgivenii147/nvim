vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.lazydev_enabled = true

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.cmdheight = 2
vim.opt.completeopt:append("noselect")
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.encoding = "UTF-8"
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.fileencoding = "UTF-8"
vim.opt.guicursor = {
	"n-v-c:block,i:ver25,ve:ver35,o:hor50",
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait500-blinkoff400-blinkon250",
}
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.jumpoptions = { "view" }
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.magic = true
vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:1,hor:6"
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.path:append("**")
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.secure = true
vim.opt.shiftwidth = 4
vim.opt.showbreak = "+++ "
vim.opt.showcmd = false
vim.opt.showcmdloc = "last"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.spelllang = "en_us"
vim.opt.splitbelow = true
vim.opt.syntax = "on"
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.viminfo = "'1000,<50,s10,h"
vim.opt.wrap = false

vim.opt.signcolumn = "auto" 
vim.opt.smartcase = true 
vim.opt.listchars = { tab = "⭢ ", trail = "·", extends = "→", precedes = "←" } 
vim.opt.spell = false 

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

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

