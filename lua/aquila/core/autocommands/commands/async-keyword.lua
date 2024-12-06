-- NOTE: Stolen from https://gist.github.com/JoosepAlviste/43e03d931db2d273f3a6ad21134b3806

local M = {}

local utils = require("aquila.core.utils")

local function add_async()
	vim.api.nvim_feedkeys("t", "n", true)

	local buffer = vim.fn.bufnr()

	local text_before_cursor = vim.fn.getline("."):sub(vim.fn.col(".") - 4, vim.fn.col(".") - 1)
	if text_before_cursor ~= "awai" then
		return
	end

	local current_node = vim.treesitter.get_node({ ignore_injections = false })
	local function_node =
		utils.find_node_ancestor({ "arrow_function", "function_declaration", "function" }, current_node)
	if not function_node then
		return
	end

	local function_text = vim.treesitter.get_node_text(function_node, 0)
	if vim.startswith(function_text, "async") then
		return
	end

	local start_row, start_col = function_node:start()
	vim.api.nvim_buf_set_text(buffer, start_row, start_col, start_row, start_col, { "async " })
end

function M.setup(autocmd)
	autocmd.create("FileType", {
		pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		group = vim.api.nvim_create_augroup("JavaScriptAsyncMapping", { clear = true }),
		callback = function(args)
			vim.keymap.set("i", "t", add_async, { buffer = args.buf })
		end,
	})
end

return M
