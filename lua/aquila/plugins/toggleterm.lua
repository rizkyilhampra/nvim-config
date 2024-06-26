function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('n', 'q', '<cmd>close<CR>', opts)
    vim.keymap.set('t', '<Esc><Esc>', '<cmd>close<CR>', opts)
    vim.keymap.set("n", "<C-t>", '<cmd>exe v:count1 . "ToggleTerm"<CR>',
        opts)
end

return {
    'akinsho/toggleterm.nvim',
    version = "*",
    lazy = true,
    opts = {
        highlights = {
            FloatBorder = {
                link = "FloatBorder"
            }
        },
    },
    keys = function()
        local Terminal        = require('toggleterm.terminal').Terminal

        local escape_keymap   = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })
        end

        local close_keymap    = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })
        end

        local cwd_term        = Terminal:new({
            direction = "float",
            float_opts = {
                border = "rounded",
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                escape_keymap(term)
            end,
        })

        local horizontal_term = Terminal:new({
            direction = "horizontal",
            on_open = function(term)
                vim.cmd("startinsert!")
                escape_keymap(term)
                vim.opt_local.spell = false
            end,
        })

        local lazydocker      = Terminal:new({
            cmd = "lazydocker",
            direction = "float",
            float_opts = {
                height = 50,
                width  = 150,
                border = 'rounded'
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                close_keymap(term)
            end,
        })

        local lazysql         = Terminal:new({
            cmd = "lazysql",
            direction = "float",
            float_opts = {
                height = 50,
                width  = 150,
                border = 'rounded'
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                close_keymap(term)
            end,
        })

        local lazygit         = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                height = 50,
                width  = 150,
                border = "rounded",
            },
            on_open = function(term)
                vim.cmd("startinsert!")
            end,
            on_close = function()
                -- refresh current buffer
                vim.api.nvim_command('checktime')

                -- refresh neo-tree if it's open
                local manager = require("neo-tree.sources.manager")
                local renderer = require("neo-tree.ui.renderer")
                local state = manager.get_state("filesystem")
                local window_exists = renderer.window_exists(state)
                if window_exists then
                    vim.cmd [[ lua require("neo-tree.sources.filesystem.commands").refresh(require("neo-tree.sources.manager").get_state("filesystem"))]]
                end
            end,
        })

        return {
            {
                "<leader>tl",
                function()
                    lazygit:toggle()
                end,
                desc = "Toggle terminal as Lazygit"
            }, {
            "<Leader>tt",
            function()
                cwd_term:toggle()
            end,
            desc = "Toggle terminal on cwd with floating"
        },
            {
                "<Leader>tv",
                function()
                    horizontal_term:toggle()
                end,
                desc = "Toggle terminal on cwd with vertical"
            },
            {
                "<Leader>ts",
                function()
                    lazysql:toggle()
                end,
                desc = "Toggle terminal as Lazysql"
            },
            {
                "<Leader>td",
                function()
                    lazydocker:toggle()
                end,
                desc = "Toggle terminal as Lazydocker"
            }
        }
    end,
    config = function(_, opts)
        require('toggleterm').setup(opts)

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end
}