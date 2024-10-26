return {
	"folke/lazydev.nvim",
	ft = "lua",
	dependencies = {
		"Bilal2453/luvit-meta",
		{ "LuaCATS/luassert", name = "luassert-types" },
		{ "LuaCATS/busted", name = "busted-types" },
	},
	opts = {
		library = {
			{ path = "lazy.nvim", mods = { "lazy" } },
			{ path = "garbage-day.nvim", mods = { "garbage-day" } },
			{ path = "lazydev.nvim", mods = { "" } },
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
			{ path = "luassert-types/library", words = { "assert" } },
			{ path = "busted-types/library", words = { "describe" } },
			{ path = "nvimtools/none-ls.nvim", words = { "null-ls" } },
			{ path = "tokyonight.nvim", mods = { "tokyonight" } },
			"malas-ngodonf.nvim",
		},
	},
}
