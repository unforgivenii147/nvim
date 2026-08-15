-- ~/.config/nvim/lua/core/keymaps.lua
local map = vim.keymap.set

-- Leader mappings (requested)
map("n", "<leader>w", ":update<CR>", { desc = "Save file" })
map("n", "<leader>q", ":confirm quit<CR>", { desc = "Quit" })

-- Format with LSP / null-ls (ruff)
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format file (ruff)" })

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
      if data and #data > 0 then vim.notify(table.concat(data, "\n"), vim.log.levels.WARN) end
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
        vim.schedule(function() vim.notify("ruff --fix exited with code " .. tostring(code), vim.log.levels.ERROR) end)
      end
    end,
  })
  if job <= 0 then vim.notify("Failed to start ruff; ensure ruff is installed and in PATH", vim.log.levels.ERROR) end
end

map("n", "<leader>ff", ruff_fix_current_file, { desc = "Ruff --fix current file" })
-- alias
map("n", "<leader>F", ruff_fix_current_file, { desc = "Ruff fix (alias)" })

-- Optional: some basic nav mappings inspired by community configs
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
