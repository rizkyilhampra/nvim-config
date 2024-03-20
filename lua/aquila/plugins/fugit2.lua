return {
    'SuperBo/fugit2.nvim',
    lazy = true,
    opts = {},
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
        {
            'chrisgrieser/nvim-tinygit',
            dependencies = { 'stevearc/dressing.nvim' }
        }
    },
    cmd = { 'Fugit2', 'Fugit2Graph' },
    keys = {
        { '<leader>gff', mode = 'n', '<cmd>Fugit2<cr>',      desc = "Main" },
        { '<leader>gfg', mode = 'n', '<cmd>Fugit2Graph<cr>', desc = "Graph commit" }
    }
}