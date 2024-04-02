return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        "folke/noice.nvim",
    },
    event = "VeryLazy",
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.o.statusline = " "
        else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        vim.o.laststatus = vim.g.lualine_laststatus

        return {
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
                    {
                        'mode',
                        fmt = function()
                            return ''
                        end,
                    },
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