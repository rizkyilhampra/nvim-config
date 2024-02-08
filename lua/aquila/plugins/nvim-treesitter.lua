return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    event = { "BufReadPost", "BufNewFile", "BufWritePost", "VeryLazy" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua", "vim", "vimdoc", "javascript", "typescript", "php", "html",
                "css", "bash", "sql", "regex", "markdown_inline", "markdown",
            },
            sync_install = true,
            auto_install = true,
            ignore_install = {},
            highlight = { enable = true },
            indent = { enable = true },
            modules = {}
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
