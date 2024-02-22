local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

-- remember folds
-- vim.cmd [[
-- augroup remember_folds
--   autocmd!
--   autocmd BufWinLeave *.* mkview
--   autocmd BufWinEnter *.* silent! loadview
-- augroup END
-- ]]

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function()
--         if vim.opt.foldmethod:get() == "expr" then
--             vim.schedule(function()
--                 vim.opt.foldmethod = "expr"
--             end)
--         end
--     end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
    desc = "Disable New Line Comment",
})

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
    desc = "Restore cursor position",
})

vim.api.nvim_create_autocmd("BufReadPost", {
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

--automatically save the current buffer (file) under certain conditions.
-- require('aquila.core.autocommands.auto-save')
