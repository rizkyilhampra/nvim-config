return {
    "adalessa/laravel.nvim",
    dependencies = {
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "kevinhwang91/promise-async",
    },
    cmd = { "Laravel" },
    keys = {
        { "<leader>Lla", ":Laravel artisan<cr>", desc = "List all artisan commands" },
        { "<leader>Llr", ":Laravel routes<cr>",  desc = "List all routes" },
        { "<leader>Llm", ":Laravel related<cr>", desc = "List all related files" },
    },
    cond = vim.fn.isdirectory("vendor") == 1,
    opts = {},
    config = true,
}