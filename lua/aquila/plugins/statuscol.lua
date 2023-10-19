return {
    "luukvbaal/statuscol.nvim",
    event = "BufReadPre",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            segments = {
                relculright = true,
                { sign = { name = { "Diagnostic" }, auto = true },     click = "v:lua.ScSa" },
                { sign = { namespace = { "gitsigns" }, auto = true, }, click = "v:lua.ScSa", },
                { text = { builtin.lnumfunc, " " },                    click = "v:lua.ScLa", },
                { text = { builtin.foldfunc, " " },                    click = "v:lua.ScFa", },
            },
        })
    end,
}
