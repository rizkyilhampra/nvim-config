return {
    "adalessa/laravel.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "nvimtools/none-ls.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
        {
            "<leader>Lla",
            ":Laravel artisan<cr>",
            desc = "List all artisan commands"

        },
        {
            "<leader>Llr",
            ":Laravel routes<cr>",
            desc = "List all routes"
        },
        {
            "<leader>Llm",
            ":Laravel related<cr>",
            desc = "List all related files"

        },
    },
    config = true,
    cond = vim.fn.isdirectory("vendor") == 1,
    lazy = true,
}