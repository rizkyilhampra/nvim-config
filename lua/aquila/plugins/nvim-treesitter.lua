return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context"
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "php",
                "html",
                "css",
                "bash",
                "sql",
                "regex",
                "markdown_inline",
                "markdown",
                "php_only",
                "http",
                "json",
                "phpdoc",
                "hyprlang"
            },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = { enable = true },
            indent = { enable = true },
            modules = {}
        })

        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            generate_requires_npm = true,
            requires_generate_from_grammar = true,
            filetype = "blade"
        }

        vim.filetype.add({
            extension = {
                neon = 'yaml',
            },
            pattern = {
                ['.*%.blade%.php'] = 'blade',
                ['.*%.neon%.dist'] = 'yaml',
                ['.*/waybar/config'] = 'jsonc',
                ['.*/kitty/*.conf'] = 'bash',
                ['.*/hypr/.*%.conf'] = 'hyprlang'
            },
        })

        -- parser_config.phpdoc = {
        --     install_info = {
        --         url = '~/sources/treesitter/tree-sitter-phpdoc',
        --         files = {
        --             'src/parser.c',
        --             'src/scanner.c',
        --         },
        --         branch = "master",
        --         generate_requires_npm = true,
        --         requires_generate_from_grammar = true,
        --     },
        --     filetype = 'php',
        -- }
    end
}