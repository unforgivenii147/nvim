vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })

map("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })

map("n", "<leader>s", ":split<CR>", { noremap = true, silent = true })

map("n", "<leader>wq", ":wq<CR>", { desc = "/Save and quit" })
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

map("n", "<leader>k", "dd", { desc = "Cut line" })
map("n", "<leader>c", "yy", { desc = "Copy line" })
map("n", "<leader>v", "p", { desc = "Paste below" })
map("n", "<leader>V", "P", { desc = "Paste above" })

map("v", "<leader>k", "d", { desc = "Cut selection" })
map("v", "<leader>c", "y", { desc = "Copy selection" })
map("v", "<leader>v", "p", { desc = "Paste selection" })

map("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
  desc = "Accept Copilot suggestion",
})
map("i", "<leader>l", "<Cmd>call copilot#Next()<CR>", { desc = "Next Copilot suggestion" })
map("i", "<leader>h", "<Cmd>call copilot#Previous()<CR>", { desc = "Previous Copilot suggestion" })

local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint)

map("i", "<C-l>", function()
  vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot Accept", noremap = true, silent = true })

vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end)
vim.keymap.set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<leader>dr", function()
  require("dap").repl.open()
end)
vim.keymap.set("n", "<leader>dl", function()
  require("dap").run_last()
end)
