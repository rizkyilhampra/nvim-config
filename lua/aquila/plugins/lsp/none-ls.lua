return {
	"nvimtools/none-ls.nvim",
	event = "User BaseFile",
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls-extras.nvim",
		"gbprod/none-ls-luacheck.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		local sources = {
			require("none-ls.diagnostics.eslint_d").with({
				condition = function(utils)
					return utils.root_has_file({ ".eslintrc.js", ".eslintrc.yml", ".eslintrc.json" })
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
				diagnostics_postprocess = function(diagnostic)
					diagnostic.severity = diagnostic.message:find("really") and vim.diagnostic.severity["WARN"]
						or vim.diagnostic.severity["ERROR"]
				end,
				method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
				condition = function(utils)
					return utils.root_has_file(".vale.ini")
				end,
			}),
		}

		null_ls.setup({
			sources = sources,
			border = "rounded",
			debounce = 50,
		})
	end,
}
