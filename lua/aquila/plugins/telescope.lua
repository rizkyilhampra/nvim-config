return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
        { "nvim-telescope/telescope-file-browser.nvim" }
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
                        -- maybe we want to write something to the buffer here
                        print('hello')
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
                }
            }
        })


        require('telescope').load_extension('fzf')
        require('telescope').load_extension('file_browser')

        local keymap = vim.keymap

        keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "find files in cwd" })
        keymap.set('n', '<leader><space>', '<cmd>Telescope find_files<cr>', { desc = "find files in cwd" })
        keymap.set('n', '<leader>fa', '<cmd>Telescope find_files no_ignore=true hidden=true<CR>',
            { desc = "find all without respect anything" }
        )
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "List previously open files all dir" })
        keymap.set("n", "<leader><Tab>", "<cmd>lua require('telescope.builtin').oldfiles({cwd_only = true})<CR>", {
            desc = 'List previously open files on cwd only'
        })
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "find string in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "find string under cursor in cwd" })
        keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "list of buffers" })
        keymap.set("n", "<leader>r", "<cmd>Telescope registers<cr>", { desc = "List of registers" })

        -- extension file browser
        keymap.set("n", "<Leader>E", ":Telescope file_browser<CR>", { noremap = true, desc = "file browser on cwd" })
        keymap.set("n", "<Leader>e", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
            { noremap = true, desc = "file browser on current buffer path" })
    end
}
