return {
    "rebelot/kanagawa.nvim",
    enabled = false,
    config = function()
        require("kanagawa").setup({
            transparent = vim.g.aquila_theme_transparent_mode,
        })

        vim.cmd [[colorscheme kanagawa]]
    end
}
