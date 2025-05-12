return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	event = "User BaseDefered",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"javascript",
				"jsdoc",
				"typescript",
				"html",
				"css",
				"bash",
				"sql",
				"regex",
				"markdown_inline",
				"markdown",
				"php",
				"php_only",
				"phpdoc",
				"http",
				"json",
				"hyprlang",
                "blade",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = function(_, bufnr)
					return require("aquila.core.utils").is_big_file(bufnr)
				end,
			},
			indent = { enable = true },
			modules = {},
		})

	end,
}
