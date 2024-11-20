return {
	"zeioth/garbage-day.nvim",
	event = "LspAttach",
	opts = {
		aggressive_mode = false,
		excluded_lsp_clients = {
			"copilot",
			"null-ls",
			"marksman",
		},
		grace_period = (60 * 15),
		wakeup_delay = 3000,
		notifications = false,
		retries = 3,
		timeout = 1000,
	},
}
