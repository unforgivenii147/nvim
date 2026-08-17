return {
  "mfussenegger/nvim-dap",
  config = function()
    -- Basic dap setup (users can extend with signs, UI)
    local dap = require("dap")
    -- leave adapter config to nvim-dap-python
  end,
}, {
  "mfussenegger/nvim-dap-python",
  dependencies = { "mfussenegger/nvim-dap", "mason-org/mason.nvim" },
  config = function()
    local ok, dap_python = pcall(require, "dap-python")
    if not ok then
      vim.notify("nvim-dap-python not available", vim.log.levels.WARN)
      return
    end

    -- Try to locate mason-installed debugpy
    local debugpy_path
    local ok_mr, mr = pcall(require, "mason-registry")
    if ok_mr then
      if mr.is_installed and mr.is_installed("debugpy") then
        local pkg = mr.get_package("debugpy")
        local install_path = pkg:get_install_path()
        local candidate = install_path .. "/venv/bin/python"
        if vim.loop.fs_stat(candidate) then
          debugpy_path = candidate
        else
          candidate = install_path .. "/python/bin/python"
          if vim.loop.fs_stat(candidate) then
            debugpy_path = candidate
          end
        end
      end
    end

    if debugpy_path then
      dap_python.setup(debugpy_path)
    else
      dap_python.setup() -- fallback to auto-detect
    end
  end,
}
