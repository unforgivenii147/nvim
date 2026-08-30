require("lvim.lsp.manager").setup("lua_ls")
-- local neodev_ok, neodev = pcall(require, "neodev")
-- if not neodev_ok then
-- 	vim.api.nvim_err_writeln("Neodev not installed")
-- else
-- 	neodev.setup()
-- end
local set = vim.opt_local
set.shiftwidth = 2
set.number = true
set.relativenumber = true
