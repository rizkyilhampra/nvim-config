return {
    'ccaglak/larago.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    enabled = false,
    ft = "blade",
    keys = {
        {
            "<Leader>b",
            "<cmd>GoBlade<CR>",
            desc = "Go to blade component file",
        }
    }
}