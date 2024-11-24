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

local utils = require("aquila.core.utils")
local utils_lsp = require("aquila.core.utils.lsp.init")

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	event = "User BaseFile",
	opts = function(_, opts)
		if not opts.handlers then
			opts.handlers = {}
		end
		opts.handlers[1] = function(server)
			utils_lsp.setup(server)
		end
		opts.ensure_installed = servers
	end,
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
		utils_lsp.apply_default_lsp_settings()
		utils.trigger_event("FileType")
	end,
}
