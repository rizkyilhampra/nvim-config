return {
    "folke/noice.nvim",
    event = "VeryLazy",
    cmd = "Noice",
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                max_width = math.floor(vim.o.columns * 0.4),
                render = "wrapped-compact",
                timeout = 200
            }
        },
        "hrsh7th/nvim-cmp"
    },
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
            hover = {
                enabled = true,
                view = "hover"
            },
            signature = {
                enabled = false
            },
            documentation = {
                enabled = true
            }
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = false,        -- use a classic bottom cmdline for search
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true,        -- add a border to hover docs and signature help
            command_palette = {
                views = {
                    -- hover = {
                    --     border = "rounded",
                    --     size = { max_width = 50 },
                    -- },
                    documentation = {
                        border = "rounded",
                    },
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
}