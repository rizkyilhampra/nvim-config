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

        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade"
        }

        local bladeGrp
        vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
            pattern = "*.blade.php",
            group = bladeGrp,
            callback = function()
                vim.opt.filetype = "blade"
            end,
        })
    end
}
