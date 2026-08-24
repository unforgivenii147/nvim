return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	config = function()
		local dap = require("dap")
		-- Python adapter configuration
		dap.adapters.python = {
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
		}
		-- Python launch configurations
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					return "python"
				end,
			},
		}
	end,
}
