return {
    "Isrothy/neominimap.nvim",
    lazy = false,
    init = function()
        vim.g.neominimap = {
            diagnostic = {
                enabled = false
            },
            auto_enable = true,
            buf_filter = function(bufnr)
                local line_count = vim.api.nvim_buf_line_count(bufnr)
                return line_count < 4096
            end,
            float = {
                z_index = 21,
                margin = {
                    top = 1,
                },
                window_border = "",
                minimap_width = 15,
            },
            search = {
                enabled = true

            },
            click = {
                enabled = true,
            }
        }
    end
}