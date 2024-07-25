local mode_map = {
    n = "(ᴗ_ ᴗ。)",
    nt = "(ᴗ_ ᴗ。)",
    i = "(•̀ - •́ )",
    R = "( •̯́ ₃ •̯̀)",
    v = "(⊙ _ ⊙ )",
    V = "(⊙ _ ⊙ )",
    no = "Σ(°△°ꪱꪱꪱ)",
    ["\22"] = "(⊙ _ ⊙ )",
    t = "(⌐■_■)",
    ['!'] = "Σ(°△°ꪱꪱꪱ)",
    c = "Σ(°△°ꪱꪱꪱ)",
    s = "SUB"
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        "folke/noice.nvim",
    },
    event = "User BaseDefered",
    opts = function()
        return {
            options = {
                disabled_filetypes = {
                    statusline = {
                        "alpha",
                        "neo-tree",
                        "neo-tree-popup",
                        "TelescopePrompt",
                        "toggleterm",
                        "minimap"
                    },
                },
                component_separators = '|',
                section_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        icons_enabled = true,
                        separator = {
                            right = ""
                        },
                        fmt = function()
                            return mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
                        end
                    },
                },
                lualine_b = { { 'branch', icon = ' ' } },
                lualine_c = {
                    {
                        'diff',
                        symbols = require('aquila.core.global').icons.git,
                    },
                    'diagnostics'
                },

                lualine_x = {
                    {
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        require("noice").api.status.search.get,
                        cond = require("noice").api.status.search.has,
                        color = { fg = "#ff9e64" },
                    },
                    'filetype',
                    {
                        'o:encoding',
                        fmt = string.upper,
                    },
                    {
                        'fileformat',
                        symbols = {
                            unix = 'LF',
                            dos = 'CRLF',
                            mac = 'CR',
                        },
                        fmt = string.upper,
                    },
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        }
    end
}