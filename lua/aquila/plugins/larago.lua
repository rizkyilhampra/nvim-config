return {
    'ccaglak/larago.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    cond = function()
        return vim.fn.isdirectory("vendor") == 1
    end,
    lazy = true,
    keys = {
        {
            "<Leader>gg",
            "<cmd>GoBlade<CR>",
            desc = "Go to Blade file"
        }
    }
}