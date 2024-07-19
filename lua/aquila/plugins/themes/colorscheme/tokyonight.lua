return {
    "folke/tokyonight.nvim",
    event = "User LoadColorSchemes",
    enabled = true,
    opts = {
        style = "moon",
        transparent = true,
        styles = {
            -- sidebars = "transparent",
            floats = "transparent"
        },
        terminal_colors = false,
        -- on_highlights = function(hl, C)
        --     hl.NormalMoody = { fg = C.blue }
        --     hl.InsertMoody = { fg = C.green }
        --     hl.VisualMoody = { fg = C.orange }
        --     hl.SelectMoody = { fg = C.orange }
        --     hl.CommandMoody = { fg = C.cyan }
        --     hl.ReplaceMoody = { fg = C.red }
        --     hl.TerminalMoody = { fg = C.purple }
        --     hl.TerminalNormalMoody = { fg = C.teal }
        -- end
    },
}