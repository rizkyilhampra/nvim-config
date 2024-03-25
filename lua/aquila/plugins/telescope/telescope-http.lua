return {
    'barrett-ruth/telescope-http.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    keys = {
        {
            '<leader>fH', '<cmd>Telescope http list<CR>', desc = "List of http requests"
        }
    },
    config = function()
        require('telescope').load_extension('http')
    end
}