return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
    cond = function()
        return vim.g.inline_code_completion_provider == "copilot"
    end,
	opts = {
		suggestion = {
			auto_trigger = true,
		},
		filetypes = {
			markdown = true,
		},
	},
}

