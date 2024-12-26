return {
	"supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    cond = function()
        return vim.g.inline_code_completion_provider == "supermaven"
    end,
	opts = {
		disable_keymaps = true,
	},
}
