-- lsp.lua
local lspconfig = require("lspconfig")

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Pyright configuration
lspconfig.pyright.setup({
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off", -- Disable type checking (Ruff handles this)
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
				diagnosticSeverityOverrides = {
					reportUnusedVariable = "warning",
				},
			},
		},
	},
})

-- Ruff configuration
lspconfig.ruff.setup({
	init_options = {
		settings = {
			-- Ruff language server settings
		},
	},
})
