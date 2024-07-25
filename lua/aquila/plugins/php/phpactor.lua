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
    cond = function()
        return vim.fn.isdirectory("vendor") == 1
    end,
    enabled = false
}