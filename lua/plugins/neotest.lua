return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  keys = {
    { "<leader>T", "", desc = "+test" },
    { "<leader>Tt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run nearest test" },
    { "<leader>Tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run file tests" },
    { "<leader>Ts", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop test" },
    { "<leader>Ta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach to test" },
    { "<leader>To", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Show test output" },
    { "<leader>TO", "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = "Toggle output panel" },
    { "<leader>TS", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Toggle test summary" },
    {
      "<leader>Tw",
      "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<cr>",
      desc = "Toggle watch mode",
    },
    { "<leader>Td", "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", desc = "Debug nearest test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          runner = "pytest",
          args = { "--verbose" },
          python = ".venv/bin/python",
        }),
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          vim.cmd("copen")
        end,
      },
    })
  end,
}
