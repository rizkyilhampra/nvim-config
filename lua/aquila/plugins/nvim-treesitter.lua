return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
            keys = {
                {
                    "<Leader>ct",
                    ':TSContextToggle<CR>',
                    desc = "Toggle treesitter context"
                }
            },

        }
    },
    event = "User BaseDefered",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "html",
                "css",
                "bash",
                "sql",
                "regex",
                "markdown_inline",
                "markdown",
                "php",
                "php_only",
                "phpdoc",
                "http",
                "json",
                "hyprlang"
            },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
        })

        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
                generate_requires_npm = true,
                requires_generate_from_grammar = true,
            },
            filetype = "blade"
        }

        vim.filetype.add({
            extension = {
                neon = 'yaml',
                ['http'] = 'http'
            },
            pattern = {
                ['.*%.neon%.dist'] = 'yaml',
                ['.*/waybar/config'] = 'jsonc',
                ['.*/kitty/*.conf'] = 'bash',
                ['.*/hypr/.*%.conf'] = 'hyprlang',
            },
        })
    end
}