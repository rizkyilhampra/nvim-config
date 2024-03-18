return {
    'declancm/cinnamon.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require('cinnamon').setup({
            default_keymaps = true,
            extra_keymaps = true,
            override_keymaps = true,
            extended_keymaps = true,
            max_length = 50,
            centered = false,
            scroll_limit = -1
        })
        -- Horizontal screen scrolling:
        vim.keymap.set('n', 'zh', "<Cmd>lua Scroll('z15h')<CR>")
        vim.keymap.set('n', 'zl', "<Cmd>lua Scroll('z15l')<CR>")
    end
}