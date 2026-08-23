vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.keymap.set

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		local opts = { buffer = true, noremap = true, silent = true }

		map("n", "<leader>r", function()
			vim.lsp.buf.format({ name = "ruff" })
		end, opts)

		map("n", "<leader>ri", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" } },
				apply = true,
			})
		end, opts)

		map("n", "<leader>rc", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.fixAll" } },
				apply = true,
			})
		end, opts)
	end,
})

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
--------------------

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
map("n", "<F5>", dap.continue)
map("n", "<F10>", dap.step_over)
map("n", "<F11>", dap.step_into)
map("n", "<F12>", dap.step_out)
map("n", "<Leader>db", dap.toggle_breakpoint)

map("i", "<C-l>", function()
	vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot Accept", noremap = true, silent = true })

map("n", "<F5>", function()
	require("dap").continue()
end)
map("n", "<F10>", function()
	require("dap").step_over()
end)
map("n", "<F11>", function()
	require("dap").step_into()
end)
map("n", "<F12>", function()
	require("dap").step_out()
end)
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end)
map("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
map("n", "<leader>dr", function()
	require("dap").repl.open()
end)
map("n", "<leader>dl", function()
	require("dap").run_last()
end)

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

local map = map
local opts = { noremap = true, silent = true }

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
