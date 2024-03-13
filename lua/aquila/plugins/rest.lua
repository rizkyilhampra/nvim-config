return {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = 'http',
    config = function()
        require("rest-nvim").setup({
            result_split_horizontal = false,
            result_split_vertical = true,
            skip_ssl_verification = true,
            result = {
                formatters = {
                    json = function(body)
                        return vim.fn.system({ "jq", "." }, body)
                    end,
                    html = function(body)
                        return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
                    end,
                },
            },
            highlight = {
                enabled = true,
                timeout = 150,
            },
            jump_to_request = false,
        })

        vim.keymap.set('n', '<leader>rr', '<Plug>RestNvim', {
            desc = "Run the request under the cursor"
        })
        vim.keymap.set('n', '<leader>rp', '<Plug>RestNvimPreview', {
            desc = "Preview the request under the cursor"
        })
        vim.keymap.set('n', '<Leader>rl', '<Plug>RestNvimLast', {
            desc = "Run the last request"
        })
    end
}
