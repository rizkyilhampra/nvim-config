return {
    "folke/noice.nvim",
    event = "User BaseDefered",
    cmd = "Noice",
    commit = "d9328ef903168b6f52385a751eb384ae7e906c6f",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<C-b>",
            function()
                if not require("noice.lsp").scroll(-4) then
                    return "<C-b>"
                end
            end,
            mode = { "n", "i", "s" },
            silent = true,
            expr = true,
        },
        {
            "<C-f>",
            function()
                if not require("noice.lsp").scroll(4) then
                    return "<C-f>"
                end
            end,
            mode = { "n", "i", "s" },
            silent = true,
            expr = true,
        },
    },
    opts = {
        popupmenu = {
            backend = "cmp",
        },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
            progress = {
                enabled = true,
            },
            hover = {
                enabled = true,
                opts = {
                    size = { max_width = 50 },
                },
            },
            signature = {
                enabled = false,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = false,        -- use a classic bottom cmdline for search
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true,        -- add a border to hover docs and signature help
            command_palette = {
                views = {
                    hover = {
                        size = {
                            max_height = 10,
                        },
                    },
                    cmdline_popup = {
                        position = {
                            row = "50%",
                            col = "50%",
                        },
                        -- size = {
                        --     min_width = 60,
                        --     width = "auto",
                        --     height = "auto",
                        -- },
                    },
                },
            },
        },
        views = {
            mini = {
                win_options = {
                    winblend = 0,
                },
            },
            confirm = {
                position = {
                    row = "50%",
                    col = "50%"
                }
            }
        },
        routes = {
            {
                filter = { event = "msg_show", kind = "search_count" },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
            {
                view = "split",
                filter = { event = "msg_show", min_height = 20 },
            },
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
            },
            { filter = { event = "msg_show", find = "^[/?]." },                            skip = true }, -- unneeded info on search patterns
            { filter = { event = "msg_show", find = "E211: File .* no longer available" }, skip = true },
        },
    },
    config = function(_, opts)
        require('noice').setup(opts)

        local mode_get_component = {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
        }

        local mode_search_component = {
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = "#ff9e64" },
        }

        local lualine_opts = require('aquila.core.utils').get_plugin_opts('lualine.nvim')

        table.insert(lualine_opts.sections.lualine_x, 1, mode_get_component)
        table.insert(lualine_opts.sections.lualine_x, 2, mode_search_component)
    end
}