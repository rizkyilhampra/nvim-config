return {
    "mikavilpas/yazi.nvim",
    event = "User BaseDefered",
    enabled = false,
    keys = {
        {
            "<leader>-",
            function()
                require("yazi").yazi()
            end,
            desc = "Open the file manager",
        },
        {
            -- Open in the current working directory
            "<leader>C",
            function()
                require("yazi").yazi(nil, vim.fn.getcwd())
            end,
            desc = "Open the file manager in nvim's working directory",
        },
        {
            '<c-up>',
            function()
                require('yazi').toggle()
            end,
            desc = "Resume the last yazi session",
        },
    },
    opts = {
        open_for_directories = false,
        -- use_ya_for_events_reading = true,
        -- use_yazi_client_id_flag = true,
    },
}