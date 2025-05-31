vim.filetype.add({
	extension = {
		neon = "yaml",
		["http"] = "http",
	},
	pattern = {
		[".*%.neon%.dist"] = "yaml",
		[".*/waybar/config"] = "jsonc",
		[".*/kitty/*.conf"] = "bash",
		[".*/hypr/.*%.conf"] = "hyprlang",
		[".*/%.env.*"] = "sh",
	},
})
