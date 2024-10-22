return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		heading = {
			sign = false,
			width = "block",
		},
		code = {
			sign = false,
			width = "block",
			right_pad = 1,
		},
		dash = {
			width = 79,
		},
		pipe_table = {
			style = "full",
		},
	},
}
