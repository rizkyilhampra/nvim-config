local M = {}
local utils = require("aquila.core.utils")
local stored_handlers = {}

M.apply_default_lsp_settings = function()
	local get_icon = utils.get_icon
	local signs = {
		{ name = "DiagnosticSignError", text = get_icon("DiagnosticError"), texthl = "DiagnosticSignError" },
		{ name = "DiagnosticSignWarn", text = get_icon("DiagnosticWarn"), texthl = "DiagnosticSignWarn" },
		{ name = "DiagnosticSignHint", text = get_icon("DiagnosticHint"), texthl = "DiagnosticSignHint" },
		{ name = "DiagnosticSignInfo", text = get_icon("DiagnosticInfo"), texthl = "DiagnosticSignInfo" },
	}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, sign)
	end

	local default_diagnostics = {
		virtual_text = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = utils.get_icon("DiagnosticError"),
				[vim.diagnostic.severity.HINT] = utils.get_icon("DiagnosticHint"),
				[vim.diagnostic.severity.WARN] = utils.get_icon("DiagnosticWarn"),
				[vim.diagnostic.severity.INFO] = utils.get_icon("DiagnosticInfo"),
			},
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
		},
	}

	M.diagnostics = {
		[0] = vim.tbl_deep_extend(
			"force",
			default_diagnostics,
			{ underline = false, virtual_text = false, signs = false, update_in_insert = false }
		),
		vim.tbl_deep_extend("force", default_diagnostics, { virtual_text = false, signs = false }),
		vim.tbl_deep_extend("force", default_diagnostics, { virtual_text = false }),
		default_diagnostics,
	}
	vim.diagnostic.config(M.diagnostics[vim.g.diagnostics_mode])
end

function M.apply_user_lsp_mappings(_, bufnr)
	local opts = { buffer = bufnr }

	local lsp_mappings = {
		n = {
			["gi"] = "<cmd>Telescope lsp_implementations<CR>",
			["gr"] = "<cmd>Telescope lsp_references<CR>",
			["gd"] = "<cmd>Telescope lsp_definitions<CR>",
			["<leader>ca"] = vim.lsp.buf.code_action,
			["<C-k>"] = function()
				vim.diagnostic.open_float()
			end,
		},
	}

	utils.set_mappings(lsp_mappings, opts)
end

function M.apply_user_lsp_settings(server_name)
	local server = require("lspconfig")[server_name]
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	local lsp_file_operations = require("lsp-file-operations")

	M.capabilities = vim.lsp.protocol.make_client_capabilities()
	M.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
	M.capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	M.capabilities = vim.tbl_deep_extend(
		"force",
		M.capabilities,
		cmp_nvim_lsp.default_capabilities(),
		lsp_file_operations.default_capabilities()
	)

	M.flags = {}
	local opts = vim.tbl_deep_extend("force", server, {
		capabilities = M.capabilities,
		flags = M.flags,
	})

	if server_name == "jsonls" then
		local is_schemastore_loaded, schemastore = pcall(require, "schemastore")
		if is_schemastore_loaded then
			opts.settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } }
		end
	end
	if server_name == "yamlls" then
		local is_schemastore_loaded, schemastore = pcall(require, "schemastore")
		if is_schemastore_loaded then
			opts.settings = { yaml = { schemas = schemastore.yaml.schemas() } }
		end
	end

	if server_name == "phpactor" then
		opts.init_options = {
			["language_server_worse_reflection.inlay_hints.enable"] = true,
			["language_server_phpstan.enabled"] = true,
			["phpunit.enabled"] = true,
		}
		opts.root_dir = function(fname)
			return lspconfig.util.root_pattern("composer.json", ".git")(fname) or lspconfig.util.path.dirname(fname)
		end
	end

	if server_name == "html" then
		opts.filetypes = { "html", "blade" }
	end

	if server_name == "emmet_ls" then
		opts.filetypes = {
			"css",
			"eruby",
			"html",
			"javascript",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"svelte",
			"pug",
			"typescriptreact",
			"vue",
			"blade",
		}
	end

	if server_name == "bashls" then
		opts.single_file_support = true
	end

	if server_name == "lua_ls" then
		opts.settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					pathStrict = true,
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("lua")] = true,
						[vim.fn.expand("${3rd}/luv/library")] = true,
						-- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
				hint = {
					enable = true,
					-- setType = false,
					arrayIndex = "Disable",
				},
				completion = {
					callSnippet = "Replace",
				},
				-- checkThirdParty = false,
				-- telemetry = {
				--     enable = true,
				-- },
			},
		}
	end

	if server_name == "tailwindcss" then
		opts.root_dir = function(fname)
			return lspconfig.util.root_pattern("tailwind.config.js")(fname)
		end
	end

	local old_on_attach = server.on_attach
	opts.on_attach = function(client, bufnr)
		if type(old_on_attach) == "function" then
			old_on_attach(client, bufnr)
		end
		M.apply_user_lsp_mappings(client, bufnr)
	end

	return opts
end

M.setup = function(server)
	local opts = M.apply_user_lsp_settings(server)
	local setup_handler = stored_handlers[server] or require("lspconfig")[server].setup(opts)
	if setup_handler then
		setup_handler(server, opts)
	end
end

return M
