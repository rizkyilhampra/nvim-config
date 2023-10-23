return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        require('which-key').register({
            f = {
                name = "+Fuzzy Find",
                l = "LSP"
            },
            t = { name = "+Terminal" },
            x = { name = "+Diagnostic" },
            a = { name = "+Auto" },
            c = {
                name = "+Code",
                a = "Actions"
            },
            g = {
                name = "+Git",
                h = "+Actions",
                t = "+Text Object"
            },
        }, {
            prefix = "<Leader>",
        })
    end
}
