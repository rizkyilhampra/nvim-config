return {
    'mollerhoj/telescope-recent-files.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    keys = {
        {
            "<Leader><Space>",
            function()
                require('telescope').extensions['recent-files'].recent_files(require('telescope.themes').get_dropdown({
                    initial_mode = 'normal',
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    path_display = require('aquila.core.commands').filenameFirst,
                }))
            end,
            desc = "List recently opened files"
        },
    },
    config = function()
        require('telescope').load_extension('recent-files')
    end
}