return {
    'gbprod/phpactor.nvim',
    opts = {
        install = {
            bin = vim.fn.stdpath('data') .. '/mason/bin/phpactor',
        },
        lspconfig = {
            enabled = false,
        },
    },
    cond = vim.fn.isdirectory("vendor") == 1,
    keys = {
        {
            '<Leader>Lp',
            "<cmd>lua require('phpactor').rpc()<CR>",
            desc = "Run PHPactor command"
        }
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
    },
}