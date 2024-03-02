return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "UIEnter",
    enabled = true,
    opts = {
        options = {
            disabled_filetypes = {
                statusline = {
                    "alpha",
                    "neo-tree",
                    "neo-tree-popup",
                    "TelescopePrompt",
                    "toggleterm",
                },
            },
            component_separators = '|',
            section_separators = { left = '', right = '' },
            -- section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                { 'mode', icon = ' ' },
            },
            lualine_b = { { 'branch', icon = ' ' } },
            lualine_c = {
                {
                    'diff',
                    symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
                },
                'diagnostics'
            },
            lualine_x = {
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
                }
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
    },
}
