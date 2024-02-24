return {
    'nvimtools/none-ls.nvim',
    event = 'BufReadPre',
    enabled = false,
    config = function()
        local null_ls = require('null-ls')

        local sources = {
            null_ls.builtins.code_actions.eslint_d.with({
                condition = function(utils)
                    return utils.root_has_file('.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc')
                end
            }),
            null_ls.builtins.diagnostics.eslint_d.with({
                condition = function(utils)
                    return utils.root_has_file('.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc')
                end
            })
        }

        null_ls.setup({
            sources = sources,
        })
    end
}
