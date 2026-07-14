vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.cmd.colorscheme("")
-- vim.opt.guicursor = ""
-- vim.opt.scrolloff = 4
-- vim.opt.shortmess:append("Ic")
-- vim.opt.sidescrolloff = 5
-- vim.opt.wildmenu = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.cmdheight = 2
vim.opt.colorcolumn = { 80, 100, 120 }
vim.opt.completeopt:append("noselect")
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = { "line" }
vim.opt.encoding = "UTF-8"
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.foldenable = false
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.jumpoptions = { "view" }
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { space = " ", tab = "⭢ " }
vim.opt.magic = true
vim.opt.mouse = "a"
--vim.opt.mouse = "nvi"
vim.opt.mousescroll = "ver:1,hor:6"
vim.opt.number = true
vim.opt.numberwidth = 2

vim.opt.path:append("**")
vim.opt.relativenumber = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 4
vim.opt.secure = true
vim.opt.shiftwidth = 4
vim.opt.showbreak = "+++ "
vim.opt.showcmd = false
vim.opt.showcmdloc = "last"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = "no"
vim.opt.smartcase = false
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
--vim.opt.verbose = 16
--vim.opt.verbosefile = "/data/data/com.termux/files/home/nvim.log"
vim.opt.wrap = false

-- Enable file position restoration
vim.opt.viminfo = "'1000,<50,s10,h"

vim.opt.guicursor = {
	"n-v-c:block,i:ver25,ve:ver35,o:hor50",
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait500-blinkoff400-blinkon250",
}

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		-- \x1b[5 q = underline (normal in Termux)
		-- \x1b[3 q = vertical bar
		-- \x1b[0 q = default (usually block)
		vim.fn.system("printf '\x1b[5 q'")
	end,
})
