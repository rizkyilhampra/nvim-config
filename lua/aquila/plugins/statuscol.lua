return {
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                relculright = true,
                segments = {
                    {
                        text = { builtin.foldfunc },
                        click = "v:lua.ScFa",
                    },
                    {
                        text =  {
                            " ",
                        }
                    },
                    {
                        sign = {
                            name = {
                                "Diagnostic",
                            },
                            auto = true,
                        },
                        click = "v:lua.ScSa"
                    },
                    -- { text = { "%s" } ,  click = "v:lua.ScSa"         },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                },
            })
        end,
    },
}