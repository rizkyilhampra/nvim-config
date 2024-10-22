local M = {}
local activation_window_augroup = vim.api.nvim_create_augroup("ActivationWindow", { clear = true })

local function create_activation_window()
	local buf = vim.api.nvim_create_buf(false, true)
	local namespace = vim.api.nvim_create_namespace("activation-window")

	local width = 34
	local height = 2
	local ui = vim.api.nvim_list_uis()[1]
	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		col = (ui.width - width) - 4,
		row = ui.height - height,
		anchor = "SW",
		style = "minimal",
		border = "none",
		zindex = 251,
		noautocmd = true,
		focusable = false,
	}
	local win = vim.api.nvim_open_win(buf, false, win_opts)

	vim.wo[win].winblend = 0
	vim.api.nvim_set_hl(namespace, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(namespace, "FloatBorder", { bg = "NONE" })

	local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
	vim.api.nvim_set_hl(namespace, "ActivationWindowTitle", { fg = comment_hl.fg, bold = true, italic = true })
	vim.api.nvim_win_set_hl_ns(win, namespace)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Activate Neovim", "Go to settings to activate Neovim." })
	vim.api.nvim_buf_add_highlight(buf, namespace, "ActivationWindowTitle", 0, 0, -1)
	vim.api.nvim_buf_add_highlight(buf, namespace, "Comment", 1, 0, -1)

	vim.bo[buf].bufhidden = "wipe"
end

local function close_activation_windows()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "nofile" then
			local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
			if #lines >= 2 and lines[1] == "Activate Neovim" and lines[2] == "Go to settings to activate Neovim." then
				vim.api.nvim_win_close(win, true)
			end
		end
	end
end

function M.setup(autocmd)
	autocmd.create("VimEnter", {
		group = activation_window_augroup,
		callback = function()
            create_activation_window()
		end,
	})

	autocmd.create("VimResized", {
		group = activation_window_augroup,
		callback = function()
			close_activation_windows()
			create_activation_window()
		end,
	})

	vim.api.nvim_create_user_command("ActivationWindowEnable", create_activation_window, {})
	vim.api.nvim_create_user_command("ActivationWindowDisable", close_activation_windows, {})
end

return M