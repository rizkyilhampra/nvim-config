return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
    enabled = vim.g.inline_code_completion_provider == "copilot",
	opts = {
		suggestion = {
			auto_trigger = true,
		},
		filetypes = {
			markdown = true,
		},
	},
}

