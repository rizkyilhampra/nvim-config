return {
    "mfussenegger/nvim-lint",
    enabled = false,
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = require('aquila.core.global').event.LazyFile,
    config = function()
        require("lint").linters_by_ft = {
            php = { "phpstan" },
            lua = { "selene" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" }
        }

        vim.api.nvim_create_autocmd(
            {
                "TextChanged",
                "TextChangedI",
                "BufReadPre",
            },
            {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function()
                    require('lint').try_lint()
                end,
            }
        )
    end
}