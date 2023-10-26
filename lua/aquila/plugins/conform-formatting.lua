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
            css = { "prettierd" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettier" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            blade = { 'blade-formatter' }
        },
        formatters = {
            my_blade = {
                command = "blade-formatter",
                args = { "--stdin=true", "--write", "$FILENAME" },
            }
        }
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
