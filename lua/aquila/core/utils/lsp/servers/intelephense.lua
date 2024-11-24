local M = {}

M.filetypes = { "php", "blade", "php_only" }
M.settings = {
	intelephense = {
		files = {
			associations = { "*.php", "*.blade.php" },
		},
	},
}

return M
