return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                php = { "intelephense" },
                lua = { "lua_ls" }
            },
            -- format_on_save = {
            -- lsp_fallback = true,
            -- async = false,
            -- timeout_ms = 1000,
            -- },
        })

        vim.keymap.set({ "n", "v" }, "<Leader>af", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end)
    end,
}
