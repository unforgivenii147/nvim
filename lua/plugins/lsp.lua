return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup({
			install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
			PATH = "prepend",
			log_level = vim.log.levels.DEBUG,
			max_concurrent_installers = 4,
			registries = { "github:mason-org/mason-registry" },
			system_registries = { "github:mason-org/mason-system-registry" },
			registry_cache = { refresh = true, duration = 30 * 24 * 60 * 60 },
			firewall = { enabled = false, auto_managed = true },
			providers = { "mason.providers.registry-api", "mason.providers.client" },
			github = { download_url_template = "https://github.com/%s/releases/download/%s/%s" },
			pip = { upgrade_pip = false, install_args = {} },
			npm = { install_args = {} },
			ui = {
				check_outdated_packages_on_open = true,
				border = nil,
				backdrop = 60,
				width = 0.8,
				height = 0.9,
				icons = { package_installed = "◍", package_pending = "◍", package_uninstalled = "◍" },
				keymaps = {
					toggle_package_expand = "<CR>",
					install_package = "i",
					update_package = "u",
					check_package_version = "c",
					update_all_packages = "U",
					check_outdated_packages = "C",
					uninstall_package = "X",
					cancel_installation = "<C-c>",
					apply_language_filter = "<C-f>",
					toggle_package_install_log = "<CR>",
					toggle_help = "g?",
				},
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = { "ruff", "pyright" },
			automatic_installation = true,
		})
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		lspconfig.pyright.setup({
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
						diagnosticSeverityOverrides = { reportUnusedVariable = "warning" },
					},
				},
			},
		}, { capabilities = capabilities })
		lspconfig.ruff.setup({ init_options = { settings = {} } }, { capabilities = capabilities })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
		vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
	end,
}
