return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = { --[[ things you want to change go here]] },
    event = "VeryLazy",
    config = function()
        local Terminal = require('toggleterm.terminal').Terminal

        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('n', 'q', '<cmd>close<CR>', opts)
            vim.keymap.set('t', '<Esc><Esc>', '<cmd>close<CR>', opts)
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

        local cwd_term  = Terminal:new({
            direction = "float",
            float_opts = {
                -- winblend = 10
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                -- vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', "<cmd>close<CR>",
                --     { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })
            end,
            -- function to run on closing the terminal
            on_close = function(term)
            end,
        })

        local home_term = Terminal:new({
            direction = "float",
            dir = "~",
            on_open = function(term)
                vim.cmd("startinsert!")
                -- vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })
            end,
            on_close = function(term)
            end,
        })

        local lazygit   = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                height = 50,
                width  = 150,
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
            on_close = function(term)
                require("neo-tree.sources.filesystem.commands")
                    .refresh(
                        require("neo-tree.sources.manager")
                        .get_state("filesystem")
                    )
                -- refresh current buffer
                vim.cmd("e")
            end,
        })

        vim.keymap.set("n", "<leader>tl", function()
            lazygit:toggle()
        end, { desc = "Toggle terminal as Lazygit" })

        vim.keymap.set("n", "<Leader>tt", function()
            cwd_term:toggle()
        end, { desc = "Toggle terminal on cwd" })

        vim.keymap.set("n", "<Leader>tT", function()
            home_term:toggle()
        end, { desc = "Toggle terminal on ~ directory" })
    end
}
