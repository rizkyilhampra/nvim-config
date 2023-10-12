return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        -- Dont Preview binaries
        local previewers = require("telescope.previewers")
        local Job = require("plenary.job")
        local new_maker = function(filepath, bufnr, opts)
            filepath = vim.fn.expand(filepath)
            Job:new({
                command = "file",
                args = { "--mime-type", "-b", filepath },
                on_exit = function(j)
                    local mime_type = vim.split(j:result()[1], "/")[1]
                    if mime_type == "text" then
                        previewers.buffer_previewer_maker(filepath, bufnr, opts)
                    else
                        vim.schedule(function()
                            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                        end)
                    end
                end
            }):sync()
        end

        local actions = require("telescope.actions")
        require('telescope').setup({
            defaults = {
                buffer_previewer_maker = new_maker,
                mappings = {
                    n = {
                        ['q'] = actions.close
                    }
                },
            },
        })

        require('telescope').load_extension('fzf')

        function recent_files()
            require('telescope.builtin').oldfiles({
                cwd_only = true,
                initial_mode = 'normal',
                layout_strategy = 'vertical',
                layout_config = {
                    vertical = {
                        height = 0.8,
                        preview_cutoff = 1,
                        preview_height = 0.3
                    }
                }
            })
        end

        vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find files in cwd" })
        vim.keymap.set('n', '<leader><space>',
            "<cmd>lua require('telescope.builtin').find_files()<cr>",
            { desc = "Find files in cwd" })

        vim.keymap.set('n', '<leader>fa', '<cmd>Telescope find_files no_ignore=true hidden=true<CR>',
            { desc = "Find all without respect anything" }
        )
        vim.keymap.set("n", "<leader>fr", "<cmd>lua require('telescope.builtin').oldfiles({initial_mode = 'normal'})<cr>",
            { desc = "List previously open files all dir" })
        vim.keymap.set("n", "<leader><Tab>", '<cmd>lua recent_files()<cr>',
            { desc = 'List previously open files on cwd only' })

        vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
        vim.keymap.set("n", "<leader>bb", "<cmd>lua require('telescope.builtin').buffers({initial_mode = 'normal'})<cr>",
            { desc = "list of buffers" })

        vim.keymap.set('n', "<leader>flr",
            "<cmd> lua require('telescope.builtin').lsp_references({initial_mode = 'normal'})<CR> ", {
                desc = "List of references"
            })

        vim.keymap.set('n', "<leader>fls",
            "<cmd> lua require('telescope.builtin').lsp_document_symbols()<CR> ", {
                desc = "List of symbols"
            })
        -- vim.keymap.set('n', "<leader>flw",
        --     "<cmd> lua require('telescope.builtin').lsp_workspace_symbols({initial_mode = 'normal'})<CR> ", {
        --         desc = "List of workspace symbols"
        --     })
        vim.keymap.set('n', "<leader>flds",
            "<cmd> lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR> ", {
                desc = "List of dynamic workspace symbols"
            })
        vim.keymap.set('n', "<leader>fld",
            "<cmd> lua require('telescope.builtin').diagnostics({ bufnr = 0, initial_mode = 'normal' })<CR> ",
            { desc = "List of diagnostics document" })
        -- vim.keymap.set('n', "<leader>flii",
        --     "<cmd> lua require('telescope.builtin').lsp_implementations({initial_mode = 'normal'})<CR> ", {
        --         desc = "List of implementations"
        --     })
        -- vim.keymap.set('n', "<leader>fldD",
        --     "<cmd> lua require('telescope.builtin').lsp_type_definitions({initial_mode = 'normal'})<CR> ", {
        --         desc = "List of type definitions"
        --     })

        vim.keymap.set("n", "<leader>h", "<cmd> lua require('telescope.builtin').help_tags()<CR>",
            { desc = "List of help tags" })
    end
}
