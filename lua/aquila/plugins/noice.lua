return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                render = "wrapped-compact",
                timeout = 200
            }
        },
    },
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            -- override = {
            --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            --     ["vim.lsp.util.stylize_markdown"] = true,
            --     ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            -- },
            hover = {
                enabled = false
            },
            signature = {
                enabled = false
            },
            documentation = {
                enabled = false
            }
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = false,        -- use a classic bottom cmdline for search
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
            command_palette = {
                views = {
                    cmdline_popup = {
                        position = {
                            row = "50%",
                            col = "50%",
                        },
                        size = {
                            min_width = 60,
                            width = "auto",
                            height = "auto",
                        },
                    },
                    cmdline_popupmenu = {
                        position = {
                            row = "80%",
                            col = "50%",
                        },
                    },
                },
            },
        },
        views = {
            mini = {
                win_options = {
                    winblend = 0,
                },
            }
        },
        routes = {
            {
                filter = { event = "msg_show", kind = "search_count" },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show", kind = "", find = "written",
                },
                opts = { skip = true },
            },
            {
                view = "split",
                filter = { event = "msg_show", min_height = 20 },
            },
        },
    },
    init = function()
        require('lualine').setup({
            sections = {
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
                    -- {
                    --     require("noice").api.status.command.get,
                    --     cond = require("noice").api.status.command.has,
                    --     color = { fg = "#ff9e64" },
                    -- },
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
                },

            }
        })
    end
}