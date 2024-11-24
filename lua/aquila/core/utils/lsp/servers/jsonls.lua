local M = {}

local is_schemastore_loaded, schemastore = pcall(require, "schemastore")

if is_schemastore_loaded then
	M.settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } }
end

return M
