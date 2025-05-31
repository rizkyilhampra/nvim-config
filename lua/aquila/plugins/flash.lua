return {
	"folke/flash.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		modes = {
			search = {
				enabled = false,
			},
			char = {
				jump_labels = true,
			},
		},
	},
}
