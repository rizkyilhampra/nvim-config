return {
    "stevearc/conform.nvim",
    lazy = true,
    cmd = { "ConformInfo" },
    keys = {
        {
            "<Leader>af",
            function()
                require("conform").format({
                    async = true,
                    lsp_fallback = true
                })
            end,
            mode = "",
            desc = "Format buffer"
        }
    },
    opts = {
        formatters_by_ft = {
            php = { "pint" },
            css = { "prettierd" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            blade = { 'blade-formatter' },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}