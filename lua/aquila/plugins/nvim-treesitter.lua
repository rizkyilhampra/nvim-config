return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
    },
    keys = {
        {
            "<Leader>ct",
            ':TSContextToggle<CR>',
            desc = "Toggle treesitter context"
        }
    },
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
            highlight = { enable = true },
            indent = { enable = true },
            modules = {},
            additional_vim_regex_highlighting = true,
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
    end
}