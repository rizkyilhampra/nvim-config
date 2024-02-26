return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    enabled = false,
    config = function()
        require("catppuccin").setup({
            custom_highlights = function(color)
                return {
                    CursorLine = { bg = color.surface1 },
                    NeoTreeNormal = { bg = color.mantle },
                    NeoTreeNormalNC = { bg = color.base},
                }
            end,
            color_overrides = {
                mocha = {
                    rosewater = "#efc9c2",
                    flamingo = "#ebb2b2",
                    pink = "#f2a7de",
                    mauve = "#b889f4",
                    red = "#ea7183",
                    maroon = "#ea838c",
                    peach = "#f39967",
                    yellow = "#eaca89",
                    green = "#96d382",
                    teal = "#78cec1",
                    sky = "#91d7e3",
                    sapphire = "#68bae0",
                    blue = "#739df2",
                    lavender = "#a0a8f6",
                    text = "#b5c1f1",
                    subtext1 = "#a6b0d8",
                    subtext0 = "#959ec2",
                    overlay2 = "#848cad",
                    overlay1 = "#717997",
                    overlay0 = "#63677f",
                    surface2 = "#505469",
                    surface1 = "#3e4255",
                    surface0 = "#2c2f40",
                    base = "#1a1c2a",
                    mantle = "#141620",
                    crust = "#0e0f16",
                },
            },
            transparent_background = true,
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
                navic = { enabled = true },
                notify = true,
                neotree = true,
                telescope = {
                    enabled = true
                },
                treesitter = true,
                which_key = true,
                noice = true,
                lsp_trouble = true,
            },
        })
    end
}
