local M = {}
local utils = require("aquila.core.utils")
M = utils.get_mappings_template()

local function multi_mode(modes, key, cmd, opts)
	opts = opts or {}
	for _, mode in ipairs(modes) do
		if not M[mode] then
			M[mode] = {}
		end
		M[mode][key] = vim.tbl_extend("force", { cmd }, opts)
	end
end

M.n["$"] = { "g_", desc = "Go to the last non-blank character of the line" }

M.n["j"] = {
	[[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']],
	expr = true,
	desc = "Move the cursor up by the number of lines specified by the count",
}
M.n["k"] = {
	[[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']],
	expr = true,
	desc = "Move the cursor down by the number of lines specified by the count",
}
M.n[";"] = { ":", desc = "CMD enter command mode" }

M.n["<C-s>"] = { "<cmd>w<CR>", desc = "Save file" }

multi_mode({ "n", "v", "i" }, "<C-z>", "<Nop>", { desc = "Disable <C-z> to avoid exiting neovim" })

M.n["<C-c>"] = { "<Nop>", desc = "Disable <C-c> to avoid exiting neovim" }

M.v["J"] = { ":m '>+1<CR>gv=gv", desc = "Move selected lines down", silent = true }
M.v["K"] = { ":m '<-2<CR>gv=gv", desc = "Move selected lines up", silent = true }

M.n["n"] = {
	function()
		vim.cmd("normal! n")

		if package.loaded["mini.animate"] then
			vim.cmd("lua require('mini.animate').execute_after('scroll', 'normal! zvzz')")
		else
			vim.cmd("normal! zvzz")
		end
	end,
	desc = "Center the line after pressing n",
}
M.n["N"] = {
	function()
		vim.cmd("normal! N")

		if package.loaded["mini.animate"] then
			require("mini.animate").execute_after("scroll", "normal! zvzz")
		else
			vim.cmd("normal! zvzz")
		end
	end,
	desc = "Center the line after pressing N",
}

M.n["<Leader>l"] = { "<cmd>Lazy<CR>", desc = "Open Lazy" }

multi_mode({ "n", "v" }, "<Leader>y", '"+y', { desc = "Copy/yank to system clipboard" })
multi_mode({ "n", "v" }, "<Leader>p", '"+p', { desc = "Paste from system clipboard" })

M.v["<Leader>P"] = { '"_dP', desc = 'Do not lose the " register on paste' }

multi_mode({ "n", "x" }, "x", '"_x', { desc = 'Do not lose the " register on delete' })

M.n["s"] = { '"_s', desc = 'Do not lose the " register on replace' }

M.n["<Leader>~"] = { "<cmd>Alpha<CR>", desc = "Take me home..." }

M.n["H"] = { "<C-w>h", desc = "Move to the left window" }
M.n["L"] = { "<C-w>l", desc = "Move to the right window" }

M.n["dd"] = {
	function()
		if vim.fn.getline("."):match("^%s*$") then
			return '"_dd'
		end
		return "dd"
	end,
	expr = true,
	desc = "Delete line without copy to register if line is empty",
}

multi_mode(
	{ "n", "v" },
	"<C-S-d>",
	"<cmd>lua require('aquila.core.commands').duplicate_selection()<CR>",
	{ desc = "Duplicate line/selection" }
)
M.v["<C-M-d>"] = {
	function()
		vim.cmd("lua require('aquila.core.commands').duplicate_selection()")
		vim.fn.execute([[noautocmd normal! gv]])
	end,
	desc = "Duplicate selection (keep selection)",
}

M.v["<Leader>Y"] = {
	function()
		local v_start = vim.fn.getpos("v")[2]
		local v_end = vim.fn.getpos(".")[2]

		local selected = vim.api.nvim_buf_get_lines(0, math.min(v_start, v_end) - 1, math.max(v_start, v_end), true)

		local indent = require("aquila.core.commands").get_indent(selected)
		for i, line in ipairs(selected) do
			selected[i] = line:sub(indent)
		end

		local text = table.concat(selected, "\n")
		vim.fn.setreg("+", text)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
	end,
	silent = true,
	desc = "Copy/yank to system clipboard without indent from source",
}

M.n["K"] = {
	function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			vim.lsp.buf.hover()
		end
	end,
	desc = "Show hover information",
}

M.x["<"] = { "<gv", desc = "unindent selection" }
M.x[">"] = { ">gv", desc = "indent selection" }

M.n["gg"] = {
	function()
		vim.g.minianimate_disable = true
		if vim.v.count > 0 then
			vim.cmd("normal! " .. vim.v.count .. "gg")
		else
			vim.cmd("normal! gg0")
		end

		vim.schedule(function()
			vim.g.minianimate_disable = false
		end)
	end,
	desc = "gg and go to the first position without animation",
}

M.n["G"] = {
	function()
		vim.g.minianimate_disable = true
		vim.cmd("normal! G")

		vim.schedule(function()
			vim.g.minianimate_disable = false
		end)
	end,
	desc = "G without animation",
}
M.x["G"] = {
	function()
		vim.g.minianimate_disable = true
		vim.cmd("normal! G$")

		vim.schedule(function()
			vim.g.minianimate_disable = false
		end)
	end,
	desc = "G and go to the last position (visual) without animation",
}

M.x["gg"] = {
	function()
		vim.g.minianimate_disable = true
		if vim.v.count > 0 then
			vim.cmd("normal! " .. vim.v.count .. "gg")
		else
			vim.cmd("normal! gg0")
		end

		vim.schedule(function()
			vim.g.minianimate_disable = false
		end)
	end,
	desc = "gg and go to the first position (visual) without animation",
}

utils.set_mappings(M)

return M
