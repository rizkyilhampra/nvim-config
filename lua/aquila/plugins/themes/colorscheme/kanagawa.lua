return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    enabled = function()
        return vim.g.aquila_theme == "kanagawa"
    end,
    config = function()
        require("kanagawa").setup({
            transparent = vim.g.aquila_theme_transparent_mode,
        })

        vim.cmd [[colorscheme kanagawa]]
    end
}
