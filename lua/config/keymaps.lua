-- ~/.config/nvim/lua/core/keymaps.lua
local map = vim.keymap.set

-- Leader mappings (requested)
map("n", "<leader>w", ":update<CR>", { desc = "Save file" })
map("n", "<leader>q", ":confirm quit<CR>", { desc = "Quit" })

-- Format with LSP / null-ls (ruff)
map("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file (ruff)" })

-- Run ruff --fix on current file (async)
local function ruff_fix_current_file()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("No file to fix", vim.log.levels.WARN)
    return
  end
  vim.notify("Running ruff --fix on: " .. file, vim.log.levels.INFO)
  local job = vim.fn.jobstart({ "ruff", "check", "--fix", file }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stderr = function(_, data)
      if data and #data > 0 then
        vim.notify(table.concat(data, "\n"), vim.log.levels.WARN)
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        vim.schedule(function()
          -- Reload buffer to reflect fixes
          vim.cmd("edit!")
          vim.notify("ruff --fix applied", vim.log.levels.INFO)
          -- Re-run formatting/diagnostics if desired
          pcall(vim.lsp.buf.format, { async = true })
        end)
      else
        vim.schedule(function()
          vim.notify("ruff --fix exited with code " .. tostring(code), vim.log.levels.ERROR)
        end)
      end
    end,
  })
  if job <= 0 then
    vim.notify("Failed to start ruff; ensure ruff is installed and in PATH", vim.log.levels.ERROR)
  end
end

map("n", "<leader>ff", ruff_fix_current_file, { desc = "Ruff --fix current file" })
-- alias
map("n", "<leader>F", ruff_fix_current_file, { desc = "Ruff fix (alias)" })

-- Optional: some basic nav mappings inspired by community configs
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local utils = require("config.utils")

-- Yank All Text
vim.keymap.set("n", "<leader>y", "<cmd>%y+<cr>", { desc = "Yank All Text", silent = true })

-- Delete All Text
vim.keymap.set("n", "<leader>bR", "<cmd>%d+<cr>", { desc = "Remove All Text", silent = true })

-- Save With Root
vim.keymap.set("n", "<leader>bs", "<cmd>SudaWrite<cr>", { desc = "Save With Root", silent = true })

-- Go to previous tab
vim.keymap.set("n", "<Left>", "<cmd>tabprevious<CR>", { desc = "General | Go to previous tab", silent = true })

-- Go to next tab
vim.keymap.set("n", "<Right>", "<cmd>tabnext<CR>", { desc = "General | Go to next tab", silent = true })

-- New tab
vim.keymap.set("n", "<Up>", "<cmd>tabnew<CR>", { desc = "General | New tab", silent = true })

-- Close tab
vim.keymap.set("n", "<Down>", "<cmd>tabclose<CR>", { desc = "General | Close tab", silent = true })

-- Run Code
vim.keymap.set("n", "<leader>ce", function()
  utils.run_code()
end, { desc = "Execute Code", silent = true })

-- Project Bootstrap
vim.keymap.set("n", "<leader>P", function()
  utils.bootstrap_project()
end, { desc = "Project Bootstrap", silent = true })

-- lazy
vim.keymap.set("n", "<leader>lh", "<cmd>Lazy<cr>", { desc = "Lazy Home" })
vim.keymap.set("n", "<leader>le", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })
vim.keymap.set("n", "<leader>ls", "<cmd>Lazy sync<cr>", { desc = "Lazy Sync" })
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<cr>", { desc = "Lazy Update" })
vim.keymap.set("n", "<leader>lL", "<cmd>Lazy log<cr>", { desc = "Lazy Log" })
vim.keymap.set("n", "<leader>lc", "<cmd>Lazy clean<cr>", { desc = "Lazy Clean" })
vim.keymap.set("n", "<leader>lp", "<cmd>Lazy profile<cr>", { desc = "Lazy Profile" })
vim.keymap.set("n", "<leader>li", "<cmd>Lazy install<cr>", { desc = "Lazy Install" })
vim.keymap.set("n", "<leader>ll", function()
  local keys = vim.api.nvim_replace_termcodes(":Lazy load ", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Load Plugin" })
vim.keymap.set("n", "<leader>lH", "<cmd>Lazy help<cr>", { desc = "Lazy Help" })
vim.keymap.set("n", "<leader>ld", "<cmd>Lazy debug<cr>", { desc = "Lazy Debug" })

-- From: https://medium.com/@musickcorym/fixing-the-lag-why-i-ditched-vim-tmux-navigator-for-a-faster-plugin-free-setup-239da138e4aa
local function smart_move(direction, tmux_cmd)
  local curwin = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. direction)
  if curwin == vim.api.nvim_get_current_win() then
    vim.fn.system("tmux select-pane " .. tmux_cmd)
  end
end

vim.keymap.set("n", "<C-h>", function()
  smart_move("h", "-L")
end, { silent = true })
vim.keymap.set("n", "<C-j>", function()
  smart_move("j", "-D")
end, { silent = true })
vim.keymap.set("n", "<C-k>", function()
  smart_move("k", "-U")
end, { silent = true })
vim.keymap.set("n", "<C-l>", function()
  smart_move("l", "-R")
end, { silent = true })

vim.keymap.set("n", "<leader>uC", function()
  if vim.g.colorscheme == "nvchad" then
    require("config.utils").theme_picker.open()
  else
    Snacks.picker.colorschemes()
  end
end, { desc = "Colorschemes" })
