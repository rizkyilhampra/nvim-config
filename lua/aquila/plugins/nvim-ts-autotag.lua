-- nvim-ts-autotag [auto close html tags]
-- https://github.com/windwp/nvim-ts-autotag
-- Adds support for HTML tags to the plugin nvim-autopairs.
return {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"windwp/nvim-autopairs",
	},
	opts = {},
}
