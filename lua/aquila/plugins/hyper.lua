return {
    'wet-sandwich/hyper.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Hyper",
    keys = {
        { '<leader>H', "<cmd>Hyper<CR>", desc = 'Show Hyper' },
    }
}