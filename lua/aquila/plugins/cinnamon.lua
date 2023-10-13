return {
    'declancm/cinnamon.nvim',
    config = function()
        require('cinnamon').setup({
            default_keymaps = true,
            extra_keymaps = true,
            override_keymaps = true,
            extended_keymaps = true,
            max_length = 500,

        })
        -- Horizontal screen scrolling:
        vim.keymap.set('n', '<A-h>', "<Cmd>lua Scroll('z10h')<CR>")
        vim.keymap.set('n', '<A-l>', "<Cmd>lua Scroll('z10l')<CR>")
    end
}
