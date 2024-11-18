return {
	"echasnovski/mini.bufremove",
	event = "User BaseFile",
	opts = {
		silent = true,
	},
	keys = {
		{
			"<C-w>q",
			":lua MiniBufremove.delete()<CR>",
			noremap = true,
			silent = true,
			desc = "Close buffer",
		},
	},
}
