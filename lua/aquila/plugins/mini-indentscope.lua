return {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        symbol = "│",
        options = {
            try_as_border = true
        }
    },
    config = function(_, opts)
        require("mini.indentscope").setup(opts)

        -- Disable for certain filetypes
        vim.api.nvim_create_autocmd({ "FileType" }, {
            desc = "Disable indentscope for certain filetypes",
            callback = function()
                local ignored_filetypes = {
                    "aerial",
                    "dashboard",
                    "help",
                    "lazy",
                    "leetcode.nvim",
                    "mason",
                    "neo-tree",
                    "NvimTree",
                    "neogitstatus",
                    "notify",
                    "startify",
                    "toggleterm",
                    "Trouble",
                    "calltree",
                    "coverage"
                }
                if vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
                    vim.b.miniindentscope_disable = true
                end
            end,
        })
    end
}
