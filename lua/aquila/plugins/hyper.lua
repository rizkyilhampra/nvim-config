return {
    'wet-sandwich/hyper.nvim',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>H', "lua require('hyper.view').show", description = 'Show Hyper' },
    }
}
