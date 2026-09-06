local paste = {}

local function has_feature(feature)
  return vim.fn.has(feature) == 1
end

local function get_clipboard()
  return vim.fn.getreg("+")
end

local function paste_func()
  local ove = vim.o.virtualedit
  vim.o.virtualedit = "all"

  vim.cmd("normal! `^")

  if get_clipboard() ~= "" then
    vim.cmd('normal! "+gP')
  end

  local c = vim.fn.col(".")
  vim.cmd("normal! i")

  if vim.fn.col(".") < c then
    vim.cmd("normal! l")
  end

  vim.o.virtualedit = ove
end

if has_feature("virtualedit") then
  paste.paste_cmd = {
    n = ":call paste#Paste()<CR>",
    v = '"-c<Esc>' .. ":call paste#Paste()<CR>",
    i = "x<BS><Esc>" .. ":call paste#Paste()<CR>" .. "gi",
  }

  vim.cmd([[
    function! paste#Paste()
      " Delegate to Lua
      lua require('paste').paste_func()
    endfunction
  ]])
else
  paste.paste_cmd = {
    n = "\"=@+.'xy'<CR>gPFx\"_2x",
    v = '"-c<Esc>gix<Esc>"=@+.\'xy\'<CR>gPFx"_2x"_x',
    i = 'x<Esc>"=@+.\'xy\'<CR>gPFx"_2x"_s',
  }
end

return paste
