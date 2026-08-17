-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local log_file = vim.fn.stdpath("log") .. "/session.log"
vim.cmd(string.format("redir! >> %s", log_file))
vim.cmd("checkhealth")
vim.cmd("redir END")
