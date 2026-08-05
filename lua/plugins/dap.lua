return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")

      -- Configure Python debugger
      dap.adapters.python = {
        type = "executable",
        command = "python", -- or "python3"
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return "python" -- or vim.fn.exepath("python3")
          end,
        },
      }
    end,
  },
}
