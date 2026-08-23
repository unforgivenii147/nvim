local lsp = "pyright" -- "pyright" or "basedpyright"
local ruff = "ruff" -- "ruff" or "ruff_lsp"
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "lua", "python" } },
	},
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				lsp,
				ruff,
				"debugpy",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					enabled = lsp == "pyright",
				},
				[lsp] = {
					enabled = true,
				},
				ruff_lsp = {
					enabled = ruff == "ruff_lsp",
				},
				ruff = {
					enabled = ruff == "ruff",
				},
				[ruff] = {
					keys = {
						{
							"<leader>co",
							LazyVim.lsp.action["source.organizeImports"],
							desc = "Organize Imports",
						},
					},
				},
			},
			setup = {
				[ruff] = function()
					LazyVim.lsp.on_attach(function(client, _)
						if client.name == ruff then
							client.server_capabilities.hoverProvider = false
						end
					end)
				end,
			},
		},
	},
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"nvim-neotest/neotest-python",
		},
		opts = {
			adapters = {
				["neotest-python"] = {
					-- Here you can specify the settings for the adapter, i.e.
					-- runner = "pytest",
					-- python = ".venv/bin/python",
				},
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			"mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
      },
			config = function()
				require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
			end,
		},
	},
	{
		"linux-cultist/venv-selector.nvim",
		branch = "regexp", -- Use this branch for the new version
		cmd = "VenvSelect",
		opts = {
			settings = {
				options = {
					notify_user_on_venv_activation = true,
				},
			},
		},
		--  Call config for python files and load the cached venv automatically
		ft = "python",
		keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.auto_brackets = opts.auto_brackets or {}
			table.insert(opts.auto_brackets, "python")
		end,
	},
	-- Format with Ruff (handles both formatting and import sorting)
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["python"] = { "ruff_format", "ruff_organize_imports" },
			},
		},
	},
}
