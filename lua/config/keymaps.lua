vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Python-specific mappings (buffer-local)
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
map("n", "<leader>s", ":split<CR>", { desc = "Split window" })
map("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })

-- Clipboard operations
map("n", "<leader>k", "dd", { desc = "Cut line" })
map("n", "<leader>c", "yy", { desc = "Copy line" })
map("n", "<leader>v", "p", { desc = "Paste below" })
map("n", "<leader>V", "P", { desc = "Paste above" })

map("v", "<leader>k", "d", { desc = "Cut selection" })
map("v", "<leader>c", "y", { desc = "Copy selection" })
map("v", "<leader>v", "p", { desc = "Paste selection" })

-- Copilot
map("i", "<leader>l", "<Cmd>call copilot#Next()<CR>", { desc = "Next Copilot suggestion" })
map("i", "<leader>h", "<Cmd>call copilot#Previous()<CR>", { desc = "Previous Copilot suggestion" })

-- DAP (Debug Adapter Protocol)
local dap = require("dap")
map("n", "<leader>dc", dap.continue, { desc = "Debug continue" })
map("n", "<leader>do", dap.step_over, { desc = "Debug step over" })
map("n", "<leader>di", dap.step_into, { desc = "Debug step into" })
map("n", "<leader>dO", dap.step_out, { desc = "Debug step out" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set conditional breakpoint" })
map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open REPL" })
map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run last" })

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
map("i", "<C-Space>", "cmp#complete()", { expr = true, noremap = true })

-- Python execution and testing (global)
map("n", "<leader>tp", ":w<CR>:!pytest -q %:p<CR>", opts)
map("n", "<leader>t", ":w<CR>:lua require('dap-python').test_method()<CR>", opts)
map("n", "<leader>T", ":w<CR>:lua require('dap-python').test_class()<CR>", opts)
