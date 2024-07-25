return {
    "adalessa/laravel.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "nvimtools/none-ls.nvim",
    },
    opts = {
        features = {
            null_ls = {
                enable = false,
            }
        }
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    cond = function()
        return vim.fn.isdirectory("vendor") == 1
    end,
    keys = {
        {
            "<leader>Lla",
            "<cmd>Laravel artisan<cr>",
            desc = "List all artisan commands"

        },
        {
            "<leader>Llr",
            "<cmd>Laravel routes<cr>",
            desc = "List all routes"
        },
        {
            "<leader>Llm",
            "<cmd>Laravel related<cr>",
            desc = "List all related files"

        },
    },
}