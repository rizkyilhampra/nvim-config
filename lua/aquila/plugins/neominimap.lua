return {
	"Isrothy/neominimap.nvim",
	lazy = false,
	init = function()
		vim.g.neominimap = {
			diagnostic = {
				enabled = false,
			},
			auto_enable = true,
			buf_filter = function(bufnr)
				return require("aquila.core.utils").is_big_file(bufnr)
			end,
			float = {
				z_index = 21,
				margin = {
					top = 1,
				},
				window_border = "",
				minimap_width = 15,
			},
			search = {
				enabled = true,
			},
			click = {
				enabled = true,
			},
			delay = 1000,
			git = {
				enabled = false,
			},
		}
	end,
}
