return {
	"rmagatti/goto-preview",
	opts = {
		width = 80,
		post_open_hook = function(buf, _)
			vim.api.nvim_buf_set_keymap(
				buf,
				"n",
				"q",
				'<cmd>lua require("goto-preview").close_all_win()<CR>',
				{ noremap = true, silent = true }
			)
		end,
		same_file_float_preview = false,
	},
}
