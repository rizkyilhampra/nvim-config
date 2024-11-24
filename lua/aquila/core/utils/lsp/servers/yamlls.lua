local M = {}

local is_schemastore_loaded, schemastore = pcall(require, "schemastore")
if is_schemastore_loaded then
	M.settings = { yaml = { schemas = schemastore.yaml.schemas() } }
end

return M
