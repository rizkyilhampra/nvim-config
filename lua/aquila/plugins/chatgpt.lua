local identity = vim.fn.expand("$HOME/key.txt")
local api_key = vim.fn.expand("$HOME/gemini-api-key.age")
local host = vim.fn.expand("$HOME/openai-proxy-host.age")

return {
	"jackMort/ChatGPT.nvim",
	cmd = { "ChatGPT" },
	opts = function()
		vim.env.OPENAI_API_KEY = require("age").get(api_key, identity)
		vim.env.OPENAI_API_HOST = require("age").get(host, identity)

		return {
			openai_params = {
				model = "gemini-exp-1206",
				temperature = 0.5,
				top_p = 0.9,
			},
			keymaps = {
				close_n = { "<Esc>", "q" },
			},
		}
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"KingMichaelPark/age.nvim",
	},
}
