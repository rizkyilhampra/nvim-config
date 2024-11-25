return {
	"lewis6991/gitsigns.nvim",
	event = "User BaseGitFile",
	opts = function()
		local get_icon = require("aquila.core.utils").get_icon

		return {
			max_file_length = vim.g.big_file.lines,
			signs = {
				add = { text = get_icon("GitSign") },
				change = { text = get_icon("GitSign") },
				delete = { text = get_icon("GitSign") },
				topdelete = { text = get_icon("GitSign") },
				changedelete = { text = get_icon("GitSign") },
				untracked = { text = get_icon("GitSign") },
			},
		}
	end,
}
