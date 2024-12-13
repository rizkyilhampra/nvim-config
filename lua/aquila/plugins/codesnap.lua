return {
	"mistricky/codesnap.nvim",
	build = "make",
	cmd = "CodeSnap",
	opts = {
		watermark = "",
		editor_font_family = "Iosevka Expanded", -- HACK: using `code_font_family` not working
	},
}
