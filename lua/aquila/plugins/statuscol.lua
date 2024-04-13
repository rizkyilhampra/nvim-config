return {
    "luukvbaal/statuscol.nvim",
    event = "VimEnter",
    opts = function()
        local builtin = require("statuscol.builtin")
        return {
            bt_ignore = { "nofile", "prompt" },
            ft_ignore = { "alpha" },
            segments = {
                relculright = true,
                { sign = { namespace = { "diagnostic*" }, auto = true }, click = "v:lua.ScSa" },
                { sign = { namespace = { "gitsigns" }, auto = true, },   click = "v:lua.ScSa", },
                { text = { builtin.lnumfunc, " " },                      click = "v:lua.ScLa", },
                { text = { builtin.foldfunc, "  " },                     click = "v:lua.ScFa", },
            },
        }
    end
}