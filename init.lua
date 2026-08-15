-- ~/.config/nvim/init.lua
-- Bootstrap lazy.nvim then load core and plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Core (options, keymaps)
require("core.options")
require("core.keymaps")

-- Load all plugin specs from lua/plugins/*.lua using lazy.nvim style
require("lazy").setup("plugins", {
  change_detection = { enabled = false },
})
