return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "User BaseFile",
	opts = {
		ensure_installed = {
			"eslint_d",
			"prettierd",
			"selene",
			"pint",
			"shfmt",
			"vale",
			"blade-formatter",
			"stylua",
			"shellcheck",
		},
		auto_update = true,
		run_on_start = true,
	},
}
