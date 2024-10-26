return {
	"folke/tokyonight.nvim",
	event = "User LoadColorSchemes",
	enabled = true,
	opts = {
		style = "moon",
		transparent = true,
		styles = {
			floats = "transparent",
		},
		lualine_bold = true,
		terminal_colors = false,
		on_highlights = function(hl, C)
			hl.NormalMoody = { fg = C.blue }
			hl.InsertMoody = { fg = C.green }
			hl.VisualMoody = { fg = C.magenta }
			hl.SelectMoody = { fg = C.magenta }
			hl.OperatorMoody = { fg = C.yellow }
			hl.CommandMoody = { fg = C.yellow }
			hl.ReplaceMoody = { fg = C.red }
			hl.TerminalMoody = { fg = C.green1 }
			hl.TerminalNormalMoody = { fg = C.green1 }
		end,
	},
}