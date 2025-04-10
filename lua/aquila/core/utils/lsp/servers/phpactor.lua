local M = {}

local lspconfig = require("lspconfig")

M.init_options = {
	["language_server_worse_reflection.inlay_hints.enable"] = true,
	["language_server_phpstan.enabled"] = false,
	["language_server_configuration.auto_config"] = false,
}
M.root_dir = function(fname)
	return lspconfig.util.root_pattern("composer.json", ".git")(fname) or lspconfig.util.path.dirname(fname)
end

return M
