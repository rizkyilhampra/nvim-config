--- NOTE: Usage example
--- Add surrounding quoetes:  sa + motion + char => saiw'
--- Replace surrounding quoetes: sr + char => sr"'
--- Delete surrounding quoetes: sd + char => sd'

return {
	"echasnovski/mini.surround",
	event = "User BaseFile",
	version = false,
	opts = {
		silent = true,
	},
}

