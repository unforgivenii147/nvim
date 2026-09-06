vim.bo.softtabstop = 4
vim.g.lazydev_enabled = true
vim.g.matchparen_insert_timeout = 20
vim.g.matchparen_timeout = 20
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_ruby_provider"] = 0
vim.opt.autoindent = true
vim.opt.autowriteall = true
vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.colorcolumn = "120"
vim.opt.conceallevel = 3
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.fileencoding = "utf-8"
vim.opt.foldenable = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.hidden = true
vim.opt.history = 500
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.magic = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.pumblend = 10
vim.opt.pumborder = "single"
vim.opt.pumheight = 60
vim.opt.relativenumber = true
vim.opt.scriptencoding = "utf-8"
vim.opt.shiftwidth = 4
vim.opt.showbreak = "+++ "
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.spell = true
vim.opt.spelllang = { "en", "fa"}
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.syntax = "on"
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.tildeop = true
vim.opt.timeoutlen = 500
vim.opt.title = true
vim.opt.updatetime = 2000
vim.opt.viminfo = "'1000,<50,s10,h"
vim.opt.wrap = false

if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

vim.opt.guicursor = {
  "i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })


vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.fn.system("printf '\\x1b[2 q'")
  end,
})

vim.opt.listchars = {
    tab = "⭢ ",
    trail = "·",
    extends = "→",
    precedes = "←",
  },
vim.diagnostic.config({
  float = { border = "rounded" },
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
vim.g.python3_host_prog = "/data/data/com.termux/files/home/.local/bin/python"
