local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_file_operations = require("lsp-file-operations")

capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M = vim.tbl_deep_extend(
	"force",
	capabilities,
	cmp_nvim_lsp.default_capabilities(),
	lsp_file_operations.default_capabilities()
)

return M
