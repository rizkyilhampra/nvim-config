return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		picker = {},
	},
	keys = {
		{
			"<Leader><Tab>",
			function()
				require("snacks").picker.recent({
					filter = {
						cwd = true,
					},
					limit = 10,
					focus = "list",
					layout = "select",
				})
			end,
			desc = "Recent files",
		},
	},
}
