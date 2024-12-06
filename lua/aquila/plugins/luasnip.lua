return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"benfowler/telescope-luasnip.nvim",
	},
	event = "User BaseFile",
	opts = {
		history = true,
		region_check_events = "CursorMoved,CursorMovedI",
		delete_check_events = "TextChanged,TextChangedI",
	},
	config = function(_, opts)
		if opts then
			require("luasnip").config.setup(opts)
		end
		vim.tbl_map(function(type)
			require("luasnip.loaders.from_" .. type).lazy_load()
		end, { "vscode", "snipmate", "lua" })

		require("luasnip").filetype_extend("typescript", { "tsdoc" })
		require("luasnip").filetype_extend("javascript", { "jsdoc" })
		require("luasnip").filetype_extend("lua", { "luadoc" })
		require("luasnip").filetype_extend("php", { "phpdoc" })
		require("luasnip").filetype_extend("sh", { "shelldoc" })
	end,
}
