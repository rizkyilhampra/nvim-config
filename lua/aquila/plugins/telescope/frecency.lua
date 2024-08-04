return {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require("telescope").load_extension "frecency"

        vim.api.nvim_set_hl(0, "TelescopePathSeparator", {})
    end,
    keys = {
        {
            "<Leader><Space>",
            function()
                require('telescope').extensions.frecency.frecency(require('telescope.themes').get_dropdown({
                    workspace = "CWD",
                    devicons_enabled = true,
                    preview = {
                        filesize_limit = 0.1, -- MB
                    },
                    path_display = { filename_first = { reverse_directories = false } },
                    prompt_title = "Find Files"
                }))
            end,
            desc = "Find files with Frecency (fd)"
        },
    }
}