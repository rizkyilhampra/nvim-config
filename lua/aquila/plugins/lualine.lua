return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        "folke/noice.nvim",
    },
    event = "BufReadPre",
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
                { 'grapple' },
                {
                    'diff',
                    symbols = require('aquila.core.global').icons.git,
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
                },
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
    },
    config = function(_, opts)
        local noice_lualine_sections = {
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
        }

        -- merge into lualine sections
        for _, section in ipairs(noice_lualine_sections) do
            --put at the index 1
            table.insert(opts.sections.lualine_x, 1, section)
        end

        require('lualine').setup(opts)
    end
}