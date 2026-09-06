_G.whitespace_disabled_file_types = {
  "lsp-installer",
  "lspinfo",
  "TelescopePrompt",
  "dashboard",
}
function _G.whitespace_visibility(file_types)
  local better_whitespace_status = 1
  local current_file_type = vim.api.nvim_eval("&ft")
  for k, v in ipairs(file_types) do
    if current_file_type == "" or current_file_type == v then
      better_whitespace_status = 0
    end
  end
  if better_whitespace_status == 0 then
    vim.cmd('execute "DisableWhitespace"')
  else
    vim.cmd('execute "EnableWhitespace"')
  end
end
vim.cmd("autocmd BufEnter * lua whitespace_visibility(whitespace_disabled_file_types)")
vim.cmd(
  'autocmd FileType dashboard execute "DisableWhitespace" | autocmd BufLeave <buffer> lua whitespace_visibility(whitespace_disabled_file_types)'
)
