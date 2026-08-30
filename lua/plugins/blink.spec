return {
	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.appearance = opts.appearance or {}
			opts.appearance.kind_icons =
				vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)
			opts.keymap = vim.tbl_extend("force", opts.keymap or {}, { preset = "default" })
			opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
				documentation = { auto_show = true, auto_show_delay_ms = 150 },
				ghost_text = { enabled = true },
			})
			return opts
		end,
	},
}
