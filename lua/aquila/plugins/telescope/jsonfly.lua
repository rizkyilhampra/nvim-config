return {
    "Myzel394/jsonfly.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    keys = function()
        require('telescope').load_extension('jsonfly')

        return {
            {
                "<Leader>fj",
                "<cmd>Telescope jsonfly<CR>",
                desc = "List of json files",
                ft = "json",
                mode = "n"
            }
        }
    end
}