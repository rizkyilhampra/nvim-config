return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufWritePost" },
    enabled = false,
    init = function()
        local lint = require("lint")
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd(
            { "TextChanged", "TextChangedI", "BufEnter", "BufReadPre", "BufWritePost", "CursorHold", "CursorHoldI" },
            {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            }
        )
    end,
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            php = { "phpstan" },
            blade = { "phpstan" },
            lua = { "selene" }
        }
    end
}
