--return {
--	"stevearc/conform.nvim",
--	event = { "BufWritePre" },
--	cmd = { "ConformInfo" },
--	keys = {
--		{
--			"<leader>f",
--			function()
--				require("conform").format({ async = true, lsp_fallback = true })
--			end,
--			desc = "Format buffer",
--		},
--	},
--	opts = {
--		formatters_by_ft = {
--			python = { "ruff_format", "ruff_organize_imports" },
--			lua = { "stylua" },
--			json = { "prettier" },
--			yaml = { "prettier" },
--			markdown = { "prettier" },
--		},
--		formatters = {
--			ruff_format = {
--				command = "ruff",
--				args = { "format", "--stdin-filename", "$FILENAME", "-" },
--				stdin = true,
--			},
--			ruff_organize_imports = {
--				command = "ruff",
--				args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
--				stdin = true,
--			},
--		},
--	},
--}

require("conform").setup({
  formatters_by_ft = {
    python = {
      -- To fix auto-fixable lint errors.
      "ruff_fix",
      -- To run the Ruff formatter.
      "ruff_format",
      -- To organize the imports.
      "ruff_organize_imports",
    },
  },
})
