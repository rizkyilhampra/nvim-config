return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = function()
        return vim.g.aquila_theme == "catppuccin"
    end,
    config = function()
        require("catppuccin").setup({
            transparent_background = vim.g.aquila_theme_transparent_mode or false,
            custom_highlights = function(colors)
                return {
                    -- NormalFloat = { bg = colors.base },
                    -- PMenu = { bg = colors.base },
                }
            end,
            integrations = {
                alpha = true,
                cmp = true,
                gitsigns = true,
                indent_blankline = { enabled = true },
                mason = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                notify = true,
                neotree = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
        })

        vim.cmd([[colorscheme catppuccin]])
    end
}
