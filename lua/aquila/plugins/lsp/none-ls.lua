return {
	"nvimtools/none-ls.nvim",
	event = "User BaseFile",
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls-extras.nvim",
		"gbprod/none-ls-luacheck.nvim",
		"gbprod/none-ls-shellcheck.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		local sources = {
			require("none-ls.diagnostics.eslint_d").with({
				condition = function(utils)
					return utils.root_has_file({ "eslint.config.js", ".eslintrc.js" })
				end,
			}),
			null_ls.builtins.diagnostics.selene.with({
				condition = function(utils)
					return utils.root_has_file("selene.toml")
				end,
			}),
			require("none-ls-luacheck.diagnostics.luacheck").with({
				condition = function(utils)
					return utils.root_has_file({ ".luacheck", ".luacheckrc" })
				end,
			}),
			null_ls.builtins.diagnostics.vale.with({
				filetype = { "markdown" },
				condition = function(utils)
					return utils.root_has_file(".vale.ini")
				end,
			}),
			null_ls.builtins.diagnostics.phpstan.with({
				extra_args = { "--memory-limit=1G" },
				prefer_local = "vendor/bin",
				method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
				diagnostic_config = {
					update_in_insert = false,
				},
				condition = function(utils)
					return vim.g.phpstan_enabled and utils.root_has_file({ "phpstan.neon", "phpstan.neon.dist" })
				end,
			}),
			require("none-ls-shellcheck.diagnostics"),
			require("none-ls-shellcheck.code_actions"),
		}

		null_ls.setup({
			sources = sources,
			border = "rounded",
			debounce = 50,
		})
	end,
}
