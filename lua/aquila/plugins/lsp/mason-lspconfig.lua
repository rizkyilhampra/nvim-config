local utils = require("aquila.core.utils")
local utils_lsp = require("aquila.core.utils.lsp")

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
	end,
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
		utils_lsp.apply_default_lsp_settings()
		utils.trigger_event("FileType")
	end,
}
