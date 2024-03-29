return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = "moon",
        transparent = true,
        styles = {
            -- sidebars = "transparent",
            floats = "transparent"
        },
        terminal_colors = false,
        on_highlights = function(hl, c)
            if vim.g.aquila_theme_transparent_mode == false then
                hl.TelescopeNormal = {
                    bg = c.bg_dark,
                }
                hl.WhichKeyFloat = {
                    bg = c.bg_dark,
                }
            end
        end
    },

    config = function(_, opts)
        require('tokyonight').setup(opts)

        vim.cmd [[colorscheme tokyonight]]
    end
}
