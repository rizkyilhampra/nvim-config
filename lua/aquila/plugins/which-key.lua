return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
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