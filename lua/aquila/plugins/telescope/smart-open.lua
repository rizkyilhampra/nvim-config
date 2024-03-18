return {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    dependencies = {
        "kkharji/sqlite.lua",
    },
    enabled = false,
    keys = {
        {
            "<leader><space>",
            function()
                require('telescope').extensions.smart_open.smart_open(require('telescope.themes').get_dropdown({
                    -- winblend = 10,
                    cwd_only = true,
                    devicons_enabled = true,
                    initial_mode = 'normal',
                    match_algorithm = 'fzf',
                    -- filename_first = false,
                }))
            end,
            desc = "Find files in cwd"
        },
    },
    config = function()
        require('telescope').load_extension('smart_open')
    end
}