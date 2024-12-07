return {
	"adalessa/laravel.nvim",
	dependencies = {
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
		"kevinhwang91/promise-async",
		"nvim-telescope/telescope.nvim",
	},
	cmd = { "Laravel" },
	opts = {
		features = {
			model_info = {
				enable = false,
			},
			route_info = {
				enable = false,
			},
		},
	},
	config = true,
}
