local M = {}
local augroup = vim.api.nvim_create_augroup("LaravelBladeLsp", { clear = true })

function M.setup(autocmd)
	if vim.g.php_lsp and vim.g.php_lsp ~= "intelephense" then
		return
	end

	-- Autocommand to temporarily change 'blade' filetype to 'php' when opening for LSP server activation
	autocmd.create({ "BufReadPost", "BufNewFile" }, {
		group = augroup,
		pattern = "*.blade.php",
		callback = function(args)
			vim.bo[args.buf].filetype = "php"
		end,
	})

	autocmd.create("LspAttach", {
		group = augroup,
		pattern = "*.blade.php",
		callback = function(args)
			vim.schedule(function()
				local buf = args.buf
				if vim.api.nvim_buf_is_valid(buf) then
					vim.bo[buf].filetype = "blade"
					vim.treesitter.start(buf, "blade")
					vim.cmd.syntax("enable")
				end
			end)
		end,
	})
end

return M
