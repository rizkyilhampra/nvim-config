return {
    'rmagatti/goto-preview',
    enabled = false,
    event = 'BufRead',
    config = function()
        require('goto-preview').setup({
            width = 80,
            post_open_hook = function()
                vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>lua require("goto-preview").close_all_win()<CR>',
                    { noremap = true, silent = true })
                -- set wrap!
                vim.api.nvim_win_set_option(0, 'wrap', true)
            end
        })

        vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
        vim.keymap.set("n", "<Esc>", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true })
    end
}
