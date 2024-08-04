return {
    "isak102/telescope-git-file-history.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
        "tpope/vim-fugitive"
    },
    keys = {
        {
            "<Leader>fg",
            "<cmd>Telescope git_file_history<CR>",
            desc = "List of git file history"
        }
    },
    config = function()
        require('telescope').load_extension('git_file_history')
    end
}