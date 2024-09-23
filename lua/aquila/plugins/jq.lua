return {
    "cenk1cenk2/jq.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "grapp-dev/nui-components.nvim",
    },
    ft = "json",
    keys = {
        {
            "<Leader>fj",
            function()
                require("jq").run({
                    toggle = true,
                    commands = {
                        {
                            command = "jq",
                            filetype = "json",
                            arguments = "-r"
                        },
                    },
                    arguments = "",
                    query = ".",
                })
            end,
            desc = "JSON Query",
        }
    }
}