local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Python-specific LSP keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local buf_opts = {
      buffer = true,
      noremap = true,
      silent = true,
    }

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

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resizing
map("n", "<C-Up>", "<cmd>resize +2<cr>", {
  desc = "Increase window height",
})

map("n", "<C-Down>", "<cmd>resize -2<cr>", {
  desc = "Decrease window height",
})

map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", {
  desc = "Decrease window width",
})

map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", {
  desc = "Increase window width",
})

-- Move lines and selections
map("n", "<A-j>", "<cmd>m .+1<cr>==", {
  desc = "Move line down",
})

map("n", "<A-k>", "<cmd>m .-2<cr>==", {
  desc = "Move line up",
})

map("v", "<A-j>", ":m '>+1<cr>gv=gv", {
  desc = "Move selection down",
})

map("v", "<A-k>", ":m '<-2<cr>gv=gv", {
  desc = "Move selection up",
})

-- Search
map("n", "<leader>h", "<cmd>nohlsearch<cr>", {
  desc = "Clear search highlight",
})

-- File and buffer operations
map("n", "<leader>w", "<cmd>w<cr>", {
  desc = "Save file",
})

map("n", "<leader>q", "<cmd>q<cr>", {
  desc = "Quit",
})

map("n", "<leader>Q", "<cmd>qa<cr>", {
  desc = "Quit all",
})

map("n", "<S-h>", "<cmd>bprevious<cr>", {
  desc = "Previous buffer",
})

map("n", "<S-l>", "<cmd>bnext<cr>", {
  desc = "Next buffer",
})

map("n", "<leader>bd", "<cmd>bdelete<cr>", {
  desc = "Delete buffer",
})

-- Terminal
map("n", "<leader>t", "<cmd>terminal<cr>", {
  desc = "Open terminal",
})

map("t", "<Esc><Esc>", "<C-\\><C-n>", {
  desc = "Exit terminal mode",
})

-- LSP
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- Python execution and testing
map("n", "<leader>tp", "<cmd>w<cr>:!pytest -q %:p<cr>", opts)

map("n", "<leader>Tp", function()
  vim.cmd("write")
  require("dap-python").test_method()
end, opts)

map("n", "<leader>Tt", function()
  vim.cmd("write")
  require("dap-python").test_class()
end, opts)

-- Formatting with conform.nvim
map("n", "<leader>cf", function()
  require("conform").format({
    async = true,
    lsp_format = "fallback",
  })
end, { desc = "Format buffer (ruff)" })

map("n", "<leader>cR", function()
  require("conform").format({
    formatters = {
      "ruff_fix",
      "ruff_organize_imports",
      "ruff_format",
    },
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

      vim.keymap.set("n", "q", close, {
        buffer = out_buf,
        silent = true,
      })

      vim.keymap.set("n", "<Esc>", close, {
        buffer = out_buf,
        silent = true,
      })
    end)
  end)
end

vim.api.nvim_create_user_command("TyCheck", ty_check, {
  desc = "Run ty type checker on current file",
})

map("n", "<leader>ct", ty_check, {
  desc = "Run ty check (type checker output)",
})
