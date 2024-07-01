return {
    "tadmccorkle/markdown.nvim",
    ft = "markdown",
    opts = {
        on_attach = function(bufnr)
            local map = vim.keymap.set
            local opts = { buffer = bufnr }

            map('n', '<M-c>', '<Cmd>MDTaskToggle<CR>', opts)
            map('x', '<M-c>', ':MDTaskToggle<CR>', opts)
        end,
    },
}