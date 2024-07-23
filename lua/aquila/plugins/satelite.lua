return {
    "lewis6991/satellite.nvim",
    event = "User BaseFile",
    enabled = true,
    opts = {
        current_only = false,
        winblend = 0,
        zindex = 40,
        excluded_filetypes = {
            "",
            "prompt",
            "TelescopePrompt",
            "noice",
            "neo-tree", -- TODO: remove this after know how neo-tree setup for handle spacing icon and scrollbar
        },
        width = 2,
        handlers = {
            cursor = {
                enable = false,
            },
            search = {
                enable = true,
            },
            diagnostic = {
                enable = true,
                signs = { "-", "=", "≡" },
            },
            gitsigns = {
                enable = true,
                signs = { -- can only be a single character (multibyte is okay)
                    add = "│",
                    change = "│",
                    delete = "-",
                },
            },
            marks = {
                enable = true,
                show_builtins = true, -- shows the builtin marks like [ ] < >
            },
        },
    },
}