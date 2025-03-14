return {
	"luukvbaal/statuscol.nvim",
	event = "BufWinEnter",
	opts = function()
		local builtin = require("statuscol.builtin")
		return {
			ft_ignore = { "alpha" },
			segments = {
				relculright = true,
				{ sign = { namespace = { "diagnostic*" }, auto = true }, click = "v:lua.ScSa" },
				{ sign = { namespace = { "gitsigns" }, auto = true }, click = "v:lua.ScSa" },
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				{ text = { builtin.foldfunc, "  " }, click = "v:lua.ScFa" },
			},
		}
	end,
}
