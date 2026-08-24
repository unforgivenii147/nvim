return {
	"mfussenegger/nvim-dap-python",
	ft = "python",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		-- Try to use debugpy from mason if available, fallback to system python
		local debugpy_path = require("mason").get_package_path("debugpy")
		local python_path = debugpy_path and debugpy_path .. "/venv/bin/python" or "python"
		require("dap-python").setup(python_path)
		-- DAP keymaps
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }
		map("n", "<F5>", require("dap").continue, opts)
		map("n", "<F9>", require("dap").toggle_breakpoint, opts)
		map("n", "<F10>", require("dap").step_over, opts)
		map("n", "<F11>", require("dap").step_into, opts)
		-- Additional debug keymaps for Python testing
		map("n", "<leader>dPt", function()
			require("dap-python").test_method()
		end, { desc = "Debug Method", ft = "python" })
		map("n", "<leader>dPc", function()
			require("dap-python").test_class()
		end, { desc = "Debug Class", ft = "python" })
	end,
}
