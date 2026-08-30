local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Python-specific LSP keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local buf_opts = { buffer = true, noremap = true, silent = true }

    map("n", "<leader>r", function()
      vim.lsp.buf.format({ name = "ruff" })
    end, buf_opts)

    map("n", "<leader>ri", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" } },
        apply = true,
      })
    end, buf_opts)

    map("n", "<leader>rc", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.fixAll" } },
        apply = true,
      })
    end, buf_opts)
  end,
})

-- Window resizing
local resize = require("window_resize")
map("n", "<leader>w+", function()
  resize.resize_up(3)
end, { desc = "Resize window up" })
map("n", "<leader>w-", function()
  resize.resize_down(3)
end, { desc = "Resize window down" })
map("n", "<leader>w<", function()
  resize.resize_left(3)
end, { desc = "Resize window left" })
map("n", "<leader>w>", function()
  resize.resize_right(3)
end, { desc = "Resize window right" })

-- File operations
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })

-- Terminal and debugging
map("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
-- map("i", "<leader>l", "<Cmd>call copilot#Next()<CR>", { desc = "Next Copilot suggestion" })
-- map("i", "<leader>h", "<Cmd>call copilot#Previous()<CR>", { desc = "Previous Copilot suggestion" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- Completion
-- map("i", "<C-Space>", "cmp#complete()", { expr = true, noremap = true })

-- Python execution and testing
map("n", "<leader>tp", ":w<CR>:!pytest -q %:p<CR>", opts)
map("n", "<leader>Tp", ":w<CR>:lua require('dap-python').test_method()<CR>", opts)
map("n", "<leader>Tt", ":w<CR>:lua require('dap-python').test_class()<CR>", opts)

-- Formatting with conform.nvim
map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer (ruff)" })

map("n", "<leader>cR", function()
  require("conform").format({
    formatters = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
    async = true,
  })
end, { desc = "Ruff: fix + organize imports + format" })

-- Ty type checking
local function ty_check()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)
  if file == "" then
    vim.notify("ty check: buffer has no file on disk", vim.log.levels.WARN)
    return
  end

  vim.system({ "ty", "check", file }, { text = true }, function(result)
    vim.schedule(function()
      local output = (result.stdout or "") .. (result.stderr or "")
      if output == "" then
        output = "ty check: no output (exit code " .. tostring(result.code) .. ")"
      end
      local lines = vim.split(output, "\n")

      local out_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, lines)
      vim.bo[out_buf].filetype = "ty-output"
      vim.bo[out_buf].modifiable = false

      local width = math.floor(vim.o.columns * 0.8)
      local height = math.floor(vim.o.lines * 0.6)
      local win = vim.api.nvim_open_win(out_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
        title = " ty check ",
        title_pos = "center",
      })
      vim.wo[win].wrap = false

      local close = function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end
      vim.keymap.set("n", "q", close, { buffer = out_buf, silent = true })
      vim.keymap.set("n", "<esc>", close, { buffer = out_buf, silent = true })
    end)
  end)
end

vim.api.nvim_create_user_command("TyCheck", ty_check, { desc = "Run ty type checker on current file" })
map("n", "<leader>ct", ty_check, { desc = "Run ty check (type checker output)" })
