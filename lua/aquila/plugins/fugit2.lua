return {
	"SuperBo/fugit2.nvim",
	opts = {
		width = 70,
		height = "80%",
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"chrisgrieser/nvim-tinygit",
		{
			"sindrets/diffview.nvim",
			cmd = {
				"DiffviewFileHistory",
				"DiffviewOpen",
				"DiffviewToggleFiles",
				"DiffviewFocusFiles",
				"DiffviewRefresh",
			},
		},
	},
	cmd = { "Fugit2", "Fugit2Blame", "Fugit2Diff", "Fugit2Graph" },
	keys = {
		{
			"<Leader>gff",
			"<cmd>Fugit2<CR>",
			desc = "Fugit2",
		},
	},
}
