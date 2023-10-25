return {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        style = "moon",
        transparent = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent"
        },
        -- on_highlights = function(hl, c)
        --     hl.TelescopeNormal = {
        --         bg = c.bg_dark,
        --     }
        --     hl.WhichKeyFloat = {
        --         bg = c.bg_dark,
        --     }
        --     hl.ToggleTermFloat = {
        --         bg = c.bg_dark
        --     }
        -- end
    },
}
