return {
	"max397574/better-escape.nvim",
	event = {
		"InsertEnter",
	},
	opts = {
		default_mappings = false,
		mappings = {
			i = {
				j = {
					j = "<Esc>",
					k = "<Esc>",
				},
			},
		},
	},
}