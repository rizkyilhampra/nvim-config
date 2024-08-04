return {
    'mollerhoj/telescope-recent-files.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    keys = {
        {
            "<Leader>f<Tab>",
            function()
                require('telescope').extensions['recent-files'].recent_files(require('telescope.themes').get_dropdown({
                    preview = {
                        filesize_limit = 0.1, -- MB
                    },
                    path_display = { filename_first = { reverse_directories = false } },
                }))
            end,
            desc = "List recently opened files but combine with files in current directory"
        },
    },
    config = function()
        require('telescope').load_extension('recent-files')
    end
}