return {
    'nvimtools/none-ls.nvim',
    event = 'BufReadPre',
    config = function()
        local null_ls = require('null-ls')

        local sources = {
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.diagnostics.eslint_d
        }

        null_ls.setup({
            sources = sources,
        })
    end
}
