return {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    keys = {
        {
            "<Leader>ff",
            function()
                require('telescope').extensions.frecency.frecency(require('telescope.themes').get_dropdown({
                    workspace = "CWD",
                    devicons_enabled = true,
                    initial_mode = 'normal',
                    path_display = function(opts, path)
                        -- local current_cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
                        local relative_path = vim.fn.fnamemodify(path, ":~:.")
                        relative_path = require('aquila.core.commands').filenameFirst(opts, relative_path)
                        return relative_path
                    end
                }))
            end,
            desc = "Frecency find files"
        }
    },
    config = function()
        require('telescope').setup({
            extensions = {
                frecency = {
                    show_filter_column = false,
                }
            }
        })

        require("telescope").load_extension "frecency"

        vim.api.nvim_set_hl(0, "TelescopePathSeparator", {})
    end,
}