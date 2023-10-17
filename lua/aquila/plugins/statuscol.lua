return {
    "luukvbaal/statuscol.nvim",
    event = "BufReadPre",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            segments = {
                relculright = true,
                {
                    -- Git-colored bar
                    sign = {
                        namespace = { "gitsigns" },
                        auto = true
                    },
                    click = "v:lua.ScSa",
                },
                {
                    sign = { name = { "Diagnostic" }, auto = true },
                    click = "v:lua.ScSa"
                },
                {
                    text = { builtin.foldfunc, " " },
                    click = "v:lua.ScFa",
                },
                {
                    text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa",
                },
            },
        })
    end,
}
