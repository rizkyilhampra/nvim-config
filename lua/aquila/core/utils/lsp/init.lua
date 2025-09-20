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
		update_in_insert = false,
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
			["gp"] = "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
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
	local resolved = vim.lsp.config[server_name] or {}

	local ok, user_cfg = pcall(require, ("aquila.core.utils.lsp.servers.%s"):format(server_name))
	if not ok or type(user_cfg) ~= "table" then
		user_cfg = {}
	end

	local base_on_attach = resolved.on_attach
	local user_on_attach = user_cfg.on_attach

	local my_caps = require("aquila.core.utils.lsp.capabilities")
	local merged_caps =
		vim.tbl_deep_extend("force", {}, resolved.capabilities or {}, my_caps or {}, user_cfg.capabilities or {})

	local opts = vim.tbl_deep_extend("force", {}, resolved, user_cfg, {
		capabilities = merged_caps,
		flags = vim.tbl_deep_extend("force", {}, resolved.flags or {}, user_cfg.flags or {}),
	})

	opts.on_attach = function(client, bufnr)
		if type(base_on_attach) == "function" then
			base_on_attach(client, bufnr)
		end
		if type(user_on_attach) == "function" then
			user_on_attach(client, bufnr)
		end
		M.apply_user_lsp_mappings(client, bufnr)
	end

	return opts
end

M.setup = function(server)
	local opts = M.apply_user_lsp_settings(server)
	local setup_handler = stored_handlers[server]
		or function(name, o)
			vim.lsp.config(name, o)
			vim.lsp.enable(name)
		end
	setup_handler(server, opts)
end

return M
