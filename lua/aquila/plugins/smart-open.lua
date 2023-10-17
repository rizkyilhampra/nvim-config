return {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    event = "VeryLazy",
    dependencies = {
        "kkharji/sqlite.lua",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        local telescope = require('telescope')
        local themes = require('telescope.themes')

        telescope.load_extension("smart_open")

        vim.keymap.set("n", "<leader><space>", function()
            telescope.extensions.smart_open.smart_open(themes.get_dropdown({
                winblend = 10,
                cwd_only = true,
                devicons_enabled = true,
                initial_mode = 'normal',
                match_algorithm = 'fzf',
            }))
        end, { noremap = true, silent = true })
    end
}
