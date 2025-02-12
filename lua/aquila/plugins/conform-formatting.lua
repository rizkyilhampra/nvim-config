return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<Leader>af",
			function()
				require("conform").format({
					async = true,
					lsp_fallback = true,
				})
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			php = { "pint" },
			css = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			html = { "prettierd" },
			blade = function(_)
				-- NOTE: formatting blade files with prettierd it's use https://github.com/shufo/prettier-plugin-blade
				-- so it's need has .prettierrc file in the project root and also configured with that plugin.
				if vim.fn.filereadable(vim.fn.getcwd() .. "/.prettierrc") == 1 then
					return { "prettierd" }
				end
				return { "blade-formatter" }
			end,
			yml = { "prettierd" },
			jsonc = { "prettierd" },
			markdown = { "prettierd" },
			lua = { "stylua" },
			sh = { "shfmt" },
		},
	},
}
