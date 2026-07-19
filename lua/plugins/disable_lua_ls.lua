return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				-- List only the servers you want
				"pyright",
				-- "lua_ls",  -- Removed
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				lua_ls = false, -- Explicitly disable
			},
		},
	},
}
