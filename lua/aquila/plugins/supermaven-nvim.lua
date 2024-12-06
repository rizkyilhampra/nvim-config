return {
	"supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
	enabled = vim.g.inline_code_completion_provider == "supermaven",
	opts = {
		disable_keymaps = true,
	},
}
