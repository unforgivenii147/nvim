return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    { "<leader>d", "", desc = "+debug" },
    { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
    {
      "<leader>dB",
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Condition: '))<cr>",
      desc = "Conditional breakpoint",
    },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step over" },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step into" },
    { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step out" },
    { "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>", desc = "Open REPL" },
    { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run last" },
    { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI" },
    { "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", desc = "Evaluate", mode = { "n", "v" } },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    require("dap-python").setup("python3")

    require("dap-python").test_runner = "pytest"
  end,
}
