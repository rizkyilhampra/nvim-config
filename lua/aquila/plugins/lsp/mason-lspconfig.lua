local servers = {
	"lua_ls",
	"cssls",
	"html",
	"vtsls",
	"emmet_ls",
	"bashls",
	"marksman",
	"jsonls",
	"sqlls",
	"yamlls",
	"tailwindcss",
	"docker_compose_language_service",
	"dockerls",
}

if vim.g.php_lsp then
	table.insert(servers, vim.g.php_lsp)
end

return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"zeioth/garbage-day.nvim",
	},
	event = "User BaseFile",
	opts = function(_, opts)
		if not opts.handlers then
			opts.handlers = {}
		end
		opts.handlers[1] = function(server)
			require("aquila.core.utils.lsp.init").setup(server)
		end
		opts.ensure_installed = servers
	end,
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
		require("aquila.core.utils.lsp.init").apply_default_lsp_settings()
		require("aquila.core.utils").trigger_event("FileType")
	end,
}
