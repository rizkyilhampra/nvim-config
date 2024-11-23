return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	cond = vim.fn.filereadable("tailwind.config.js") == 1,
	opts = {
		server = {
			override = false,
		},
		conceal = {
			enabled = false,
		},
	},
}
