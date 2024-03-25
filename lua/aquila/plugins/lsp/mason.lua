return {
    "williamboman/mason.nvim",
    lazy = true,
    keys = {
        { "<Leader>m", '<cmd>Mason<CR>', desc = 'Open Mason' }
    },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim"
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
                border = "rounded"
            }
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "phpactor",
                "lua_ls",
                "cssls",
                "html",
                "tsserver",
                "emmet_ls",
                "bashls",
                "marksman",
                "jsonls",
                "sqlls",
                "yamlls",
                "tailwindcss",
                "docker_compose_language_service",
                "dockerls",
            },
            automatic_installation = true
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "eslint_d",
                "prettierd",
                "selene",
                "phpstan",
            },
            auto_update = true,
            run_on_start = true
        })
    end
}