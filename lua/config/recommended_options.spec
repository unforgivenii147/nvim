-- Core settings
local o = vim.opt
local g = vim.g
local bo = vim.bo

-- Leader keys
g.mapleader = " "
g.maplocalleader = " "

-- Let LazyVim handle providers
-- Remove: g.loaded_perl_provider = 0
-- Remove: g.loaded_ruby_provider = 0

-- Python host (keep if needed)
g.python3_host_prog = "/data/data/com.termux/files/home/.local/bin/python"

-- Lazydev
g.lazydev_enabled = true

-- Matchparen settings
g.matchparen_insert_timeout = 20
g.matchparen_timeout = 20

-- Basic editor settings
o.autoindent = true
o.expandtab = true
o.exrc = true
o.hidden = true
o.history = 500
o.lazyredraw = true
o.magic = true
o.tildeop = true
o.timeoutlen = 300 -- LazyVim default
o.title = true
o.updatetime = 100 -- LazyVim default
o.wrap = true -- Enable for plugins

-- Indentation
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4
bo.softtabstop = 4
-- Remove: o.smartindent = true
-- Remove: o.smarttab = true (let LSP handle)

-- Display / UI
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.laststatus = 3
o.mouse = "a"
-- Remove: o.termguicolors = true (LazyVim handles)
o.cmdheight = 2
o.colorcolumn = "120"
o.conceallevel = 3
o.smoothscroll = true
o.showbreak = "+++ "
-- Remove: o.showmatch = true (plugins handle)
o.splitbelow = true
o.splitright = true
o.syntax = "on"
o.background = "dark"

-- Completion / Popup menu
o.pumblend = 10
-- Remove: o.pumborder = "single" (blink.cmp handles)
-- Remove: o.pumheight = 60 (blink.cmp handles)

-- Search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- Spell
o.spell = true
o.spelllang = { "en", "fa" }

-- Files / Encoding
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.scriptencoding = "utf-8"

-- Folding - Let treesitter handle
-- Remove: o.foldenable = true
-- Remove: o.foldmethod = "expr"
-- Remove: o.foldexpr = "nvim_treesitter#foldexpr()"
-- Remove: o.foldlevel = 99
-- Remove: o.foldlevelstart = 99

-- Clipboard - Let LazyVim handle
-- Remove: o.clipboard = "unnamedplus"

-- Grep
if vim.fn.executable("rg") == 1 then
  o.grepprg = "rg --vimgrep --no-heading --smart-case"
  o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- Viminfo
o.viminfo = "'1000,<50,s10,h"

-- Guicursor
o.guicursor = {
  "i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- Listchars
o.listchars = {
  tab = "⭢ ",
  trail = "·",
  extends = "→",
  precedes = "←",
}

-- Fillchars
o.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
  vert = "│",
  diff = "╱",
  msgsep = "‾",
}

-- Remove Rainbow highlights (treesitter handles this)

-- Diagnostic config (LazyVim has its own)
-- Keep minimal config or let LazyVim handle
vim.diagnostic.config({
  float = { border = "rounded" },
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Autocmds
local aug = vim.api.nvim_create_augroup("UserConfig", {})

-- Cursorline in active window
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  desc = "Highlight cursorline in active window",
  pattern = "*",
  command = "setlocal cursorline",
  group = aug,
})

vim.api.nvim_create_autocmd("WinLeave", {
  desc = "Clear cursorline when leaving window",
  pattern = "*",
  command = "if &bt != 'quickfix' | setlocal nocursorline | endif",
  group = aug,
})

-- Return to last edit position (nvim-lastplace already handles this)
-- Remove this autocmd

-- Spellcheck - Let LazyVim handle
-- Remove this autocmd

-- Focus gained - LazyVim has this
-- Remove this autocmd

-- File changed on disk - LazyVim has this
-- Remove this autocmd

-- Close popup menu - blink.cmp handles this
-- Remove this autocmd

-- VimLeave cursor reset
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.fn.system("printf '\\x1b[2 q'")
  end,
})

-- Highlight spell settings
vim.cmd([[
  highlight SpellBad gui=undercurl guisp=#ff0000
  highlight SpellCap gui=undercurl guisp=#00ffff
  highlight SpellLocal gui=undercurl guisp=#00ff00
  highlight SpellRare gui=undercurl guisp=#ff00ff
]])

-- User commands
vim.api.nvim_create_user_command("W", function(params)
  local width = tonumber(params.fargs[1])
  if not width then return end
  if width < 0 or params.fargs[1]:sub(1, 1) == "+" then
    width = vim.api.nvim_win_get_width(0) + width
  end
  if math.floor(width) ~= width then
    width = math.floor(width * vim.o.columns)
  end
  vim.api.nvim_win_set_width(0, width)
end, { nargs = 1 })

vim.api.nvim_create_user_command("H", function(params)
  local height = tonumber(params.fargs[1])
  if not height then return end
  if height < 0 or params.fargs[1]:sub(1, 1) == "+" then
    height = vim.api.nvim_win_get_height(0) + height
  end
  if math.floor(height) ~= height then
    height = math.floor(height * vim.o.lines - vim.o.cmdheight)
  end
  vim.api.nvim_win_set_height(0, height)
end, { nargs = 1 })

vim.api.nvim_create_user_command("ToggleWrap", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  print("Wrap: " .. tostring(vim.opt.wrap:get()))
end, {})

-- Filetype additions
vim.filetype.add({
  extension = {
    cconf = "python",
    frag = "glsl",
    norg = "norg",
    rbi = "ruby",
    sky = "starlark",
    ptl = "petal",
    pt = "petal",
    pti = "petal",
  },
  pattern = {
    [".*/%.vscode/.*%.json"] = "json5",
  },
})

-- Foldtext function (useful if you want custom folding)
function stevearc.foldtext()
  local line = vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, true)[1]
  local idx = vim.v.foldstart + 1
  while string.find(line, "^%s*@") or string.find(line, "^%s*$") do
    line = vim.api.nvim_buf_get_lines(0, idx - 1, idx, true)[1]
    idx = idx + 1
  end
  local icon = g.nerd_font and " " or "▼"
  local padding = string.rep(" ", string.find(line, "[^%s]") - 1)
  return string.format("%s%s %s   %d", padding, icon, line, vim.v.foldend - vim.v.foldstart + 1)
end