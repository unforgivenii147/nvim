local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>fs", ":Format<CR>", opts)

map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)

map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

map("i", "<C-Space>", "cmp#complete()", { expr = true, noremap = true })

map("n", "<leader>r", ":w<CR>:!python %<CR>", opts)
map("n", "<leader>t", ":w<CR>:lua require('dap-python').test_method()<CR>", opts)
map("n", "<leader>T", ":w<CR>:lua require('dap-python').test_class()<CR>", opts)
map("n", "<leader>tp", ":w<CR>:!pytest -q %:p<CR>", opts)
