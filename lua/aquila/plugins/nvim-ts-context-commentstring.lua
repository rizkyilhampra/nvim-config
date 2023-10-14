return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    -- lazy = true,
    event = "BufRead",
    opts = {
        enable_autocmd = false
    }
}
