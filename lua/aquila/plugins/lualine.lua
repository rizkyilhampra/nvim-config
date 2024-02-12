return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "UIEnter",
    enabled = true,
    opts = {
        options = {
            globalstatus = true,
            disabled_filetypes = {
                statusline = {
                    "alpha",
                    "neo-tree",
                    "TelescopePrompt",
                    "toggleterm",
                    "neo-tree-popup"
                }
            },
            component_separators = '|',
            -- section_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { 'filename' },
            lualine_b = { 'branch' },
            lualine_c = { 'diagnostics' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
    },
}
