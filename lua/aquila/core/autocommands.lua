local M = {}

-- A function to create a function that creates autocmds for an augroup
function M.create_wrapper(augroup_name)
    local augroup = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    return function(event, opts)
        opts.group = opts.group or augroup
        return vim.api.nvim_create_autocmd(event, opts)
    end, augroup
end

M.create, M.aquila_augroup = M.create_wrapper('aquila')

M.create({ "BufWinLeave" }, {
    pattern = "*.*",
    desc = "Remember folds",
    callback = function()
        vim.cmd("mkview")
    end,
})

M.create({ "BufWinEnter" }, {
    pattern = "*.*",
    desc = "Restore folds",
    callback = function()
        vim.cmd("silent! loadview")
    end,
})

M.create("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = "Highlight yank",
})

M.create("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
    desc = "Disable New Line Comment",
})

-- Replace by Grapple.nvim plugin
-- M.create("BufReadPost", {
--     callback = function()
--         local mark = vim.api.nvim_buf_get_mark(0, '"')
--         if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
--             vim.api.nvim_win_set_cursor(0, mark)
--         end
--     end,
--     desc = "Restore cursor position",
-- })

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

M.create('User', {
    once = true,
    pattern = 'AlphaReady',
    desc = 'hide cursor for alpha',
    callback = function()
        local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
        hl.blend = 100
        vim.api.nvim_set_hl(0, 'Cursor', hl)
        vim.opt.guicursor:append('a:Cursor/lCursor')
    end,
})

M.create('BufNew', {
    once = true,
    desc = 'show cursor after alpha',
    callback = function(event)
        local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
        hl.blend = 0
        vim.api.nvim_set_hl(0, 'Cursor', hl)
        vim.opt.guicursor:remove('a:Cursor/lCursor')
    end,
})

M.create("FileType", {
    pattern = "TelescopeResults",
    callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
        end)
    end,
})

-- i'm not sure with this but i think it will be useful
-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function()
--         if vim.opt.foldmethod:get() == "expr" then
--             vim.schedule(function()
--                 vim.opt.foldmethod = "expr"
--             end)
--         end
--     end,
-- })

return M