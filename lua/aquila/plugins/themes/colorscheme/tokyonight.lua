return {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    enabled = function()
        return vim.g.aquila_theme == "tokyonight"
    end,
    opts = {
        style = "moon",
        transparent = true,
        styles = {
            -- sidebars = "transparent",
            floats = "transparent"
        },
        on_highlights = function(hl, c)
            if vim.g.aquila_theme_transparent_mode == false then
                hl.TelescopeNormal = {
                    bg = c.bg_dark,
                }
                hl.WhichKeyFloat = {
                    bg = c.bg_dark,
                }
                hl.ToggleTermFloat = {
                    bg = c.bg_dark
                }
            end
        end
    },

    config = function(_, opts)
        require('tokyonight').setup(opts)

        vim.cmd [[colorscheme tokyonight]]
    end
}
