return {
    'nvimtools/none-ls.nvim',
    event = {
        "BufReadPre",
        "BufWritePost"
    },
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require('null-ls')

        local sources = {
            require("none-ls.diagnostics.eslint").with({
                name = "eslint_d",
                meta = {
                    url = "https://github.com/mantoni/eslint_d.js/",
                    description = "Like ESLint, but faster.",
                    notes = {
                        "Once spawned, the server will continue to run in the background. This is normal and not related to null-ls. You can stop it by running `eslint_d stop` from the command line.",
                    },
                },
                command = "eslint_d",
            }),
            null_ls.builtins.diagnostics.selene,
            null_ls.builtins.diagnostics.phpstan,
        }

        null_ls.setup({
            sources = sources,
        })
    end
}
