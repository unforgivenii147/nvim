local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		{ import = "plugins" },
		-- LSP config goes here
		{ "neovim/nvim-lspconfig", opts = { servers = { pyright = {} } } },
	},
	defaults = {
		lazy = true,
		version = false,
	},
	install = {
		colorscheme = { "tokyonight", "habamax" },
		missing = false,
	},
	checker = {
		enabled = false,
		notify = false,
	},
	--  change-detection = {
	--    enabled = false,
	--  },
	git = {
		depth = 1,
		filter = "blob:none",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"netrw",
				"tohtml",
				"zipPlugin",
			},
		},
	},
})
