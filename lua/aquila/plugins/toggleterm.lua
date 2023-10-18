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
            vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n><C-w>q]], opts)
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

        local cwd_term  = Terminal:new({
            direction = "float",
            float_opts = {
                winblend = 10
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        local home_term = Terminal:new({
            direction = "float",
            dir = "~",
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        local lazygit   = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                height   = 33,
                width    = 200,
                winblend = 10
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("silent! :checktime")
            end,
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        function _cwd_term_toggle()
            cwd_term:toggle()
        end

        function _home_term_toggle()
            home_term:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>lua _lazygit_toggle()<CR>",
            { noremap = true, silent = true, desc = "Toggle terminal as Lazygit" })
        vim.keymap.set("n", "<Leader>tt", "<cmd> lua _cwd_term_toggle()<CR>",
            { desc = "Toggle terminal on cwd" })
        vim.keymap.set("n", "<Leader>tT", "<cmd> lua _home_term_toggle()<CR>",
            { desc = "Toggle terminal on ~ directory" })
    end
}
