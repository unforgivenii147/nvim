vim.api.nvim_create_user_command("Rename", function()
  vim.lsp.buf.rename()
end, { desc = "Rename symbol under cursor" })

vim.api.nvim_create_user_command("GoToDef", function()
  vim.lsp.buf.definition()
end, { desc = "Go to definition" })
