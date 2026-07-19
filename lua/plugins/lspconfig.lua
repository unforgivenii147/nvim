return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				yamlls = {
					capabilities = {
						textDocument = {
							foldingRange = {
								dynamicRegistration = false,
								lineFoldingOnly = true,
							},
						},
					},
					settings = {
						yaml = {
							keyOrdering = false,
							format = {
								enable = true,
							},
							validate = true,
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas({
								extra = {
									{
										description = "Taskfile schemas",
										fileMatch = {
											"Taskfile.yml",
											"Taskfile.yaml",
											"**/tasks/**/*.yml",
										},
										name = "taskfile",
										url = "https://taskfile.dev/schema.json",
									},
								},
							}),
						},
					},
				},
			},
		},
	},
}
