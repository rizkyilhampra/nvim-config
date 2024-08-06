return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    ft = 'markdown',
    enabled = vim.g.markdown_render == 'render-markdown',
    opts = {}
}