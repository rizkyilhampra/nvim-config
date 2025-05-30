return {
	"tzachar/highlight-undo.nvim",
	event = "User BaseDefered",
	opts = {
		duration = 150,
		hlgroup = "IncSearch",
	},
	config = function(_, opts)
		require("highlight-undo").setup(opts)

		vim.api.nvim_create_autocmd("TextYankPost", {
			desc = "Highlight yanked text",
			pattern = "*",
			callback = function()
				(vim.hl or vim.highlight).on_yank()
			end,
		})
	end,
}
