return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	event = "User BaseFile",
	cond = vim.fn.filereadable("tailwind.config.js") == 1,
	opts = {
		conceal = {
			enabled = false,
		},
	},
}
