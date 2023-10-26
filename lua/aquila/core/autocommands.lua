local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

-- remember folds
vim.cmd [[
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END
]]

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
