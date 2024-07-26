return {
    "Isrothy/neominimap.nvim",
    lazy = false,
    init = function()
        vim.g.neominimap = {
            diagnostic = {
                enabled = false
            },
            auto_enable = true,
            z_index = 21,
            buf_filter = function(bufnr)
                local line_count = vim.api.nvim_buf_line_count(bufnr)
                return line_count < 4096
            end,
            window_border = "",
            margin = {
                top = 1,
            },
            minimap_width = 15,
        }
    end
}