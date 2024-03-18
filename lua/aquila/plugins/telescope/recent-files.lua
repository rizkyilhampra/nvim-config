return {
    'mollerhoj/telescope-recent-files.nvim',
    keys = {
        {
            "<Leader><Space>",
            function()
                require('telescope').extensions['recent-files'].recent_files(require('telescope.themes').get_dropdown({
                    initial_mode = 'normal',
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    path_display = require('aquila.core.commands').filenameFirst,
                    layout_config = {
                        width = 0.5,
                    }
                }))
            end,
            desc = "List recently opened files"
        },
    },
    config = function()
        require('telescope').load_extension('recent-files')
    end
}