return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    event = { "BufReadPost", "BufNewFile", "BufWritePost", "VeryLazy" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
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
        parser_config.phpdoc = {
            install_info = {
                url = '~/sources/treesitter/tree-sitter-phpdoc',
                files = {
                    'src/parser.c',
                    'src/scanner.c',
                },
                branch = "master",
                generate_requires_npm = true,
                requires_generate_from_grammar = true,
            },
            filetype = 'php',
        }

        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua", "vim", "vimdoc", "javascript", "typescript", "php", "html",
                "css", "bash", "sql", "regex", "markdown_inline", "markdown",
                "php_only"
            },
            sync_install = true,
            auto_install = true,
            ignore_install = {},
            highlight = { enable = true },
            indent = { enable = true },
            modules = {}
        })

        -- local bladeGrp
        -- vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
        -- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        --     pattern = "*.blade.php",
        --     group = bladeGrp,
        --     callback = function()
        --         vim.opt.filetype = "blade"
        --     end,
        -- })
    end
}
