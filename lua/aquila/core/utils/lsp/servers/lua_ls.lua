local M = {}

M.settings = {
	Lua = {
		runtime = {
			version = "LuaJIT",
			pathStrict = true,
		},
		workspace = {
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("lua")] = true,
				[vim.fn.expand("${3rd}/luv/library")] = true,
				-- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			},
		},
		hint = {
			enable = true,
			-- setType = false,
			arrayIndex = "Disable",
		},
		completion = {
			callSnippet = "Replace",
		},
		-- checkThirdParty = false,
		-- telemetry = {
		--     enable = true,
		-- },
	},
}

return M
