local M = {}
local utils = require("aquila.core.utils")

local auogroup = vim.api.nvim_create_augroup("AquilaCmd", { clear = true })

function M.create_wrapper()
	return function(event, opts)
		opts.group = opts.group or auogroup
		return vim.api.nvim_create_autocmd(event, opts)
	end
end

M.create = M.create_wrapper()

M.create("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
	desc = "Restore cursor position",
})

M.create("BufReadPost", {
	once = true,
	callback = function()
		local home = os.getenv("HOME")
		if not vim.fn.isdirectory(home .. "/.vim") then
			vim.fn.mkdir(home .. "/.vim", "", "rwxrw-")
		end
		if not vim.fn.isdirectory(home .. "/.vim/undo-dir") then
			vim.fn.mkdir(home .. "/.vim/undo-dir", "", "rwx")
		end
	end,
	desc = "Create undo-dir",
})

M.create("User", {
	once = true,
	pattern = "AlphaReady",
	desc = "Hide cursor in Alpha",
	callback = function()
		vim.api.nvim_set_hl(0, "Cursor", { default = true, blend = 100, force = true })
	end,
})

M.create("BufNew", {
	once = true,
	desc = "Show cursor after Alpha",
	callback = function()
		vim.api.nvim_set_hl(0, "Cursor", { default = true, blend = 0, force = true })
	end,
})

-- NOTE: This is a workaround for the issue with the `commentstring` option. Will see if it's still needed when v0.10.0 is released
-- M.create('FileType', {
--     desc = 'Force commentstring to include spaces',
--     callback = function(event)
--         local cs = vim.bo[event.buf].commentstring
--         vim.bo[event.buf].commentstring = cs:gsub('(%S)%%s', '%1 %%s'):gsub('%%s(%S)', '%%s %1')
--     end,
-- })

-- NOTE: This is a workaround for the gray CursorLine in the Telescope prompt when using svampkorg/moody.nvim
M.create("FileType", {
	pattern = "TelescopePrompt",
	callback = function()
		vim.wo.cursorline = false
	end,
})

--    Events to load plugins faster → 'BaseFile'/'BaseGitFile'/'BaseDefered':
--    this is pretty much the same thing as the event 'BufEnter',
--    but without increasing the startup time displayed in the greeter.
M.create({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
	desc = "Nvim user events for file detection (BaseFile and BaseGitFile)",
	callback = function(args)
		local empty_buffer = vim.fn.resolve(vim.fn.expand("%")) == ""
		local greeter = vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "alpha"
		local git_repo = utils.run_cmd(
			{ "git", "-C", vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("%")), ":p:h"), "rev-parse" },
			false
		)

		-- For any file exept empty buffer, or the greeter (alpha)
		if not (empty_buffer or greeter) then
			utils.trigger_event("User BaseFile")

			-- Is the buffer part of a git repo?
			if git_repo then
				utils.trigger_event("User BaseGitFile")
			end
		end
	end,
})
M.create({ "VimEnter" }, {
	desc = "Nvim user event that trigger a few ms after nvim starts",
	callback = function()
		-- If nvim is opened passing a filename, trigger the event inmediatelly.
		if #vim.fn.argv() >= 1 then
			-- In order to avoid visual glitches.
			utils.trigger_event("User BaseDefered", true)
			utils.trigger_event("BufEnter", true) -- also, initialize tabline_buffers.
		else -- Wait some ms before triggering the event.
			vim.defer_fn(function()
				utils.trigger_event("User BaseDefered")
			end, 70)
		end
	end,
})

M.create({ "User", "BufEnter" }, {
	desc = "Disable status and tablines for alpha",
	callback = function(args)
		local is_filetype_alpha = vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "alpha"
		local is_empty_file = vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "nofile"
		if
			((args.event == "User" and args.file == "AlphaReady") or (args.event == "BufEnter" and is_filetype_alpha))
			and not vim.g.before_alpha
		then
			vim.g.before_alpha = {
				showtabline = vim.opt.showtabline:get(),
				laststatus = vim.opt.laststatus:get(),
			}
			vim.opt.showtabline, vim.opt.laststatus = 0, 0
		elseif vim.g.before_alpha and args.event == "BufEnter" and not is_empty_file then
			vim.opt.laststatus = vim.g.before_alpha.laststatus
			vim.opt.showtabline = vim.g.before_alpha.showtabline
			vim.g.before_alpha = nil
		end
	end,
})
M.create("VimEnter", {
	desc = "Start Alpha only when nvim is opened with no arguments",
	callback = function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
		local buf_not_empty = vim.fn.argc() > 0 or #lines > 1 or (#lines == 1 and lines[1]:len() > 0)
		local buflist_not_empty = #vim.tbl_filter(function(bufnr)
			return vim.bo[bufnr].buflisted
		end, vim.api.nvim_list_bufs()) > 1
		local buf_not_modifiable = not vim.o.modifiable

		if buf_not_modifiable or buf_not_empty or buflist_not_empty then
			return
		end
		for _, arg in pairs(vim.v.argv) do
			if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
				return
			end
		end

		require("alpha").start(true, require("alpha").default_config)
		vim.schedule(function()
			vim.cmd.doautocmd("FileType")
		end)
	end,
})

local ignore_filetypes = { "neo-tree" }
local ignore_buftypes = { "nofile", "prompt", "popup" }

local focusDisable = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

M.create("WinEnter", {
	group = focusDisable,
	callback = function(_)
		if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
			vim.w.focus_disable = true
		else
			vim.w.focus_disable = false
		end
	end,
	desc = "Disable focus autoresize for BufType",
})

M.create("FileType", {
	group = focusDisable,
	callback = function(_)
		if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
			vim.b.focus_disable = true
		else
			vim.b.focus_disable = false
		end
	end,
	desc = "Disable focus autoresize for FileType",
})

M.create("CmdlineLeave", {
	pattern = ":*",
	group = vim.api.nvim_create_augroup("AutoMarkOnJump", { clear = true }),
	callback = function()
		local cmd = vim.fn.getcmdline()
		if tonumber(cmd) ~= nil then
			vim.cmd("normal! m`")
		end
	end,
	desc = "Mark jump position after jump",
})

-- Highlight URLs in the buffer
vim.api.nvim_set_hl(0, "HighlightURL", { underline = true })
M.create({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
	desc = "URL Highlighting",
	callback = function()
		utils.set_url_effect()
	end,
})

M.create("BufWinEnter", {
	desc = "Make q close help, man, quickfix, dap floats",
	callback = function(args)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
		if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) then
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
		end
	end,
})
M.create("CmdwinEnter", {
	desc = "Make q close command history (q: and q?)",
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
	end,
})

require("aquila.core.commands.activation-window").setup(M)

return M

