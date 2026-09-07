local group = vim.api.nvim_create_augroup("SaveStartupMessages", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    -- Defer slightly to ensure all startup plugins finish emitting messages
    vim.defer_fn(function()
      local log_file = vim.fn.expand("~/tmp/apps/startup.txt")
      local messages = vim.fn.execute("messages")

      local file = io.open(log_file, "w")
      if file then
        file:write(messages)
        file:close()
      end
    end, 100)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "bash", "python" },
  callback = function()
    vim.treesitter.start()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general = augroup("GeneralSettings", { clear = true })

autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("FileType", {
  group = general,
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "120"
    vim.opt_local.textwidth = 120
  end,
})

autocmd("BufWritePre", {
  group = general,
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
