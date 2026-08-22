-- Lua support for paste mappings
-- Converted from: paste.vim
-- Original Maintainer: Bram Moolenaar <Bram@vim.org>

local paste = {}

-- Helper function to check if feature exists
local function has_feature(feature)
  return vim.fn.has(feature) == 1
end

-- Get the clipboard content
local function get_clipboard()
  return vim.fn.getreg("+")
end

-- Main paste function (used when virtualedit is available)
local function paste_func()
  local ove = vim.o.virtualedit
  vim.o.virtualedit = "all"

  -- Move to the position before the last insertion
  vim.cmd("normal! `^")

  if get_clipboard() ~= "" then
    vim.cmd('normal! "+gP')
  end

  local c = vim.fn.col(".")
  vim.cmd("normal! i")

  -- Compensate for i<ESC> moving cursor left
  if vim.fn.col(".") < c then
    vim.cmd("normal! l")
  end

  vim.o.virtualedit = ove
end

-- Define paste commands based on virtualedit support
if has_feature("virtualedit") then
  paste.paste_cmd = {
    n = ":call paste#Paste()<CR>",
    v = '"-c<Esc>' .. ":call paste#Paste()<CR>",
    i = "x<BS><Esc>" .. ":call paste#Paste()<CR>" .. "gi",
  }

  -- Make the function accessible to Vim
  vim.cmd([[
    function! paste#Paste()
      " Delegate to Lua
      lua require('paste').paste_func()
    endfunction
  ]])
else
  -- Fallback for systems without virtualedit
  paste.paste_cmd = {
    n = "\"=@+.'xy'<CR>gPFx\"_2x",
    v = '"-c<Esc>gix<Esc>"=@+.\'xy\'<CR>gPFx"_2x"_x',
    i = 'x<Esc>"=@+.\'xy\'<CR>gPFx"_2x"_s',
  }
end

return paste
