return {
    'SuperBo/fugit2.nvim',
    opts = {
        width = 70,
        height = "80%",
        external_diffview = false,
    },
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
        {
            'chrisgrieser/nvim-tinygit',
            dependencies = { 'stevearc/dressing.nvim' }
        },
        {
            'sindrets/diffview.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            cmd = {
                'DiffviewFileHistory',
                'DiffviewOpen',
                'DiffviewToggleFiles',
                'DiffviewFocusFiles',
                'DiffviewRefresh'
            }
        }
    },
    cmd = { 'Fugit2', 'Fugit2Blame', 'Fugit2Diff', 'Fugit2Graph' },
}