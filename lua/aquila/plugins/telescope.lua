return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    event = "VeryLazy",
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

        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local themes = require('telescope.themes')
        local builtin = require('telescope.builtin')

        telescope.load_extension("smart_open")

        telescope.setup({
            defaults = {
                buffer_previewer_maker = new_maker,
                mappings = {
                    n = {
                        ['q'] = actions.close
                    }
                },
            },
        })


        -- function AquilaRecentFiles()
        --     -- require('telescope.builtin').oldfiles({
        --     --     cwd_only = true,
        --     --     initial_mode = 'normal',
        --     --     layout_strategy = 'vertical',
        --     --     layout_corfig = {
        --     --         vertical = {
        --     --             height = 0.8,
        --     --             preview_cutoff = 1,
        --     --             preview_height = 0.3
        --     --         }
        --     --     }
        --     -- })
        --     local builtin = require('telescope.builtin')
        --     local themes = require('telescope.themes')
        --     local opts = themes.get_dropdown({
        --         winblend = 10,
        --         previewer = false,
        --         initial_mode = 'normal',
        --         cwd_only = true,
        --     })
        --
        --     builtin.oldfiles(opts)
        -- end
        --
        -- function AquilaFindFilesCommon()
        --     local builtin = require('telescope.builtin')
        --     local opts = {
        --         winblend = 10,
        --         layout_strategy = 'center',
        --         layout_config = {
        --             center = {
        --                 preview_cutoff = 1,
        --             }
        --         }
        --     }
        --
        --     builtin.find_files(opts)
        -- end

        -- vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find files in cwd" })
        -- vim.keymap.set('n', '<leader><Space>',
        --     "<cmd>lua AquilaFindFilesCommon()<cr>",
        --     { desc = "Find files in cwd" })
        vim.keymap.set('n', '<leader>fa', function()
            builtin.find_files({
                no_ignore = true,
                hidden = true,
            })
        end, { desc = "Find all without respect anything" })

        vim.keymap.set("n", "<leader>fr", function()
                builtin.oldfiles({ initial_mode = 'normal' })
            end,
            { desc = "List previously open files all dir" })

        -- vim.keymap.set("n", "<leader><Tab>", function()
        --         builtin.oldfiles(themes.get_dropdown({
        --             winblend = 10,
        --             previewer = false,
        --             initial_mode = 'normal',
        --             cwd_only = true,
        --         }))
        --     end,
        --     { desc = 'List previously open files on cwd' })

        vim.keymap.set("n", "<leader>fs", function()
            builtin.live_grep()
        end, { desc = "Find string in cwd" })

        vim.keymap.set("n", "<leader>fc", function()
            builtin.grep_string()
        end, { desc = "Find string under cursor in cwd" })

        vim.keymap.set("n", "<leader>bb", function()
                builtin.buffers({ initial_mode = 'normal' })
            end,
            { desc = "list of buffers" })

        vim.keymap.set('n', "<leader>flr",
            function()
                builtin.lsp_references({ initial_mode = 'normal' })
            end, {
                desc = "List of references"
            })

        vim.keymap.set('n', "<leader>fls",
            function()
                builtin.lsp_document_symbols()
            end, {
                desc = "List of symbols"
            })
        -- vim.keymap.set('n', "<leader>flw",
        --     "<cmd> lua require('telescope.builtin').lsp_workspace_symbols({initial_mode = 'normal'})<CR> ", {
        --         desc = "List of workspace symbols"
        --     })
        vim.keymap.set('n', "<leader>flS",
            function()
                builtin.lsp_dynamic_workspace_symbols()
            end, {
                desc = "List of dynamic workspace symbols"
            })
        vim.keymap.set('n', "<leader>fld",
            function()
                builtin.diagnostics({ bufnr = 0, initial_mode = 'normal' })
            end,
            { desc = "List of diagnostics document" })

        -- vim.keymap.set('n', "<leader>flii",
        --     "<cmd> lua require('telescope.builtin').lsp_implementations({initial_mode = 'normal'})<CR> ", {
        --         desc = "List of implementations"
        --     })
        -- vim.keymap.set('n', "<leader>fldD",
        --     "<cmd> lua require('telescope.builtin').lsp_type_definitions({initial_mode = 'normal'})<CR> ", {
        --         desc = "List of type definitions"
        --     })

        vim.keymap.set("n", "<leader>fh", function()
                builtin.help_tags()
            end,
            { desc = "List of help tags" })

        vim.keymap.set('n', "<Leader>r", function()
            builtin.resume()
        end, { desc = "Resume last telescope" })
    end
}
