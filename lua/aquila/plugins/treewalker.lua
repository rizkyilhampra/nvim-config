return {
	"aaronik/treewalker.nvim",
	opts = {
		highlight = true,
	},
	cmd = "Treewalker",
	keys = {
		{
			"<Down>",
			":Treewalker Down<CR>",
			noremap = true,
			silent = true,
			desc = "Moves down to the next neighbour",
		},
		{
			"<Up>",
			":Treewalker Up<CR>",
			noremap = true,
			silent = true,
			desc = "Moves up to the previous neighbour",
		},
		{
			"<Left>",
			":Treewalker Left<CR>",
			noremap = true,
			silent = true,
			desc = "Finds the next child of the current node",
		},
		{
			"<Right>",
			":Treewalker Right<CR>",
			noremap = true,
			silent = true,
			desc = "Finds the next parent of the current node",
		},
	},
}
