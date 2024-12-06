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

		---@class parser_config
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.blade = {
			install_info = {
				url = "https://github.com/EmranMR/tree-sitter-blade",
				files = { "src/parser.c" },
				branch = "main",
				generate_requires_npm = true,
				requires_generate_from_grammar = true,
			},
			filetype = "blade",
		}

		vim.filetype.add({
			extension = {
				neon = "yaml",
				["http"] = "http",
			},
			pattern = {
				[".*%.neon%.dist"] = "yaml",
				[".*/waybar/config"] = "jsonc",
				[".*/kitty/*.conf"] = "bash",
				[".*/hypr/.*%.conf"] = "hyprlang",
				[".*/%.env.*"] = "sh",
			},
		})
	end,
}
