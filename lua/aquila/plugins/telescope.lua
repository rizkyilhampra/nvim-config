return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        require('telescope').setup()
        require('telescope').load_extension('fzf')

        local keymap = vim.keymap

        -- keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "find files in cwd" })
        keymap.set('n', '<leader>fa', '<cmd>Telescope find_files no_ignore=true hidden=true<CR>',
            { desc = "find all without respect anything" }
        )
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "find recent files" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "find string in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "find string under cursor in cwd" })
        keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "list of buffers" })
    end
}
