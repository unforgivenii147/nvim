local o = vim.opt
local g = vim.g
local bo = vim.bo

g.python3_host_prog = "/data/data/com.termux/files/home/.local/bin/python"

g.lazydev_enabled = true

g.matchparen_insert_timeout = 20
g.matchparen_timeout = 20

o.expandtab = true
o.exrc = true
o.hidden = true
o.history = 500
o.magic = true
o.tildeop = true
o.title = true

o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4
bo.softtabstop = 4
o.smarttab = true

o.number = true
o.numberwidth = 2
o.relativenumber = true
o.laststatus = 3
o.mouse = "a"
o.cmdheight = 2
o.colorcolumn = "120"
o.conceallevel = 3
o.smoothscroll = true
o.showbreak = "+++ "
o.splitbelow = true
o.splitright = true
o.background = "dark"

o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.scriptencoding = "utf-8"

if vim.fn.executable("rg") == 1 then
  o.grepprg = "rg --vimgrep --no-heading --smart-case"
  o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

o.viminfo = "'1000,<50,s10,h"

o.guicursor = {
  "i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

o.listchars = {
  tab = "⭢ ",
  trail = "·",
  extends = "→",
  precedes = "←",
}

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

vim.diagnostic.config({
  float = { border = "rounded" },
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local aug = vim.api.nvim_create_augroup("UserConfig", {})

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

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last edit position",
  pattern = "*",
  command = [[if line("'\"") > 0 && line("'\"") <= line("$") && expand('%:t') != 'COMMIT_EDITMSG' | exe "normal! g`\"" | endif]],
  group = aug,
})

vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Check for file changes when focus gained",
  pattern = "*",
  command = "if getcmdwintype() == '' | checktime | endif",
  group = aug,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Check if file changed on disk",
  pattern = "*",
  command = "if &buftype == '' && !&modified && expand('%') != '' | exec 'checktime ' . expand('<abuf>') | endif",
  group = aug,
})

vim.api.nvim_create_autocmd({ "CursorMovedI", "InsertLeave" }, {
  desc = "Close popup menu automatically",
  pattern = "*",
  command = "if pumvisible() == 0 && !&pvw && getcmdwintype() == '' | pclose | endif",
  group = aug,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.fn.system("printf '\\x1b[2 q'")
  end,
})

vim.cmd([[
  highlight SpellBad gui=undercurl guisp=#ff0000
  highlight SpellCap gui=undercurl guisp=#00ffff
  highlight SpellLocal gui=undercurl guisp=#00ff00
  highlight SpellRare gui=undercurl guisp=#ff00ff
]])

vim.api.nvim_create_user_command("W", function(params)
  local width = tonumber(params.fargs[1])
  if not width then
    return
  end
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
  if not height then
    return
  end
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
