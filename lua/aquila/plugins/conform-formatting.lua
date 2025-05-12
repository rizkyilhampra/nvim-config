local conform_opts = {
	formatters_by_ft = {
		php = { "php_cs_fixer", "pint" },
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
}

return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<Leader>af",
			function()
				local bufnr = vim.api.nvim_get_current_buf()
				local ft = vim.bo[bufnr].filetype

				if ft == "php" then
					local php_formatters_config = conform_opts.formatters_by_ft.php or {}
					local available_formatters_info = require("conform").list_formatters(bufnr)

					local available_map = {}
					for _, formatter_info in ipairs(available_formatters_info) do
						if type(formatter_info) == "table" and formatter_info.name then
							available_map[formatter_info.name] = true
						else
							vim.notify(
								"Conform: Unexpected formatter info structure: " .. vim.inspect(formatter_info),
								vim.log.levels.WARN
							)
						end
					end

					local available_and_configured_php = {}
					for _, name in ipairs(php_formatters_config) do
						if available_map[name] then
							table.insert(available_and_configured_php, name)
						end
					end

					if #available_and_configured_php > 1 then
						vim.ui.select(
							available_and_configured_php,
							{ prompt = "Select PHP formatter:" },
							function(choice)
								if choice then
									require("conform").format({
										formatters = { choice },
										async = true,
										lsp_fallback = false,
										bufnr = bufnr,
									})
								end
							end
						)
					elseif #available_and_configured_php == 1 then
						local chosen_formatter = available_and_configured_php[1]
						vim.notify(
							"Running only available configured PHP formatter: " .. chosen_formatter,
							vim.log.levels.INFO
						)
						require("conform").format({
							formatters = { chosen_formatter },
							async = true,
							lsp_fallback = false,
							bufnr = bufnr,
						})
					else
						vim.notify(
							"No configured PHP formatter is available. Trying default/LSP fallback.",
							vim.log.levels.WARN
						)
						require("conform").format({
							async = true,
							lsp_fallback = true,
							bufnr = bufnr,
						})
					end
				else
					require("conform").format({
						async = true,
						lsp_fallback = true,
						bufnr = bufnr,
					})
				end
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = conform_opts,
}
