return {
    'ccaglak/larago.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    cond = vim.fn.isdirectory("vendor") == 1,
    lazy = true,
    keys = {
        {
            "<Leader>LG",
            "<cmd>GoBlade<CR>",
            desc = "Go to Blade file"
        }
    }
}