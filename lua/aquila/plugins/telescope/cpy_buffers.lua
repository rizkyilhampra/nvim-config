return {
	"adia-dev/cpy_buffers.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<Leader>fc",
			'<cmd>lua require("cpy_buffers.picker").open_file_picker()<CR>',
			desc = "Copy from buffer to file",
		},
	},
	opts = {},
}
