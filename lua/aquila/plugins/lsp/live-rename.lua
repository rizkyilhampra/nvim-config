return {
	"saecki/live-rename.nvim",
	opts = {},
	keys = {
		{
			"<Leader>r",
			"<cmd>lua require('live-rename').rename({ text = '', insert = true})<CR>",
			desc = "Rename symbol under cursor",
		},
	},
}
