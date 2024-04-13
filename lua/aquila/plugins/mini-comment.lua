return {
    'echasnovski/mini.comment',
    version = false,
    enabled = false,
    event = "BufReadPost",
    opts = {
        options = {
            custom_commentstring = function()
                return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
            end,
        },
        hooks = {
            pre = function()
                local line = vim.api.nvim_win_get_cursor(0)[1]
                local first_line_of_foldlevel = vim.fn.foldclosedend(line)
                local buf = vim.api.nvim_get_current_buf()

                if first_line_of_foldlevel ~= -1 then
                    vim.api.nvim_buf_set_mark(buf, "f", first_line_of_foldlevel, line, {})
                end
            end,
            post = function()
                local line = vim.api.nvim_win_get_cursor(0)[1]
                local buf = vim.api.nvim_get_current_buf()
                local mark = vim.api.nvim_buf_get_mark(buf, "f")

                -- Baris tersebut adalah baris pertama dari foldlevel
                if line == mark[2] then
                    vim.cmd("call feedkeys('za')")
                end
            end,
        }
    }
}