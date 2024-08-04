return {
    "debugloop/telescope-undo.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    keys = {
        {
            "<Leader>fu", "<cmd>Telescope undo<CR>", desc = "List of undos"
        }
    },
    config = function()
        require('telescope').load_extension('undo')
    end
}