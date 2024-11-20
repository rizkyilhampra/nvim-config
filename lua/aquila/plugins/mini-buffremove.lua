return {
	"echasnovski/mini.bufremove",
	event = "User BaseFile",
	opts = {
		silent = true,
	},
	keys = {
		{
			"<Leader>w",
			":lua MiniBufremove.delete()<CR>",
			noremap = true,
			silent = true,
			desc = "Close buffer",
		},
	},
}
