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
            dependencies = {
                'stevearc/dressing.nvim',
                "nvim-telescope/telescope.nvim",
                "rcarriga/nvim-notify",
            },
            keys = {
                {
                    "<Leader>gi",
                    "<cmd>lua require('tinygit').interactiveStaging()<CR>",
                    desc = "Interactive Staging"
                },
                {
                    "<Leader>gc",
                    "<cmd>lua require('tinygit').smartCommit({pushIfClean = true})<CR>",
                    desc = "Smart Commit"
                }
            }
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
    keys = {
        {
            "<Leader>gff",
            "<cmd>Fugit2<CR>",
            desc = "Fugit2"
        }
    }
}