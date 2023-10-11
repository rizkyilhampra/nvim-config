return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
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
            lua = { "lua_ls" },
            css = { "prettier" },
            javascript = { "prettier" },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function(_, opts)
        require("conform").setup(opts)
    end
}
