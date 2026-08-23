return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-python").setup("python")
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }
    map("n", "<F5>", require("dap").continue, opts)
    map("n", "<F9>", require("dap").toggle_breakpoint, opts)
    map("n", "<F10>", require("dap").step_over, opts)
    map("n", "<F11>", require("dap").step_into, opts)
  end,
}
