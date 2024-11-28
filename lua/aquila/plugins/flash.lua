return {
	"folke/flash.nvim",
	event = "User BaseFile",
	opts = {
		modes = {
			search = {
				enabled = false,
			},
			char = {
				keys = { "f", "F", "t", "T" },
			},
		},
	},
}

