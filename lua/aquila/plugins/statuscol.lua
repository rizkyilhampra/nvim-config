return {
    "luukvbaal/statuscol.nvim",
    event = "BufEnter",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            segments = {
                relculright = true,
                { sign = { namespace = { "diagnostic*" }, auto = true }, click = "v:lua.ScSa" },
                { sign = { namespace = { "gitsigns" }, auto = true, },   click = "v:lua.ScSa", },
                { text = { builtin.lnumfunc, " " },                      click = "v:lua.ScLa", },
                { text = { builtin.foldfunc, "  " },                     click = "v:lua.ScFa", },
            },
        })
    end,
}
