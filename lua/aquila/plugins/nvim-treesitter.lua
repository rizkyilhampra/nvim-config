return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "php",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "html",
                "css",
                "bash",
                "sql"
            },

            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
