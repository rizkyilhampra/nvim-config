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

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        print('Yeah, I guess it is.')
    end
})


vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank()
    end,
})
