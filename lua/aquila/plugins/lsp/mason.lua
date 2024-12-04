return {
	"williamboman/mason.nvim",
	keys = {
		{ "<Leader>m", "<cmd>Mason<CR>", desc = "Open Mason" },
	},
	dependencies = {
		{
			"zeioth/mason-extra-cmds",
			opts = {},
		},
	},
	cmd = {
		"Mason",
		"MasonInstall",
		"MasonUninstall",
		"MasonUninstallAll",
		"MasonLog",
		"MasonUpdate",
		"MasonUpdateAll", -- this cmd is provided by mason-extra-cmds
	},
	opts = function()
		local utils = require("aquila.core.utils")

		return {
			ui = {
				icons = {
					package_installed = utils.get_icon("MasonInstalled"),
					package_uninstalled = utils.get_icon("MasonUninstalled"),
					package_pending = utils.get_icon("MasonPending"),
				},
				border = "rounded",
			},
		}
	end,
}
